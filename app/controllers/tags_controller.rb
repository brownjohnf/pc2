class TagsController < ApplicationController
  skip_authorization_check

  def index
    @tags = Array.new
    Document.tag_counts.each do |tag|
      @tags << tag.name
    end
    respond_to do |format|
      format.json { render json: @tags }
    end
  end

end
