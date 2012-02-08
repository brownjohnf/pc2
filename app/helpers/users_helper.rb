module UsersHelper

  def avatar_for_user(user, options = { :size => :icon } )
    sizes = { :icon => '80', :thumb => '100', :small => '200', :medium => '380', :large => '980', :full => '1140' }
    if user.avatar?
      link_to image_tag(user.avatar.url(options[:size])), user, :class => 'avatar'
    else
      gravatar_for(user, :size => sizes[options[:size]])
    end
  end

  def gravatar_for(user, options = { :size => 50 })
    link_to gravatar_image_tag(user.email.downcase, :alt => user.name, :width => options[:size], :height => options[:size], :gravatar => options), user, :class => 'avatar'
  end

end
