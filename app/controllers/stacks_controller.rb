class StacksController < ApplicationController
  
  load_and_authorize_resource
  
  # GET /stacks
  # GET /stacks.json
  def index
    @stacks = Stack.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stacks }
    end
  end

  # GET /stacks/new
  # GET /stacks/new.json
  def new
    @stack = Stack.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stack }
    end
  end

  # POST /stacks
  # POST /stacks.json
  def create
    @stack = Stack.new(params[:stack])
    @stack.user_id = current_user.id

    respond_to do |format|
      if @stack.save
        format.html { redirect_to @stack, notice: 'Stack was successfully created.' }
        format.json { render json: @stack, status: :created, location: @stack }
      else
        format.html { render action: "new" }
        format.json { render json: @stack.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stacks/1
  # DELETE /stacks/1.json
  def destroy
    @stack = Stack.find(params[:id])
    @library = @stack.library
    @stack.destroy

    respond_to do |format|
      format.html { redirect_to @library }
      format.json { head :ok }
    end
  end
end
