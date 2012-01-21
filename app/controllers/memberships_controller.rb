class MembershipsController < ApplicationController

  before_filter :authenticate #sessions helper

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
    @title = 'Listing Memberships'
    @context_menu = {'new' => new_membership_path}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @memberships }
    end
  end

  # GET /memberships/new
  # GET /memberships/new.json
  def new
    @membership = Membership.new
    @title = 'New Membership'
    @context_menu = {'cancel' => memberships_path}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @membership }
    end
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(params[:membership])

    respond_to do |format|
      if @membership.save
        format.html { redirect_to memberships_path, notice: 'Membership was successfully created.' }
        format.json { render json: @membership, status: :created, location: @membership }
      else
        format.html { render action: "new" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to memberships_url }
      format.json { head :ok }
    end
  end
end
