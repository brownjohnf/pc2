class UsersController < ApplicationController

  def index
    @title = 'Users'
    #@context_menu = {'new' => new_user_path}

    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @groups = @user.groups
    @authorizations = @user.authorizations
    @title = @user.name
    @context_menu = {'back' => users_path, 'edit' => edit_user_path}
  end

  def edit
    @user = User.find(params[:id])
    @title = @user.name
    @context_menu = {'back' => users_path, 'cancel' => user_path}
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        @title = 'Error'
        @context_menu = {'back to all users' => users_path, 'back to user' => user_path}
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

end
