class ImportsController < ApplicationController

  before_filter :authenticate

  # GET /imports
  # GET /imports.json
  def index
    @imports = Import.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @imports }
    end
  end

  # GET /imports/1
  # GET /imports/1.json
  def show
    @import = Import.find(params[:id])
  end

  # GET /imports/new
  # GET /imports/new.json
  def new
    @import = Import.new
  end

  # GET /imports/1/edit
  def edit
    @import = Import.find(params[:id])
  end

  # POST /imports
  # POST /imports.json
  def create
    @import = Import.new(params[:import])

    respond_to do |format|
      if @import.save
        format.html { redirect_to @import, notice: 'Import was successfully created.' }
        format.json { render json: @import, status: :created, location: @import }
      else
        format.html { render action: "new", notice: 'Import was NOT created.' }
        format.json { render json: @import.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /imports/1
  # PUT /imports/1.json
  def update
    @import = Import.find(params[:id])

    respond_to do |format|
      if @import.update_attributes(params[:import])
        format.html { redirect_to @import, notice: 'Import was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @import.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imports/1
  # DELETE /imports/1.json
  def destroy
    @import = Import.find(params[:id])
    @import.destroy

    respond_to do |format|
      format.html { redirect_to imports_url }
      format.json { head :ok }
    end
  end
=begin
  def process_csv
    require 'csv'
    @import = Import.find(params[:id])
    lines = parse_csv_file(@import.csv.path)
    lines.shift # comment this line out if your CSV file doesn't contain a header row
    if lines.size > 0
      @import.processed = true
      lines.each do |line|
        case @import.scope.name
        when "User"
          new_user(line)
        when 'Page'
          if line[15] < 0
            new_page(line)
            Page.rebuild!
          end
        end
      end
      @import.save
      flash[:notice] = "CSV data processing was successful."
      redirect_to @import
    else
      flash[:error] = "CSV data processing failed."
      render @import
    end
  end
=end
  def process_yaml
    require 'yaml'
    @import = Import.find(params[:id])
    yaml = YAML.load(File.read(@import.csv.path))
    yaml.each do |y|
      case @import.scope.name
      when 'Page'
        new_page(y)
      when 'User'
        new_user(y)
      end
    end
    Page.rebuild!
    @import.processed = true
    @import.save
    flash[:notice] = "YAML data processing was successful."
    redirect_to @import
  end

  private

    def parse_csv_file(path_to_csv)
      lines = []
      CSV.foreach(path_to_csv) do |row|
        lines << row
      end
      lines
    end

    def new_user(people)
=begin
  model requires:
    :name, :email, :country_id
  function expects:
    people
      0  id,
      01  fb_id,
      02  group_id,
      03  fname,
      04  lname,
      05  gender,
      06  project,
      07  email1,
      08  email2,
      09  phone1,
      10  phone2,
      11  address,
      12  blog_address,
      13  blog_name,
      14  blog_description,
      15  is_user,
      16  is_moderator,
      17  is_admin,
      18  created,
      19  edited,
      20  last_activity,
      21  altered_id,
      22  delete
    volunteers
      id: 1
      user_id: 100537877
      pc_id: 100568953
      stage_id: 24
      cos: 1383541200
      local_name: "Mariama Diallo"
      site_id: 1
      sector_id: 1
      created: 1320165845
      edited: 1320488871
      altered_id: 100537874
      delete: 0
=end
      params = Hash.new
      params[:user] = Hash.new

      params[:user]["name"] = "#{people['fname']} #{people['lname']}"
      params[:user]["email"] = (people['email1'] ? people['email1'] : 'unknown@unknown.com')
      params[:user]["email2"] = people['email2']
      params[:user]["phone1"] = people['phone1']
      params[:user]["phone2"] = people['phone2']
      params[:user]["country_id"] = Country.where(:name => 'Senegal').first.id
      user = User.new(params[:user])
      user.save!
      user.blogs.create!(:title => people['blog_name'], :description => people['blog_description'], :url => people['blog_address'])
      user.volunteers.create!(:local_name => (people['local_name'] ? people['local_name'] : 'unknown'), :site_id => (people['site_id'] ? people['site_id'] : 1), :pc_id => people['pc_id'], :projects => people['project'], :stage_id => people['stage_id'], :sector_id => people['sector_id'])
      user.memberships.create!(:group_id => Group.where(:name => 'User').first.id)
      user.save!
    end

    def new_page(y)
=begin
  model requires:
    :title, :description, :content, :language_id
  function expects:
    00  id,
    01  title,
    02  url,
    03  group_id,
    04  parent_id,
    05  description,
    06  content,
    07  tags,
    08  profile_photo,
    09  visibility,
    10  updated,
    11  edited,
    12  created,
    13  altered_id,
    14  delete,
    15  case_study
=end
      params = Hash.new
      params[:page] = Hash.new

      params[:page]['title'] = y['title']
      params[:page]['description'] = y['description']
      params[:page]['content'] = y['content']
      params[:page]['parent_id'] = y['parent_id']
      params[:page]['language_id'] = Language.where(:name => 'English')
      page = Page.new(params[:page])
      page.save
    end

end
