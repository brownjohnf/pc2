class TicketCodesController < ApplicationController
  load_and_authorize_resource

  # GET /ticket_codes
  # GET /ticket_codes.json
  def index
    @ticket_codes = TicketCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ticket_codes }
    end
  end

  # GET /ticket_codes/1
  # GET /ticket_codes/1.json
  def show
    @ticket_code = TicketCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket_code }
    end
  end

  # GET /ticket_codes/new
  # GET /ticket_codes/new.json
  def new
    @ticket_code = TicketCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket_code }
    end
  end

  # GET /ticket_codes/1/edit
  def edit
    @ticket_code = TicketCode.find(params[:id])
  end

  # POST /ticket_codes
  # POST /ticket_codes.json
  def create
    @ticket_code = TicketCode.new(params[:ticket_code])

    respond_to do |format|
      if @ticket_code.save
        format.html { redirect_to @ticket_code, notice: 'Ticket code was successfully created.' }
        format.json { render json: @ticket_code, status: :created, location: @ticket_code }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ticket_codes/1
  # PUT /ticket_codes/1.json
  def update
    @ticket_code = TicketCode.find(params[:id])

    respond_to do |format|
      if @ticket_code.update_attributes(params[:ticket_code])
        format.html { redirect_to @ticket_code, notice: 'Ticket code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_codes/1
  # DELETE /ticket_codes/1.json
  def destroy
    @ticket_code = TicketCode.find(params[:id])
    @ticket_code.destroy

    respond_to do |format|
      format.html { redirect_to ticket_codes_url }
      format.json { head :no_content }
    end
  end
end
