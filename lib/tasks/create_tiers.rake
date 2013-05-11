namespace :app do
  task :create_tiers => :environment do
    t1 = ClicksLookupTable.create(:description => 'Tier Pricing - HP Indigo 10000 (EPM Enabled)')
    ClicksLookup.create(
        {
          :clicks_lookup_table_id => t1.id,
          :click_description => "Color (C, M, Y only) click pricing",
          :tier_label => "Tier 1",
          :color_range_start => 3,
          :color_range_end => 3,
          :black => 0,
          :volume_range_start => 0,
          :volume_range_end => 1500000,
          :price => 3.00
        }
    )
    ClicksLookup.create(
        {
          :clicks_lookup_table_id => t1.id,
          :click_description => "Color (C, M, Y only) click pricing",
          :tier_label => "Tier 2",
          :color_range_start => 3,
          :color_range_end => 3,
          :black => 0,
          :volume_range_start => 1500001,
          :volume_range_end => 4000000,
          :price => 2.50
        }
    )
    ClicksLookup.create(
        {
            :clicks_lookup_table_id => t1.id,
            :click_description => "Color (C, M, Y only) click pricing",
            :tier_label => "Tier 3",
            :color_range_start => 3,
            :color_range_end => 3,
            :black => 0,
            :volume_range_start => 4000001,
            :volume_range_end => 10000000,
            :price => 2.25
        }
    )
    ClicksLookup.create(
        {
            :clicks_lookup_table_id => t1.id,
            :click_description => "Color (C, M, Y only) click pricing",
            :tier_label => "Tier 4",
            :color_range_start => 3,
            :color_range_end => 3,
            :black => 0,
            :volume_range_start => 10000001,
            :price => 2.25
        }
    )
    ClicksLookup.create(
        {
            :clicks_lookup_table_id => t1.id,
            :click_description => "Black (K only) click Pricing",
            :tier_label => "Tier 1",
            :color_range_start => 0,
            :color_range_end => 0,
            :black => 1,
            :volume_range_start => 0,
            :volume_range_end => 10000000,
            :price => 1.00
        }
    )
    ClicksLookup.create(
        {
            :clicks_lookup_table_id => t1.id,
            :click_description => "Black (K only) click Pricing",
            :tier_label => "Tier 2",
            :color_range_start => 0,
            :color_range_end => 0,
            :black => 1,
            :volume_range_start => 10000001,
            :price => 0.95
        }
    )
    t1.reload
    puts "Added #{t1.description} lookup table with #{t1.clicks_lookups.length} tier entries!\n"
  end
end
