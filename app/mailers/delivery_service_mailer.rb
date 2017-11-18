class DeliveryServiceMailer < ApplicationMailer

  def send_order(order)
    @order = order
    @recipients = User.where(role: 0)
    emails = @recipients.collect(&:email).join(",")
    mail(to: emails, subject: "Заказ № #{ @order.id } от #{ @order.restaurant.name }")
  end
end
