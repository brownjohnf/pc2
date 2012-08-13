class TagsController < ApplicationController
  skip_authorization_check

  # GET /tags
  def index
    @tags = Array.new
    Document.tag_counts.each do |tag|
      @tags << tag.name
    end
    respond_to do |format|
      format.html
      format.json { render json: @tags }
    end
  end

  # GET /tags/1
  def show
    @tag = params[:id]
    respond_to do |format|
      format.html
    end
  end

end
