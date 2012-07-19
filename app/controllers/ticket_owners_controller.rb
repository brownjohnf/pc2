class TicketOwnersController < ApplicationController
  load_and_authorize_resource

  # GET /ticket_owners
  # GET /ticket_owners.json
  def index
    @ticket_owners = TicketOwner.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ticket_owners }
    end
  end

  # GET /ticket_owners/1
  # GET /ticket_owners/1.json
  def show
    @ticket_owner = TicketOwner.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket_owner }
    end
  end

  # GET /ticket_owners/new
  # GET /ticket_owners/new.json
  def new
    @ticket_owner = TicketOwner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket_owner }
    end
  end

  # GET /ticket_owners/1/edit
  def edit
    @ticket_owner = TicketOwner.find(params[:id])
  end

  # POST /ticket_owners
  # POST /ticket_owners.json
  def create
    @ticket_owner = TicketOwner.new(params[:ticket_owner])

    respond_to do |format|
      if @ticket_owner.save
        format.html { redirect_to @ticket_owner, notice: 'Ticket Owner was successfully created.' }
        format.json { render json: @ticket_owner, status: :created, location: @ticket_owner }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ticket_owners/1
  # PUT /ticket_owners/1.json
  def update
    @ticket_owner = TicketOwner.find(params[:id])

    respond_to do |format|
      if @ticket_owner.update_attributes(params[:ticket_owner])
        format.html { redirect_to @ticket_owner, notice: 'Ticket Owner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket_owner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_owners/1
  # DELETE /ticket_owners/1.json
  def destroy
    @ticket_owner = TicketOwner.find(params[:id])
    @ticket_owner.destroy

    respond_to do |format|
      format.html { redirect_to ticket_owners_url }
      format.json { head :no_content }
    end
  end
end
