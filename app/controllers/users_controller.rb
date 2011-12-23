class UsersController < ApplicationController

  def index
    @title = 'Users'

    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @authorizations = @user.authorizations
    @title = @user.name
    @context_menu = {'back to users' => users_path, 'edit user' => edit_user_path}
  end

  def edit
    @user = User.find(params[:id])
    @title = @user.name
    @context_menu = {'back to all users' => users_path, 'back to user' => user_path}
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:success] = 'Profile updated.'
      redirect_to @user
    else
      @title = 'Error'
      @context_menu = {'back to all users' => users_path, 'back to user' => user_path}
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User destroyed.'
    redirect_to users_path
  end

end
