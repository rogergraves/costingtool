class DeleteOrphanTiers < ActiveRecord::Migration
  def change

    InkArray.all.each do |ink_array|
      ink_array.destroy unless ink_array.click_table.present?
    end

    Tier.all.each do |tier|
      tier.destroy unless tier.ink_array.present?
    end

  end
end
