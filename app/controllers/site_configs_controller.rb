class SiteConfigsController < ApplicationController

  load_and_authorize_resource

  # GET /site_configs
  # GET /site_configs.json
  def index
    @site_configs = SiteConfig.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @site_configs }
    end
  end

  # GET /site_configs/1/edit
  def edit
    @site_config = SiteConfig.find(params[:id])
  end

  # PUT /site_configs/1
  # PUT /site_configs/1.json
  def update
    @site_config = SiteConfig.find(params[:id])

    respond_to do |format|
      if @site_config.update_attributes(params[:site_config])
        format.html { redirect_to site_configs_path, notice: 'Site config was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site_config.errors, status: :unprocessable_entity }
      end
    end
  end
end
