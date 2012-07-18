class TicketUpdatesController < ApplicationController
  load_and_authorize_resource
  # GET /ticket_updates
  # GET /ticket_updates.json
  def index
    @ticket_updates = TicketUpdate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ticket_updates }
    end
  end

  # GET /ticket_updates/1
  # GET /ticket_updates/1.json
  def show
    @ticket_update = TicketUpdate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket_update }
    end
  end

  # GET /ticket_updates/new
  # GET /ticket_updates/new.json
  def new
    @ticket_update = TicketUpdate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket_update }
    end
  end

  # GET /ticket_updates/1/edit
  def edit
    @ticket_update = TicketUpdate.find(params[:id])
  end

  # POST /ticket_updates
  # POST /ticket_updates.json
  def create
    @ticket_update = TicketUpdate.new(params[:ticket_update])

    respond_to do |format|
      if @ticket_update.save
        format.html { redirect_to @ticket_update, notice: 'Ticket update was successfully created.' }
        format.json { render json: @ticket_update, status: :created, location: @ticket_update }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ticket_updates/1
  # PUT /ticket_updates/1.json
  def update
    @ticket_update = TicketUpdate.find(params[:id])

    respond_to do |format|
      if @ticket_update.update_attributes(params[:ticket_update])
        format.html { redirect_to @ticket_update, notice: 'Ticket update was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_updates/1
  # DELETE /ticket_updates/1.json
  def destroy
    @ticket_update = TicketUpdate.find(params[:id])
    @ticket_update.destroy

    respond_to do |format|
      format.html { redirect_to ticket_updates_url }
      format.json { head :no_content }
    end
  end
end
