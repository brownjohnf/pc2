module DocumentsHelper

  def document_icon_for(document, size = 100)
    link_to image_tag('blank.png', :width => size), document, :class => 'avatar'
  end

end
