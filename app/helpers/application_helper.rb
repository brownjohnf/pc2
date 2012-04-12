module ApplicationHelper

  # return a title on a per-page basis
  def title
    base_title = "Peace Corps #{country}"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def country
    'Senegal'
  end

  def avatar_for(object, options = { :size => :icon, :photo => 'blank.png' })
    sizes = { :icon => '80', :thumb => '100', :small => '200', :medium => '380', :large => '980', :full => '1140' }
    if object.photo.nil?
      options[:photo] ||= 'blank.png'
      link_to image_tag(options[:photo], :width => sizes[options[:size]]), object, :class => 'avatar'
    else
      options[:size] ||= :icon
      link_to image_tag(object.photo.photo.url(options[:size])), object, :class => 'avatar'
    end
  end

  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true).render(text).html_safe
  end

  def find_named_routes
    routes = []

    Rails.application.routes.named_routes.each do |name, route|
      req = route.requirements
      if req[:controller] == params[:controller] && req[:action] == params[:action]
        routes << name
      end
    end

    routes
  end

  def nested_li(objects)
    output = ""
    path = [nil]
    objects.each do |o|
      if o.parent_id != path.last
        # we are on a new level, did we descend or ascend?
        if path.include?(o.parent_id)
          # remove wrong wrong tailing paths elements
          while path.last != o.parent_id
            path.pop
            output += "\n</ul>"
          end
        else
          path << o.parent_id
          output += "\n<ul>"
        end
      end
      output += "\n<li>#{yield o}</li>"
    end
    #pop off unfinished paths elements
    while path.length > 1
      path.pop
      output += "\n</ul>"
    end
    return output.html_safe
  end

  def fetch_menu(country = 'SN')
    current_user.viewable_pages.order('title ASC').where("parent_id IS NULL AND country = ?", country)
  end

  def render_photo(id, size)
    image_tag((id.nil?) ? 'blank.png' : Photo.find(id).photo.url(size))
  end

  def photobar_selector
    Photo.limit(20)
  end

  def cloud_of_tags(model = params[:controller].singularize.camelcase.constantize)
    tags = model.tag_counts_on(:tags)
    render 'shared/tag_cloud', :tags => tags, :model => model
  end

  def icon(icon)
    icons = {
      :document_download => 'file_down.png',
      :document_upload => 'file_up.png',
      :photo => 'camera.png',
      :document => 'file_3.png',
      :user => 'user.png',
      :user_edit => 'engine.png',
      :library => 'book.png',
      :help => 'info.png',
      :comment => 'comment_2.png',
      :exit => 'error_1.png',
      :case_study_new => 'file_plus.png',
      :case_study => 'file_1.png',
      :page => 'file_2.png',
      :search => 'search.png',
      :clock => 'clock.png'
    }
    image_tag("icons/#{icons[icon]}", :class => 'icon')
  end
  
  def mime_icon(mime)
    icons = {
      'application/pdf' => 'pdf.png',
      'audio/mp3' => 'mp3.png'
    }
    image_tag("icons/#{icons[mime] ? icons[mime] : 'file_down.png'}", :class => 'icon')
  end
  
  def flag_icon(country_code)
    image_tag "icons/flags/64/#{country_code.downcase}.png", :style => 'height:1em;' if country_code
  end
  
  def rss_auto_links
    if params[:controller] == 'pages'
      auto_discovery_link_tag(:atom, feed_pages_path) + auto_discovery_link_tag(:rss, feed_pages_path)
    end
  end

  def allowed_countries
    {
      'SN' => 'Senegal'
    }
  end

  def change_units(to_convert, unit = :mb)
    units = {
      :mb => (1024 * 1024)
    }
    to_convert.to_i / units[unit].to_i
  end

end
