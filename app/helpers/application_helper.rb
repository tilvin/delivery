module ApplicationHelper

  def show_errors(errors, field)
    return if errors[field].empty?

    content_tag :p, class: 'text-danger' do
      concat(errors[field].join(', '))
    end
  end

end
