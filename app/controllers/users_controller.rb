class UsersController < ApplicationController

  def index
    @title = 'Users'
    #@context_menu = {'new' => new_user_path}

    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])

    #@group_permissions = {}
    #@user.groups.each do |g|
     # g.permissions.each do |p|
      #  if p.target_id.nil?
       #   @group_permissions = { g.name => { p.scope.name => { p.privilege.name => {  :name => 'All', :path => '' } } } }
       # else
        #  @group_permissions = { g.name => { p.scope.name => { p.privilege.name => { :name => p.scope.name.constantize.find_by_id(p.target_id).title, :path => '' } } } }
        #end
      #end
    #end

    @title = @user.name
    @context_menu = {'back' => users_path, 'edit' => edit_user_path}
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
    @context_menu = {'back' => users_path, 'cancel' => user_path}
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
