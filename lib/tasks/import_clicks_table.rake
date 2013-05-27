namespace :app do
  task :reset_click_tables do
    ClickTable.destroy_all

    desc 'Tiered Pricing -72xx'
    table1 = ClickTable.create(:name => 'Tiered Pricing -72xx', :description => 'Tiered Pricing -72xx')
    desc 'Create ink arrays'
    table1_array1 = InkArray.create(:click_table_id => table1.id, :name => 'Multicolor',
                                    :color_range_start => 1, :color_range_end => nil, :black => 0)
    table1_array2 = InkArray.create(:click_table_id => table1.id, :name => '2 Color',
                                    :color_range_start => 1, :color_range_end => 2, :black => 0)
    table1_array3 = InkArray.create(:click_table_id => table1.id, :name => '1 Color',
                                    :color_range_start => 1, :color_range_end => 1, :black => 0)
    desc 'Create tiers for ink array'
    table1_array1_tier1 = Tier.create(:ink_array_id => table1_array1.id, :name => 'Tier 1', :volume_range_start => 0,
                                      :volume_range_end => 10000000, :price => 0.0117647058823529)
    table1_array1_tier2 = Tier.create(:ink_array_id => table1_array1.id, :name => 'Tier 2',
                                      :volume_range_start => 10000001,
                                      :volume_range_end => nil, :price => 0.0105882352941176)
    table1_array2_tier1 = Tier.create(:ink_array_id => table1_array2.id, :name => 'Tier 1', :volume_range_start => 0,
                                      :volume_range_end => nil, :price => 0.00941176470588235)
    table1_array3_tier1 = Tier.create(:ink_array_id => table1_array3.id, :name => 'Tier 1', :volume_range_start => 0,
                                      :volume_range_end => nil, :price => 0.00705882352941176)




    desc 'Create clicks table HP Indigo 10000 (EPM enabled)'
    table2 = ClickTable.create(:name => 'Indigo 10000', :description => 'Tiered Pricing for the HP Indigo 10000 (EPM
enabled)')
    desc 'Create ink arrays'
    table2_array1 = InkArray.create(:click_table_id => table2.id, :name => 'Multicolor',
                                    :color_range_start => 1, :color_range_end => nil, :black => 0)
    table2_array2 = InkArray.create(:click_table_id => table2.id, :name => 'Black (K only)',
                                    :color_range_start => nil, :color_range_end => nil, :black => 1)
    desc 'Create tiers for ink array'
    table2_array1_tier1 = Tier.create(:ink_array_id => table2_array1.id, :name => 'Tier 1', :volume_range_start => 0,
                                      :volume_range_end => 1500000, :price => 0.03)
    table2_array1_tier2 = Tier.create(:ink_array_id => table2_array1.id, :name => 'Tier 2',
                                      :volume_range_start => 1500001,
                                      :volume_range_end => 4000000, :price => 0.0250)
    table2_array1_tier3 = Tier.create(:ink_array_id => table2_array1.id, :name => 'Tier 3',
                                      :volume_range_start => 4000001,
                                      :volume_range_end => 10000000, :price => 0.0225)
    table2_array1_tier4 = Tier.create(:ink_array_id => table2_array1.id, :name => 'Tier 4',
                                      :volume_range_start => 10000001,
                                      :volume_range_end => nil, :price => 0.0195)
    table2_array2_tier1 = Tier.create(:ink_array_id => table2_array2.id, :name => 'Tier 1',
                                      :volume_range_start => 0,
                                      :volume_range_end => 10000000, :price => 0.0100)
    table2_array2_tier2 = Tier.create(:ink_array_id => table2_array2.id, :name => 'Tier 2',
                                      :volume_range_start => 10000001,
                                      :volume_range_end => nil, :price => 0.0095)

    desc 'Tier Pricing - All series 2 & 3 presses: 3xxx, 4xxx, 5xxx, 6xxx, 7000, 7500, 7600 Textured Print*,
EPM* & One-shot Printing *, Digital Watermark'
    table3 = ClickTable.create(:name => 'Series 2 & 3 Presses', :description => 'All series 2 & 3 presses: 3xxx, 4xxx, 5xxx, 6xxx, 7000, 7500, 7600 Textured Print*,
EPM* & One-shot Printing*, Digital Watermark')

    desc 'Create ink arrays'
    table3_array1 = InkArray.create(:click_table_id => table3.id, :name => 'Multicolor',
                                    :color_range_start => 1, :color_range_end => nil, :black => 0)
    desc 'Create tiers for ink array'



  end
end