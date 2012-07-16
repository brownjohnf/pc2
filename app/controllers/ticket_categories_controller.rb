class TicketCategoriesController < ApplicationController
  load_and_authorize_resource
  # GET /ticket_categories
  # GET /ticket_categories.json
  def index
    @ticket_categories = TicketCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ticket_categories }
    end
  end

  # GET /ticket_categories/1
  # GET /ticket_categories/1.json
  def show
    @ticket_category = TicketCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket_category }
    end
  end

  # GET /ticket_categories/new
  # GET /ticket_categories/new.json
  def new
    @ticket_category = TicketCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket_category }
    end
  end

  # GET /ticket_categories/1/edit
  def edit
    @ticket_category = TicketCategory.find(params[:id])
  end

  # POST /ticket_categories
  # POST /ticket_categories.json
  def create
    @ticket_category = TicketCategory.new(params[:ticket_category])

    respond_to do |format|
      if @ticket_category.save
        format.html { redirect_to @ticket_category, notice: 'Ticket category was successfully created.' }
        format.json { render json: @ticket_category, status: :created, location: @ticket_category }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ticket_categories/1
  # PUT /ticket_categories/1.json
  def update
    @ticket_category = TicketCategory.find(params[:id])

    respond_to do |format|
      if @ticket_category.update_attributes(params[:ticket_category])
        format.html { redirect_to @ticket_category, notice: 'Ticket category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_categories/1
  # DELETE /ticket_categories/1.json
  def destroy
    @ticket_category = TicketCategory.find(params[:id])
    @ticket_category.destroy

    respond_to do |format|
      format.html { redirect_to ticket_categories_url }
      format.json { head :no_content }
    end
  end
end
