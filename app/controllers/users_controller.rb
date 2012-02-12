class UsersController < ApplicationController
  
  load_and_authorize_resource

  def index
    @title = 'Users'

    @users = User.paginate(:page => params[:page], :per_page => 20)
    @recent = User.unscoped.order('updated_at DESC').limit(20)
  end

  def show
    @user = User.find(params[:id])

    @title = @user.name
  end

  def edit
    @user = User.find(params[:id])
    @title = @user.name
  end

  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to action: 'index', notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
