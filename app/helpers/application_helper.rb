module ApplicationHelper

  # return a title on a per-page basis
  def title
    base_title = "#{organization} #{country}"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def organization
    Setting.where(:property => 'organization').first.value
  end

  def country
    Setting.where(:property => 'country').first.value
  end

  def avatar_for(object, options = { :size => nil, :photo => 'blank.png' })
    if object.photo.nil?
      options[:size] ||= '100x100'
      options[:photo] ||= 'blank.png'
      link_to image_tag(options[:photo], :size => options[:size]), object, :class => 'avatar'
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

  def fetch_menu
    Page.unscoped.order('title ASC').where('parent_id IS NULL')
  end

  def render_photo(id, size)
    image_tag((id.nil?) ? 'blank.png' : Photo.find(id).photo.url(size))
  end

  def photobar_selector
    Photo.limit(20)
  end

  def cloud_of_tags(model = params[:controller].singularize.camelcase.constantize)
    tags = model.tag_counts_on(:tags)
    render 'shared/tag_cloud', :tags => tags
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
      :case_study => 'file_1.png'
    }
    image_tag("icons/#{icons[icon]}", :class => 'icon')
  end

end
