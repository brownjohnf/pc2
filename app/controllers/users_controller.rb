class UsersController < ApplicationController
  
  load_and_authorize_resource

  def index
    @title = 'Users'
    @users = @users.unscoped.order("#{(params[:sort] ? params[:sort] : 'name')} ASC").paginate(:page => params[:page])
  end

  def table
    respond_to do |format|
      format.html { render :layout => 'layouts/application-fluid' }
    end
  end
  
  def search
    if params[:q]
      @users = User.search(params[:q]).paginate(:page => params[:page], :per_page => 20)
      @count = @users.count
      render 'index'
    else
      redirect_to users_path
    end
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

  def remove_avatar
    @user = User.find(params[:id])
    @user.avatar = nil
    @user.save

    render action: 'show'
  end

end
