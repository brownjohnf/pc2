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
    'Peace Corps Senegal'
  end

end
