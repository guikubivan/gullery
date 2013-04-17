class AssetsController < ApplicationController

  before_filter :login_required

  def create
    @asset = Asset.new params[:asset]
    @asset.position = Asset.count
    if @asset.save
      case @asset.project_id
      when 2
        redirect_to photography_url
      when 1
        redirect_to paintings_url
      else
        redirect_to projects_url(:action => 'show', :id => @asset.project_id)
      end
    else
      render :inline => "<%= error_messages_for :asset %>"
    end
  end

  def destroy
    @asset = Asset.find params[:id]
    @asset.destroy
  end

  def update_caption
    @asset = Asset.find params[:id]
    @asset.caption = params[:value]
    if @asset.save
      render :text => textilight(@asset.caption)
    end
  end

  def update_artwork_medium
    @asset = Asset.find params[:id]
    @asset.artwork_medium = params[:value]
    if @asset.save
      render :text => textilight(@asset.artwork_medium)
    end
  end
  
  def update_measurements
    @asset = Asset.find params[:id]
    @asset.measurements = params[:value]
    if @asset.save
      render :text => textilight(@asset.measurements)
    end
  end

  def sort
    asset_ids = params[:asset_list]
    asset_ids.each_with_index do |asset_id, index|
      asset = Asset.find asset_id
      asset.update_attribute(:position, index)
    end
    render :nothing => true
  end

  def rotate
    @asset = Asset.find params[:id]
    @asset.rotate(params[:direction])
    redirect_to projects_url(:action => 'show', :id => @asset.project_id)
  end

end
