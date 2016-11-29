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

  def featured img, &block
    <<-HTML.strip_heredoc
      <header class='featured--header'>
        <div class='cover--wrapper' style= "background-image:url(#{img})">
          <div class='featured--info'>
            #{block.call}
          </div>
        </div>
      </header>
    HTML
  end
end
