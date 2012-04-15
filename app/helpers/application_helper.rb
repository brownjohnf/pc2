module ApplicationHelper

  # @author John Brown
  # Returns a title on a per-page basis.
  #
  # @return [String] 'Peace Corps | X'
  #
  def title
    base_title = "Peace Corps #{country}"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  # @author John Brown
  # Returns preferred country for the site.
  #
  # @return [String] Senegal
  #
  def country
    'Senegal'
  end

  # @author John Brown
  # Given an object, attempts to locate a profile photo.
  #
  # @param [Object] object for which a photo is desired
  # @param [Symbol] size takes symbol: icon, thumb, small, medium, large, full
  # @param [Symbol] photo
  #
  # @return [String] anchor link wrapping the photo for the object, with class 'avatar'
  #
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

  # @author John Brown
  # Converts Markdown text to HTML.
  #
  # @param [String] Markdown
  #
  # @return [String] HTML
  #
  def markdown(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true).render(text).html_safe
  end

  # Locates all named routes.
  #
  # @return [Hash] routes
  #
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

  # Given a set of awesome-nested-set records, generates a set of nested ul/li HTML items.
  #
  # @param [Array] records
  #
  # @return [String] HTML set of nested, unordered lists
  #
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

  # @author John Brown
  # Find all top-level pages for a given country.
  #
  # @param [String] country defaults to 'SN'
  #
  # @return [Array] pages set of top-level pages (pages with no parent)
  #
  def fetch_menu(country = 'SN')
    current_user.viewable_pages.order('title ASC').where("parent_id IS NULL AND country = ?", country)
  end

  # @author John Brown
  # Retrieve a photo given an ID and size.
  #
  # @param [integer] id ID of photo
  # @param [Symbol] size size of photo
  #
  # @return [String] IMG tag
  #
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

  # @author John Brown
  # Defines countries allowed
  #
  # @return [hash] code=>name format
  #
  def allowed_countries
    {
      'Senegal' => 'SN'
    }
  end

  # @author John Brown
  # Converts file sizes in bytes to one of a selection of output sizes.
  # Defaults to megabytes
  #
  # @param [integer] to_convert the filesize in bytes
  # @return [integer] the value in the selected format
  #
  # @todo add other format options, and set an auto-selector if non specified
  #
  def change_units(to_convert, unit = :mb)
    units = {
      :mb => (1024 * 1024)
    }
    to_convert.to_i / units[unit].to_i
  end

end
