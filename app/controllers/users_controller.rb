class UsersController < ApplicationController

  before_filter :authenticate #sessions helper
  before_filter :authorized_user, :only => [ :edit, :update ]
  before_filter :authenticate_admin, :only => [ :new, :create, :destroy ]

  def index
    @title = 'Users'

    @users = User.paginate(:page => params[:page], :per_page => 20)
    @recent = User.unscoped.order('updated_at DESC').limit(20)
  end

  def show
    @user = User.find(params[:id])

    @title = @user.name
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @privilege }
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User destroyed.'
    redirect_to users_path
  end
  
  private
  
    def authorized_user
      @user = User.find_by_id(params[:id])
      deny_owner unless @user == current_user || current_user.admin?
    end

end
