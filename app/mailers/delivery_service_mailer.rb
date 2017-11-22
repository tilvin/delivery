class DeliveryServiceMailer < ApplicationMailer

  def send_order(order)
    @order = order
    @recipients = User.where(role: 0)
    emails = @recipients.collect(&:email).join(",")
    mail(to: emails, subject: "Заказ № #{ @order.id } от #{ @order.restaurant.name }")
  end

  def order_changed(order)
    @order = order
    @recipients = User.where(restaurant: @order.restaurant)
    emails = @recipients.collect(&:email).join(",")
    mail(to: emails, subject: "Статус заказа № #{ @order.id } изменен на #{I18n.t("activerecord.attributes.order.state.#{@order.state}")}")
  end

end
