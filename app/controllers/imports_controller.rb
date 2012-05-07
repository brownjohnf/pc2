class ImportsController < ApplicationController
  
  load_and_authorize_resource

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

  def process_yaml
    require 'yaml'
    @import = Import.find(params[:id])
    yaml = YAML.load(File.read(@import.csv.to_file))
    case @import.scope.name
    when 'CaseStudy'
      yaml.each do |y|
        if y['case_study'] == 1
          new_casestudy(y)
        end
      end
    when 'Page'
      yaml.each do |y|
        if y['case_study'] == 0
          new_page(y)
        end
      end
      pages = Hash.new
      yaml.each do |y|
        pages[y['id']] = y
      end
      pages.each do |id, data|
        unless data['parent_id'] == 0 || data['case_study'] == 1
          page = Page.where(:title => data['title']).first
          page.parent_id = Page.where(:title => pages[data['parent_id']]['title']).first.id
          page.save!
        end
      end
      Page.rebuild!
    when 'User'
      yaml.each do |y|
        new_user(y)
      end
    when 'Site'
      yaml.each do |y|
        unless Site.where(:name => y['site_name']).any?
          new_site(y)
        end
      end
    when 'Stage'
      yaml.each do |y|
        unless Stage.where(:name => y['stage_name']).any?
          new_stage(y)
        end
      end
    when 'Sector'
      yaml.each do |y|
        unless Sector.where(:name => y['sector_name']).any?
          new_sector(y)
        end
      end
    end
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
      params = Hash.new
      params[:user] = Hash.new

      params[:user]["name"] = "#{people['fname']} #{people['lname']}"
      params[:user]["email"] = (people['email1'] ? people['email1'] : 'unknown@unknown.com')
      params[:user]["email2"] = people['email2']
      params[:user]["phone1"] = people['phone1']
      params[:user]["phone2"] = people['phone2']
      params[:user]["country"] = 'SN'
      user = User.new(params[:user])
      user.save!
      user.blogs.create!(:title => people['blog_name'], :description => people['blog_description'], :url => people['blog_address'])
      user.volunteers.create!(:local_name => (people['local_name'] ? people['local_name'] : 'unknown'), :pc_id => people['pc_id'], :projects => people['project'], :stage_id => (Stage.where(:name => people['stage_name']).any? ? Stage.where(:name => people['stage_name']).first.id : nil), :sector_id => (Sector.where(:name => people['sector_name']).any? ? Sector.where(:name => people['sector_name']).first.id : nil), :site_id => (Site.where(:name => people['site_name']).any? ? Site.where(:name => people['site_name']).first.id : nil))
      user.memberships.create!(:group_id => Group.where(:name => 'User').first.id)
      user.save!
    end

    def new_page(y)
      params = Hash.new
      params[:page] = Hash.new

      params[:page]['title'] = y['title']
      params[:page]['description'] = y['description']
      params[:page]['content'] = y['content']
      params[:page]['language_id'] = Language.where(:name => 'English')
      params[:page]['country'] = 'SN'
      page = Page.new(params[:page])
      page.save!
    end

    def new_casestudy(y)
      params = Hash.new
      params[:cs] = Hash.new

      params[:cs]['title'] = y['title']
      params[:cs]['summary'] = y['description'] + y['content']
      params[:cs]['language_id'] = Language.where(:name => 'English')
      params[:cs]['country'] = 'SN'
      cs = CaseStudy.new(params[:cs])
      cs.save!
    end

    def new_site(site)
      params = Hash.new
      params[:site] = Hash.new

      params[:site]['name'] = site['site_name']
      new_site = Site.new(params[:site])
      new_site.save!
    end

    def new_stage(stage)
      params = Hash.new
      params[:stage] = Hash.new

      params[:stage]['name'] = stage['stage_name']
      new_stage = Stage.new(params[:stage])
      new_stage.save!
    end

    def new_sector(sector)
      params = Hash.new
      params[:sector] = Hash.new

      params[:sector]['name'] = sector['sector_name']
      new_sector = Sector.new(params[:sector])
      new_sector.save
    end

end
