module ApplicationHelper

  def show_errors(errors, field)
    return if errors[field].empty?

    content_tag :p, class: 'text-danger' do
      concat(errors[field].join(', '))
    end
  end

  def name_and_phone(order)
    "#{order.name}<br/>#{order.phone}".html_safe
  end

  def address(order)
    main = "улица: #{order.street}, дом: #{ order.house }<br/> "
    entrance = order.entrance.present? ? "подъезд: #{ order.entrance }" : ''
    intercom = order.intercom.present? ? ", домофон: #{ order.intercom }" : ''
    floor = order.floor.present? ? ", эт: #{ order.floor }" : ''
    flat = order.flat.present? ? ", кв.: #{ order.flat }" : ''

    address = main + entrance + intercom + floor + flat
    address.html_safe
  end

end
