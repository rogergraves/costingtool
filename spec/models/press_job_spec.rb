require 'spec_helper'

describe PressJob do

  before do
    Job.available_sizes.each {|size| FactoryGirl.create(:media, :name => size)}
  end

  def generate_ups_for inc_press_type
    Job.available_sizes.each_with_index do |value, index|
      FactoryGirl.create(:imposition, :press_type => inc_press_type, :job_size => value, :ups => (Job.available_sizes.length-index))
    end
  end

  let(:click_table) { FactoryGirl.create(:click_table_with_tier) }
  let(:job) { FactoryGirl.create(:job, :job_size => 'A4', :multicolor_clicks => 3, :black => 1) }
  let(:press_type) { FactoryGirl.create(:press_type, :click_table => click_table) }
  let(:press_job) { FactoryGirl.create(:press_job, :job => job, :press_type => press_type)}

  it "stores press_cost, media_cost, labor_cost, spi_cost, clicks_cost" do
    press_job.valid?.should be_true
  end

  context :cost_per_sheet do
    it "returns what is stored in Media if not present locally" do
      Media.find_by_name('A4').update_attributes(:cost_per_sheet => 0.50)
      press_job.cost_per_sheet.should == 0.50
    end

    it "allows overriding by user" do
      Media.find_by_name('A4').update_attributes(:cost_per_sheet => 0.50)
      press_job.cost_per_sheet.should == 0.50
      press_job.update_attributes(:cost_per_sheet => 2.00)
      press_job.reload.cost_per_sheet.should == 2.00
    end
  end

  context "relationships" do
    it "belongs to a jobs" do
      press_job.job.should == job
    end

    it "belongs to a press_type" do
      press_job.press_type.should == press_type
    end
  end

  context "calculations" do
    context "#calculated_spi_cost" do
      it "executes" do
        press_job.calculated_spi_cost.should == press_type.spi
      end
    end

    context "#calculated_media_cost" do
      context "preparation" do
        it "#cost_per_sheet" do
          cost = 1.00
          Job.available_sizes.each_index do |index|
            cost += 0.10
            Media.find_by_name(Job.available_sizes[index]).update_attributes(:cost_per_sheet => cost)
          end
          press_job.cost_per_sheet.should == Media.find_by_name(press_job.job_size).cost_per_sheet
        end

        it "#number_of_pages" do
          press_job.number_of_pages.should == job.number_of_pages
        end

        it "#copies_per_job" do
          press_job.copies_per_job.should == job.copies_per_job
        end

        it "#ups" do
          generate_ups_for press_type
          press_job.ups.should == press_type.impositions.find_by_job_size('A4').ups
        end

        it "#pages_per_month" do
          press_job.pages_per_month.should == job.pages_per_month
        end

        it "#plex" do
          press_job.plex.should == job.plex
        end

        it "#job_size" do
          press_job.job_size.should == job.job_size
        end

        it "#number_of_jobs" do
          press_job.number_of_jobs.should == job.number_of_jobs
        end

      end
      context "execution" do
        it "performs calculation correctly" do
          job_size = 'B2'
          number_of_jobs = 2000
          copies_per_job = 10
          plex = 1

          cost_per_sheet = 0.1
          number_of_pages = 50
          copies_per_month = number_of_jobs * copies_per_job
          ups = 1

          media_cost = cost_per_sheet * plex * number_of_pages * copies_per_month / ups

          FactoryGirl.create(:imposition, :press_type => press_type, :job_size => job_size, :ups => ups)
          Media.find_by_name(job_size).update_attributes(:cost_per_sheet => cost_per_sheet)
          job.update_attributes({
                                    :job_size => job_size,
                                    :number_of_jobs => number_of_jobs,
                                    :copies_per_job => copies_per_job,
                                    :number_of_pages => number_of_pages,
                                    :plex => plex,
                                })

          press_job.calculated_media_cost.should == media_cost
        end
      end
    end

    context "#calculated_clicks_cost" do
      context "preparation" do
        it "#multicolor_clicks" do
          press_job.multicolor_clicks.should == job.multicolor_clicks
        end

        it "#black" do
          press_job.black.should == job.black
        end

        it "#plex" do
          press_job.plex.should == job.plex
        end

        it "#number_of_sheets" do
          number_of_pages = 50
          job_size = 'B2'
          number_of_jobs = 2000
          copies_per_job = 10
          plex = 1
          ups = 1

          FactoryGirl.create(:imposition, :press_type => press_type, :job_size => job_size, :ups => ups)
          job.update_attributes({
                                    :job_size => job_size,
                                    :number_of_jobs => number_of_jobs,
                                    :copies_per_job => copies_per_job,
                                    :number_of_pages => number_of_pages,
                                    :plex => plex,
                                })

          number_of_sheets = (number_of_pages * number_of_jobs * copies_per_job / ups).ceil

          press_job.number_of_sheets.should == number_of_sheets
        end

        it "#all_job_pages_per_month" do
          job2 = FactoryGirl.create(:job, :user => job.user)
          job3 = FactoryGirl.create(:job, :user => job.user)
          FactoryGirl.create(:job) # Create some unrelated job with different user
          job_basket_pages_per_month = job.pages_per_month + job2.pages_per_month + job3.pages_per_month
          press_job.job_basket_pages_per_month.should == job_basket_pages_per_month
        end

        context "Tier pricing" do
          before do
            @black_tier_price = click_table.ink_arrays.first.tiers.first.black_price
            @color_tier_price = click_table.ink_arrays.first.tiers.first.price
            @click_price = (@color_tier_price * job.multicolor_clicks) + (@black_tier_price * job.black)
            @valid_ink_array =  click_table.ink_arrays.first
            @valid_tier = click_table.ink_arrays.first.tiers.first
          end

          context :clicks_cost do
            it "if not stored locally, calculates" do
              press_job.click_price.should == @click_price
            end
            it "can be overriden locally" do
              press_job.update_attributes(:click_price => (@click_price+2.00))
              press_job.reload.click_price.should == (@click_price+2.00)
            end
          end

          context "setup" do
            context "#tier" do
              context "with valid tier" do
                it "returns tier" do
                  press_job.tier.should == @valid_tier
                end
              end
              context "without valid tier" do
                it "returns nil" do
                  FactoryGirl.create(:press_job).tier.should be_nil
                end
              end
            end

            it "#ink_array" do
              press_job.ink_array.should == @valid_ink_array
            end

            it "#color_tier" do
              press_job.tier.should == @valid_tier
            end

            it "#tier_multicolor_price" do
              press_job.color_tier_price.should == @color_tier_price
            end

            it "#black_tier_price" do
              press_job.black_tier_price.should == @black_tier_price
            end
          end

          context "execution" do
            it '#calculated_clicks_cost' do
              generate_ups_for press_type
              press_job.reload
              calculated_clicks_cost = ((@black_tier_price * job.black) + (@color_tier_price * job.multicolor_clicks)) * press_job.number_of_sheets * job.plex
              press_job.calculated_clicks_cost.should == calculated_clicks_cost
            end

            it "#calculated_clicks_cost with a tier that has a nil value for :volume_range_end" do
              @valid_tier.update_attributes(:volume_range_end => nil)
              generate_ups_for press_type
              press_job.reload
              calculated_clicks_cost = ((@black_tier_price * job.black) + (@color_tier_price * job.multicolor_clicks)) * press_job.number_of_sheets * job.plex
              press_job.calculated_clicks_cost.should == calculated_clicks_cost
            end

            it "#calculated_clicks_cost with a ink array that has a nil value for :color_range_end" do
              @valid_ink_array.update_attributes(:color_range_end => nil)
              generate_ups_for press_type
              press_job.reload
              calculated_clicks_cost = ((@black_tier_price * job.black) + (@color_tier_price * job.multicolor_clicks)) * press_job.number_of_sheets * job.plex
              press_job.calculated_clicks_cost.should == calculated_clicks_cost
            end
          end
        end
      end
    end

    context "Supporting cost" do
      before do
        @black_tier_price = 1.00
        @color_tier_price = 2.00
        @click_price = (@color_tier_price * job.multicolor_clicks) + (@black_tier_price * job.black)

        # Make sure to let() objects instantiate
        click_table.valid?
        job.valid?
        press_type.valid?
        press_job.valid?

        FactoryGirl.create(:ink_array, :click_table => click_table, :color_range_start => job.multicolor_clicks-2, :color_range_end => job.multicolor_clicks-1)
        @valid_ink_array = FactoryGirl.create(:ink_array, :name => "Valid ink array", :click_table => click_table, :color_range_start => job.multicolor_clicks-1, :color_range_end => job.multicolor_clicks, :black => 1)
        FactoryGirl.create(:ink_array, :click_table => click_table, :color_range_start => job.multicolor_clicks+1, :color_range_end => job.multicolor_clicks+2)

        FactoryGirl.create(:tier, :ink_array => @valid_ink_array, :volume_range_start => 0, :volume_range_end => press_job.job_basket_pages_per_month-500)
        @valid_tier = FactoryGirl.create(:tier, :name => "Correct Tier", :ink_array => @valid_ink_array, :volume_range_start => press_job.job_basket_pages_per_month-499, :volume_range_end => press_job.job_basket_pages_per_month+500, :price => @color_tier_price, :black_price => @black_tier_price)
        FactoryGirl.create(:tier, :ink_array => @valid_ink_array, :volume_range_start => press_job.job_basket_pages_per_month+501, :volume_range_end => press_job.job_basket_pages_per_month+1000)

        job_size = 'B2'
        number_of_jobs = 2000
        copies_per_job = 10
        plex = 1

        cost_per_sheet = 0.1
        number_of_pages = 50
        copies_per_month = number_of_jobs * copies_per_job
        ups = 1

        Media.find_by_name(job_size).update_attributes(:cost_per_sheet => cost_per_sheet)
        job.update_attributes({
                                  :job_size => job_size,
                                  :number_of_jobs => number_of_jobs,
                                  :copies_per_job => copies_per_job,
                                  :number_of_pages => number_of_pages,
                                  :plex => plex,
                              })

        generate_ups_for press_type
        press_job.reload
      end

      it "#calculated_total_cost" do
        press_job.calculated_total_cost.should == (press_job.press_cost + press_job.calculated_media_cost + press_job.labor_cost + press_job.spi_cost + press_job.calculated_clicks_cost)
      end

      it "#calculated_cost_per_copy" do
        press_job.calculated_cost_per_copy.should == (press_job.calculated_total_cost / press_job.copies_per_month)
      end

      it "#calculated_cost_per_job" do
        press_job.calculated_cost_per_job.should == (press_job.calculated_total_cost / press_job.number_of_jobs)
      end

      context "dashboard graph data" do
        it "#press_cost" do
          press_job.press_cost.should == press_job.press_price/60
        end

        it "#spi_investment" do
          press_job.spi_investment.should == press_job.spi_cost * 7 * 12
        end

        it "#aggregated_job_monthly_cost" do
          press_job.aggregated_job_monthly_cost.should == (press_job.calculated_total_cost - press_job.press_cost - press_job.spi_cost)
        end

        it "#annual_growth" do
          press_job.annual_growth.should == press_job.job.annual_growth
        end

        it "#dashboard_graph_costs" do
          data = []
          last_year_aggregated_job_monthly_cost = press_job.aggregated_job_monthly_cost
          (1..7).each do |year|
            last_year_aggregated_job_monthly_cost = last_year_aggregated_job_monthly_cost + (last_year_aggregated_job_monthly_cost * press_job.annual_growth / 100) if year > 1
            data << [year, last_year_aggregated_job_monthly_cost.to_i]
          end

          data.to_s.should == press_job.dashboard_graph_costs
        end

        it "#sale_price" do
          press_job.sale_price.should == press_job.job.sale_price
        end

        it "#monthly_revenue" do
          press_job.monthly_revenue.should == press_job.number_of_jobs * press_job.sale_price
        end

        it "#annual_revenue" do
          press_job.annual_revenue.should == press_job.monthly_revenue * 12
        end

        context "#dashboard_graph_revenue" do
          let(:press_job_2) {FactoryGirl.create(:press_job, :job => FactoryGirl.create(:job, :user_id => press_job.job.user_id, :job_size => 'A3', :multicolor_clicks => 4, :black => 1), :press_type => press_type, :cost_per_sheet => 1.10)}

          it "with single press_job" do
            data = []
            last_year_revenue = press_job.annual_revenue
            (1..7).each do |year|
              last_year_revenue*= (1 + press_job.annual_growth.to_f / 100) if year > 1
              data << [year, last_year_revenue.round()]
            end

            data.to_s.should == press_job.dashboard_graph_revenue
          end

          it "with multiple press_jobs" do
            data = []
            press_job_1_last_year_revenue = press_job.annual_revenue
            press_job_2_last_year_revenue = press_job_2.annual_revenue
            (1..7).each do |year|
              if year > 1
                press_job_1_last_year_revenue*= (1 + press_job.annual_growth.to_f / 100)
                press_job_2_last_year_revenue*= (1 + press_job_2.annual_growth.to_f / 100)
              end

              data << [year, (press_job_1_last_year_revenue + press_job_2_last_year_revenue).round()]
            end

            press_job.dashboard_graph_revenue.should == data.to_s
          end
        end

        context "#press_type_press_jobs" do
          it "with single press_job" do
            press_job.press_type_press_jobs.first.should == press_job
          end

          it "with multiple press_jobs" do
            press_job.press_type_press_jobs.count.should == 1

            FactoryGirl.create(:press_job, :job => FactoryGirl.create(:job, :user_id => press_job.job.user_id, :job_size => 'A3', :multicolor_clicks => 4, :black => 1), :press_type => press_type, :cost_per_sheet => 1.10)

            press_job.reload.press_type_press_jobs!.count.should == 2
          end
        end

        context "Roi table" do
          before do
            press_job.valid?
          end

          def calculate_sum_revenues
            sum_revenues = 0
            last_year_revenue = press_job.annual_revenue
            (1..7).each do |year|
              last_year_revenue = last_year_revenue + (last_year_revenue * press_job.annual_growth / 100) if year > 1
              sum_revenues = sum_revenues + last_year_revenue
            end

            sum_revenues.round()
          end

          def calculate_sum_costs
            sum_costs = 0
            last_year_cost = press_job.aggregated_job_monthly_cost
            (1..7).each do |year|
              last_year_cost = last_year_cost + (last_year_cost * press_job.annual_growth / 100) if year > 1
              sum_costs = sum_costs + last_year_cost
            end

            sum_costs.round()
          end

          def calculate_net_profit
            calculate_sum_revenues - calculate_sum_costs
          end

          it "#sum_revenues" do
            press_job.sum_revenues.should == calculate_sum_revenues
          end

          it "#sum_costs" do
            press_job.sum_costs.should == calculate_sum_costs
          end

          it "#net_profit" do
            press_job.net_profit.should == (press_job.sum_revenues - press_job.sum_costs).round()
          end

          context "press methods" do
            let(:press_job_2) {FactoryGirl.create(:press_job, :job => FactoryGirl.create(:job, :user_id => press_job.job.user_id, :job_size => 'A3', :multicolor_clicks => 4, :black => 1), :press_type => press_type, :cost_per_sheet => 1.10)}

            it "#press_roi" do
              revenues = press_job_2.sum_revenues + press_job.sum_revenues
              costs = press_job_2.sum_costs + press_job.sum_costs

              press_job.press_roi.should == (100*(revenues - costs)/revenues).round()
            end

            it "#press_payback_period" do
              revenues = press_job_2.sum_revenues + press_job.sum_revenues
              net_profits = press_job_2.net_profit + press_job.net_profit

              press_job.press_payback_period.should == (12*(revenues / net_profits)).ceil
            end

            it "#press_total_profit" do
              net_profits = press_job_2.net_profit + press_job.net_profit

              press_job.press_total_profit.should == net_profits
            end

            it "#press_total_costs" do
              costs = press_job_2.sum_costs + press_job.sum_costs

              press_job.press_total_costs.should == costs
            end

            it "#press_production_life" do
              press_type.update_attributes(:production_life_months => 70)
              press_job.press_production_life.should == 70
            end
          end

        end
      end
    end

  end

end





