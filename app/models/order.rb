class Order < ApplicationRecord

  before_create :set_token

  has_paper_trail

  belongs_to :user
  belongs_to :restaurant
  belongs_to :point, optional: true

  enum state: { init: 0, accepted: 1, courier_assigned: 2, delivering: 3, done: 4, deny: 5 }

  validates :phone, :name, :street, :house, :user_id, :restaurant_id, presence: true

  def notify_delivery_service(order)
    order = self
    DeliveryServiceMailer.send_order(order).deliver
  end

  def notify_restaurant(order)
    order = self
    DeliveryServiceMailer.order_changed(order).deliver
  end

  def head_info
    created_time = "Заказ № #{ id } от #{ created_at.strftime('%d.%m.%Y %H:%M')}"
    by_time = ''
    if by_time.present?
      by_time = ко времени "#{ by_time.strftime('%H:%M') }"
    end
    @info = created_time + by_time
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
