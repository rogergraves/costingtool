class PressTypeCostService < PressTypeCost
  VALID_DESCRIPTIONS = ["Monthly"]

  validates :description, :inclusion => { :in => VALID_DESCRIPTIONS, :message => "%{value} must be one of:
"+VALID_DESCRIPTIONS.join(", ") }


  def description_is_valid?
    !!VALID_DESCRIPTIONS.find_index(self.description)
  end
end
