class UsersController < ApplicationController
  
  load_and_authorize_resource

  def index
    @title = 'Users'

    @users = @users.paginate(:page => params[:page], :per_page => 20)
    @recent = @users.unscoped.order('updated_at DESC').limit(20)
  end

  def show
    @title = @user.name
  end

  def edit
    @title = @user.name
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        @current_ability = nil
        @current_user = nil
        format.html { redirect_to action: 'show', notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
