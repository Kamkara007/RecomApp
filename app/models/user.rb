class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable
  
  before_create :generate_invitation_code
  validates :first_name, :last_name, :email, presence: true, on: :step1
  validates :city_name, :school_name, :contact_1, :contact_2, presence: true, on: :step2
  validates :role_name, :password, presence: true, on: :step3

  validates :contact_1, :contact_2, format: { with: /\A(01|05|07)\d{8}\z/, message: 'must be a valid phone number' }, on: :step2


  def generate_invitation_code
    self.invitation_code = "#{('A'..'Z').to_a.sample}#{rand(100..999)}"
  end

  def invitation_link
    Rails.application.routes.url_helpers.accept_user_invitation_url(self, invitation_token: self.raw_invitation_token)
  end
end
