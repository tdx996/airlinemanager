class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  scope :confirmed_users, -> { where(:confirmation_token => nil) }
  scope :unconfirmed_users, -> { where.not(:confirmation_token => nil) }

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :airline_id, presence: true

  belongs_to :airline
end
