module DocumentsHelper

  def document_icon_for(document, options = { :size => :icon })
    sizes = { :icon => '80', :thumb => 100, :small => '200', :medium => '380', :large => '980', :full => '1140' }
    icons = {
      'application/pdf' => 'text/filetype_pdf.png',
      'audio/mp3' => 'audio/filetype_mp3.png',
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => 'text/filetype_doc.png'
    }
    link_to image_tag("icons/filetypes/#{icons[document.file_content_type] ? icons[document.file_content_type] : 'extras/filetype_blank.png'}", :width => sizes[options[:size]], :style => 'box-shadow: none; -moz-box-shadow: none; -webkit-box-shadow: none;'), document, :class => 'avatar'
  end

end
