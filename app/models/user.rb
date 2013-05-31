class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :user_logs

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessor :current_step, :presses
  validate :check_email_domain

  validates_presence_of :email, :if => lambda { |o| o.current_step == "first" }
  validates_presence_of :company, :if => lambda { |o| o.current_step == "second" }
  validates_presence_of :country, :if => lambda { |o| o.current_step == "second" }
  validates_presence_of :password, :if => lambda { |o| o.current_step == "second" }
  validates_presence_of :password_confirmation, :if => lambda { |o| o.current_step == "second" }


  has_many :jobs
  # attr_accessible :title, :body

  COUNTRIES = ["American Samoa", "Australia", "Brunei", "Cambodia", "China", "Hong Kong", "Indonesia", "Japan",
               "South Korea", "Laos", "Macau", "Malaysia", "Mongolia", "Myanmar", "New Zealand", "Pakistan",
               "Papua New Guinea", "Philipines", "Singapore", "Republic of China", "Thailand", "Timor-leste", "Vietnam"]

  serialize :data, ActiveRecord::Coders::Hstore
  #HSTORE_ATTR_NAMESPACE = 'attribute'
  %w[first_name last_name designation company department contact_number country current_step presses].each do |key|
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
    if !email.match(/@hp.com|@gmail.com|@hunus.co.kr|@monami.com|@acacia-it.com|@norde.com.ph|@sgn.rieckermann.com.vn|@redington.co.in|@jdcsl.com|@syntax.com.cn|@infotechcinia.com|@founder.com|@bjc.co.th|@wywy.com.my|@samafitro.co.id|@currico.com.au|@grandtech.com.tw|@syntaxhk.com.hk/) && Rails.env != 'test'
      errors.add(:email, " domain is not valid")
    end
  end

  def self.available_countries
    COUNTRIES.to_a
  end

  def self.remaining_job_percentage jobs
    remainder = 100
    if jobs
      jobs.each  do|job|
        remainder -= job.job_percentage
      end
    end
    remainder
  end

  def press_types
    presses = []
    self.presses.split(",").each do |press|
      presses.push(press.gsub(/[^0-9a-z ]/i, '').strip)
    end
    press_ids = []
    presses.each do |p|
      assoc_press = PressType.where(:name => p).first
      press_ids.push(assoc_press)
    end
    press_ids
  end

  def name
    self.email
  end
end

