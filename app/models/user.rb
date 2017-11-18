class User < ApplicationRecord

  authenticates_with_sorcery!

  has_many :orders
  belongs_to :restaurant, optional: true

  enum role: { admin: 0, member: 1 }

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :role, presence: true
  validates :email, uniqueness: true

end
