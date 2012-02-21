module DocumentsHelper

  def document_icon_for(document, options = { :size => :icon })
    sizes = { :icon => '80', :thumb => 100, :small => '200', :medium => '380', :large => '980', :full => '1140' }
    icons = {
      'application/pdf' => 'text/filetype_pdf.png',
      'audio/mp3' => 'audio/filetype_mp3.png'
    }
    link_to image_tag("icons/filetypes/#{icons[document.file_content_type]}", :width => sizes[options[:size]], :style => 'box-shadow: none;'), document, :class => 'avatar'
  end

end
