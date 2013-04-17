class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  serialize :data, ActiveRecord::Coders::Hstore
  HSTORE_ATTR_NAMESPACE = 'attribute'
  %w[first_name last_name].each do |key|
    data_key = [HSTORE_ATTR_NAMESPACE,key].join('.')

    attr_accessible key

    define_method(key) do
      data && data[data_key]
    end

    define_method("#{key}=") do |value|
      self.data = (data || {}).merge(data_key => value)
    end
  end
end
