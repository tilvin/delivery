class Order < ApplicationRecord

  before_create :set_token

  belongs_to :user
  belongs_to :restaurant
  belongs_to :point, optional: true

  enum state: { init: 0, accepted: 1 }

  validates :phone, :name, :street, :house, :user_id, :restaurant_id, presence: true

  def notify_delivery_service(order)
    order = self
    DeliveryServiceMailer.send_order(order).deliver
  end

  private

  def set_token
    self.token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex
      break token unless self.class.exists?(token: token)
    end
  end

end