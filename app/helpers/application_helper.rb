require 'kramdown'

module ApplicationHelper
  def address_for address
    a = []
    a << address.street
    a << [address.city, address.region, address.postal_code].compact.join(', ')
    a.compact.join('<br/>')
  end

  def markdown text
    Kramdown::Document.new(text).to_html
  end

  def badge_for_rating rating
    case rating.to_i
    when 4..5
      'badge-success'
    when 3
      'badge-warning'
    else
      'badge-danger'
    end
  end
end
