require 'spec_helper'

describe PressJob do
  let(:job) { FactoryGirl.create(:job, :job_size => 'A4', ) }
  let(:press_type) { FactoryGirl.create(:press_type) }
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

  context "calculation" do

    context "preparation" do

      it "#cost_per_sheet" do
        cost = 1.00
        Job.available_sizes.each do
          cost += 0.10
          FactoryGirl.create(:media, :cost_per_sheet => cost)
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
                                  :plex => 1,
                              })

        press_job.calculated_media_cost.should == media_cost
      end
    end
  end

end





