require 'spec_helper'

describe PressJob do
  let(:click_table) { FactoryGirl.create(:click_table) }
  let(:job) { FactoryGirl.create(:job, :job_size => 'A4', :multicolor_clicks => 3) }
  let(:press_type) { FactoryGirl.create(:press_type, :click_table => click_table) }
  let(:press_job) { FactoryGirl.create(:press_job, :job => job, :press_type => press_type)}

  it "stores press_cost, media_cost, labor_cost, spi_cost and clicks_cost" do
    press_job.valid?.should be_true
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
            FactoryGirl.create(:media, :cost_per_sheet => cost, :name => Job.available_sizes[index])
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
          Job.available_sizes.each_with_index do |value, index|
            FactoryGirl.create(:imposition, :press_type => press_type, :job_size => value, :ups => (Job.available_sizes.length-index))
          end

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
          FactoryGirl.create(:media, :name => job_size, :cost_per_sheet => cost_per_sheet)
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
          number_of_sheets = (number_of_pages * number_of_jobs * copies_per_job / ups).ceil

          FactoryGirl.create(:imposition, :press_type => press_type, :job_size => job_size, :ups => ups)
          job.update_attributes({
                                    :job_size => job_size,
                                    :number_of_jobs => number_of_jobs,
                                    :copies_per_job => copies_per_job,
                                    :number_of_pages => number_of_pages,
                                    :plex => plex,
                                })

          press_job.number_of_sheets.should == number_of_sheets
        end

        it "#all_job_pages_per_month" do
          job2 = FactoryGirl.create(:job, :user => job.user)
          job3 = FactoryGirl.create(:job, :user => job.user)
          FactoryGirl.create(:job) # Create some unrelated job with different user
          job_basket_pages_per_month = job.pages_per_month + job2.pages_per_month + job3.pages_per_month
          press_job.job_basket_pages_per_month.should == job_basket_pages_per_month
        end

        it "#tier_multicolor_price" do
          FactoryGirl.create(:ink_array, :click_table => click_table, :color_range_start => job.multicolor_clicks-2, :color_range_end => job.multicolor_clicks-1)
          valid_ink_array = FactoryGirl.create(:ink_array, :description => "Valid ink array", :click_table => click_table, :color_range_start => job.multicolor_clicks-1, :color_range_end => job.multicolor_clicks)
          FactoryGirl.create(:ink_array, :click_table => click_table, :color_range_start => job.multicolor_clicks+1, :color_range_end => job.multicolor_clicks+2)

          FactoryGirl.create(:tier, :ink_array => valid_ink_array, :volume_range_start => 0, :volume_range_end => press_job.job_basket_pages_per_month-500)
          valid_tier = FactoryGirl.create(:tier, :label => "Correct Tier", :ink_array => valid_ink_array, :volume_range_start => press_job.job_basket_pages_per_month-499, :volume_range_end => press_job.job_basket_pages_per_month+500, :price => 2.00)
          FactoryGirl.create(:tier, :ink_array => valid_ink_array, :volume_range_start => 0, :volume_range_end => press_job.job_basket_pages_per_month+501, :volume_range_end => press_job.job_basket_pages_per_month+1000)

          press_job.click_table.should == click_table
          press_job.ink_array.should == valid_ink_array
          ap press_job.ink_array
        end

        it "#tier_black_price"

      end
      context "execution"
    end

  end

end





