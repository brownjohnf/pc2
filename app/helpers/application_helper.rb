module ApplicationHelper

  mdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)

  # return a title on a per-page basis
  def title
    base_title = 'Peace Corps Senegal'
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def organization
    'Peace Corps'
  end

  def country
    'Senegal'
  end

  def gravatar_for(user, options = { :size => 50 })
    link_to gravatar_image_tag(user.email.downcase, :alt => user.name, :gravatar => options), 'http://gravatar.com/emails', :class => 'gravatar', :target => '_blank'
  end

  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true).render(text).html_safe
  end

end
