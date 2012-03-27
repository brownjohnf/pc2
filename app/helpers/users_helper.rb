module UsersHelper

  def avatar_for_user(user, options = { :size => :icon } )
    sizes = { :icon => '80', :thumb => '100', :small => '200', :medium => '380', :large => '980', :full => '1140' }
    if user.avatar?
      image_tag user.avatar.url(options[:size]), :class => 'avatar'
    else
      gravatar_for(user, :size => sizes[options[:size]])
    end
  end

  def gravatar_for(user, options = { :size => 50 })
    options[:d] = 'mm'
    gravatar_image_tag user.email.downcase, :alt => user.name, :width => options[:size], :height => options[:size], :gravatar => options, :class => 'avatar'
  end

end
