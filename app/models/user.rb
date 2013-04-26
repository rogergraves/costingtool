class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  validate :check_email_domain
  has_many :jobs
  # attr_accessible :title, :body

  COUNTRIES = ["American Samoa", "Australia", "Brunei", "Cambodia", "China", "Hong Kong", "Indonesia", "Japan",
               "South Korea", "Laos", "Macau", "Malaysia", "Mongolia", "Myanmar", "New Zealand", "Pakistan",
               "Papua New Guinea", "Philipines", "Singapore", "Republic of China", "Thailand", "Timor-leste", "Vietnam"]

  serialize :data, ActiveRecord::Coders::Hstore
  #HSTORE_ATTR_NAMESPACE = 'attribute'
  %w[first_name last_name designation company department contact_number country].each do |key|
    attr_accessible key

    define_method(key) do
      data && data[key]
    end

    define_method("#{key}=") do |value|
      self.data = (data || {}).merge(key => value)
    end
  end

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  def check_email_domain
    if !email.match(/@hp.com|@gmail.com/)
      errors.add(:email, " domain is not valid")
    end
  end
end

