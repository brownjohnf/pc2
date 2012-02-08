module DocumentsHelper

  def document_icon_for(document, options = { :size => :icon })
    sizes = { :icon => '80', :thumb => 100, :small => '200', :medium => '380', :large => '980', :full => '1140' }
    link_to image_tag('blank.png', :width => sizes[options[:size]]), document, :class => 'avatar'
  end

end
