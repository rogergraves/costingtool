namespace :app do
  task :reset_click_tables => :environment do
    ClickTable.destroy_all
    PressType.destroy_all
    Imposition.destroy_all

    #PressType.all.each do |press_type|
    #  press_type.update_attributes(:click_table_id => nil)
    #end


    puts 'Adding... Click Tables...  72xx'
    table1 = ClickTable.create(:name => '72xx Click Pricing', :description => 'Tiered Pricing for -72xx')

    puts 'Create 72xx ink arrays...'
    table1_array1 = InkArray.create(:click_table_id => table1.id, :name => 'Multicolor', :color_range_start => 1, :color_range_end => 6, :black => 0)
    table1_array2 = InkArray.create(:click_table_id => table1.id, :name => '2 Color', :color_range_start => 1, :color_range_end => 2, :black => 0)
    table1_array3 = InkArray.create(:click_table_id => table1.id, :name => '1 Color', :color_range_start => 1, :color_range_end => 1, :black => 0)

    puts 'Create tiers for 72xx ink array...'
    table1_array1_tier1 = Tier.create(:ink_array_id => table1_array1.id, :name => 'Tier 1', :volume_range_start => 0, :volume_range_end => 10000000, :price => 0.0117647058823529)
    table1_array1_tier2 = Tier.create(:ink_array_id => table1_array1.id, :name => 'Tier 2', :volume_range_start => 10000001,  :volume_range_end => 999999999, :price => 0.0105882352941176)

    table1_array2_tier1 = Tier.create(:ink_array_id => table1_array2.id, :name => 'Tier 1', :volume_range_start => 0, :volume_range_end => 999999999, :price => 0.00941176470588235)

    table1_array3_tier1 = Tier.create(:ink_array_id => table1_array3.id, :name => 'Tier 1', :volume_range_start => 0, :volume_range_end => 999999999, :price => 0.00705882352941176)




    puts 'Create clicks table HP Indigo 10000 (EPM enabled)...'
    table2 = ClickTable.create(:name => 'Indigo 10000', :description => 'Tiered Pricing for the HP Indigo 10000 (EPM enabled)')

    puts 'Create ink arrays...HP 10000'
    table2_array1 = InkArray.create(:click_table_id => table2.id, :name => 'Multicolor', :color_range_start => 1, :color_range_end => 6, :black => 0)
    table2_array2 = InkArray.create(:click_table_id => table2.id, :name => 'Black (K only)', :color_range_start => 1, :color_range_end =>6 , :black => 1)


    puts 'Create tiers for ink array...HP 10000'
    table2_array1_tier1 = Tier.create(:ink_array_id => table2_array1.id, :name => 'Tier 1', :volume_range_start => 0, :volume_range_end => 1500000, :price => 0.030)
    table2_array1_tier2 = Tier.create(:ink_array_id => table2_array1.id, :name => 'Tier 2', :volume_range_start => 1500001, :volume_range_end => 4000000, :price => 0.0250)
    table2_array1_tier3 = Tier.create(:ink_array_id => table2_array1.id, :name => 'Tier 3', :volume_range_start => 4000001, :volume_range_end => 10000000, :price => 0.0225)
    table2_array1_tier4 = Tier.create(:ink_array_id => table2_array1.id, :name => 'Tier 4', :volume_range_start => 10000001, :volume_range_end => 99, :price => 0.0195)


    table2_array2_tier1 = Tier.create(:ink_array_id => table2_array2.id, :name => 'Tier 1', :volume_range_start => 0, :volume_range_end => 10000000, :price => 0, :black_price => 0.0100)
    table2_array2_tier2 = Tier.create(:ink_array_id => table2_array2.id, :name => 'Tier 2', :volume_range_start => 10000001, :volume_range_end => 99, :price => 0, :black_price => 0.0095)

    puts 'Create Click Tables ...Series 2 & 3 presses'
    table3 = ClickTable.create(:name => 'Series 2 & 3 Presses', :description => 'Tier pricing for all series 2 & 3 presses, including: 3xxx, 4xxx, 5xxx, 6xxx, 7000, 7500, 7600 Textured Print*, EPM* & One-shot Printing*, Digital Watermark')

    puts 'Create ink arrays...Series 2 & 3 presses'
    table3_array1 = InkArray.create(:click_table_id => table3.id, :name => 'Multicolor', :color_range_start => 1, :color_range_end => 99, :black => 0)

    table3_array2 = InkArray.create(:click_table_id => table3.id, :name => '1 Color Raised Printing', :color_range_start => 1, :color_range_end => 99, :black => 1)
    table3_array3 = InkArray.create(:click_table_id => table3.id, :name => '2 Color & Light Black', :color_range_start => 1, :color_range_end => 2, :black => 1)
    table3_array4 = InkArray.create(:click_table_id => table3.id, :name => 'Multicolor - EPM', :color_range_start => 3, :color_range_end => 3, :black => 0)


    puts 'Create tiers for ink array...Series 2 & 3 presses'
    table3_array1_tier1 = Tier.create(:ink_array_id => table3_array1.id, :name => 'Tier 1', :volume_range_start => 0, :volume_range_end => 300000, :price => 0.0225)
    table3_array1_tier2 = Tier.create(:ink_array_id => table3_array1.id, :name => 'Tier 2', :volume_range_start => 300001, :volume_range_end => 600000, :price => 0.0019)
    table3_array1_tier3 = Tier.create(:ink_array_id => table3_array1.id, :name => 'Tier 3', :volume_range_start => 600001, :volume_range_end => 1200000, :price => 0.0017)
    table3_array1_tier4 = Tier.create(:ink_array_id => table3_array1.id, :name => 'Tier 4', :volume_range_start => 1200001, :volume_range_end => 2400000, :price => 0.0150)
    table3_array1_tier5 = Tier.create(:ink_array_id => table3_array1.id, :name => 'Tier 5', :volume_range_start => 2400001, :volume_range_end => 3600000, :price => 0.0138)
    table3_array1_tier6 = Tier.create(:ink_array_id => table3_array1.id, :name => 'Tier 6', :volume_range_start => 3600001, :volume_range_end => 99, :price => 0.0125)


    table3_array2_tier1 = Tier.create(:ink_array_id => table3_array2.id, :name => 'Tier 1', :volume_range_start => 0, :volume_range_end => 99, :price => 0, :black_price => 0.009)


    table3_array3_tier1 = Tier.create(:ink_array_id => table3_array3.id, :name => 'Tier 1', :volume_range_start => 0, :volume_range_end => 99, :price => 0, :black_price => 0.0101)


    table3_array4_tier1 = Tier.create(:ink_array_id => table3_array4.id, :name => 'EPM', :volume_range_start => 0, :volume_range_end => 1200000, :price => 0.0225)


    puts 'Creating Press Types... 5600, 7600, W7250, & 10000'
    table4 = PressType.create(:name => 'HP Indigo 5600 Digital Press', :duty_cycle => 5000000, :spi => 3000, :click_table_id => table3.id)

    table5 = PressType.create(:name => 'HP Indigo 7600 Digital Press', :duty_cycle => 5000000, :spi => 4000, :click_table_id => table3.id)

    #table6 = PressType.create(:name => 'HP Indigo W7250 Digital Press', :duty_cycle => 10000000, :spi => 7100, :click_table_id => table1.id)

    table7 = PressType.create(:name => 'HP Indigo 10000 Digital Press', :duty_cycle => 10000000, :spi => 6000, :click_table_id => table2.id)


    puts 'Creating Impositions for HP Indigo 5600 Digital Press'
    table8 = Imposition.create(:press_type_id => table4.id, :job_size => '6"x9"', :ups => 2)
    table9 = Imposition.create(:press_type_id => table4.id, :job_size => '7"x10"', :ups => 2)
    table10 = Imposition.create(:press_type_id => table4.id, :job_size => 'A5', :ups => 4)
    table11 = Imposition.create(:press_type_id => table4.id, :job_size => 'A4', :ups => 2)
    table12 = Imposition.create(:press_type_id => table4.id, :job_size => 'A3', :ups => 1)
    table13 = Imposition.create(:press_type_id => table4.id, :job_size => 'B2', :ups => 0)

    puts 'Creating Impositions for HP Indigo 7600 Digital Press'
    table14 = Imposition.create(:press_type_id => table5.id, :job_size => '6"x9"', :ups => 2)
    table15 = Imposition.create(:press_type_id => table5.id, :job_size => '7"x10"', :ups => 2)
    table16 = Imposition.create(:press_type_id => table5.id, :job_size => 'A5', :ups => 4)
    table17 = Imposition.create(:press_type_id => table5.id, :job_size => 'A4', :ups => 2)
    table18 = Imposition.create(:press_type_id => table5.id, :job_size => 'A3', :ups => 1)
    table19 = Imposition.create(:press_type_id => table5.id, :job_size => 'B2', :ups => 0)

    puts 'Creating Impositions for HP Indigo 10000 Digital Press'
    table20 = Imposition.create(:press_type_id => table7.id, :job_size => '6"x9"', :ups => 6)
    table21 = Imposition.create(:press_type_id => table7.id, :job_size => '7"x10"', :ups => 5)
    table22 = Imposition.create(:press_type_id => table7.id, :job_size => 'A5', :ups => 9)
    table23 = Imposition.create(:press_type_id => table7.id, :job_size => 'A4', :ups => 4)
    table24 = Imposition.create(:press_type_id => table7.id, :job_size => 'A3', :ups => 2)
    table25 = Imposition.create(:press_type_id => table7.id, :job_size => 'B2', :ups => 1)

    puts '***...end of reset...***'

  end
end