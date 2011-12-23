module ApplicationHelper

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
    link_to gravatar_image_tag(user.email.downcase, :alt => user.name, :class => 'gravatar', :gravatar => options), '', :id => 'gravatar'
  end

end
