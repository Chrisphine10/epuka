class User < ActiveRecord::Base
	rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at
  # attr_accessible :title, :body
	has_many :diseases
	has_many :blogs
	has_many :domains

	validates_presence_of :name
	validates_uniqueness_of :name, :email, :case_sensitive => false

	validate :email_domain_registration

	private
	def email_domain_registration
		domain = email.split('@') #split string with “@”
    errors.add(:email, "domain not registered. Contact admin") if
      Domain.find_by_name(domain[1].to_s).nil? == true
  end
end
