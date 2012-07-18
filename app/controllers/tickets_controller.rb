class TicketsController < ApplicationController
  load_and_authorize_resource

  # GET /tickets
  # GET /tickets.json
  def index
    @user = User.find(params[:user_id])
    @tickets = @user.received_tickets + @user.sent_tickets


    respond_to do |format|
      format.html { render :layout => 'layouts/application-fluid' } # index.html.erb
      format.json { render json: @tickets }
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @user = User.find(params[:user_id])
    @ticket = Ticket.find(params[:id])
    @ticket.ticket_owners.build
    @ticket.ticket_updates.build

    respond_to do |format|
      format.html { render :layout => 'layouts/application-fluid' } # show.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.json
  def new
    @user = User.find(params[:user_id])
    @ticket = Ticket.new
    @ticket.ticket_owners.build
    @ticket.ticket_updates.build

    respond_to do |format|
      format.html { render :layout => 'layouts/application-fluid' } # new.html.erb
      format.json { render json: @ticket }
    end
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @user = User.find(params[:user_id])
    @ticket = Ticket.new(params[:ticket])
    @ticket.ticket_owners.first.from_id = @user.id
    @ticket.ticket_updates.build(:user_id => @user.id)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to [@user, @ticket], notice: 'Ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1
  # PUT /tickets/1.json
  def update
    @user = User.find(params[:user_id])
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to user_tickets_path(@user), notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end
end
