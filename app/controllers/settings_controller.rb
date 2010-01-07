class SettingsController < ApplicationController
  before_filter :login_required
  require_role 'admin'

  def index
    @settings = Setting.all
  end

  def show
    @setting = Setting.find(params[:id])
  end

  def new
    @setting = Setting.new
  end

  def edit
    @setting = Setting.find(params[:id])
  end

  def create
    @setting = Setting.new(params[:setting])

    if @setting.save
      flash[:notice] = 'Setting was successfully created.'
      redirect_to(@setting)
    else
      render :action => "new"
    end
  end

  def update
    @setting = Setting.find(params[:id])

    if @setting.update_attributes(params[:setting])
      flash[:notice] = 'Setting was successfully updated.'
      redirect_to(@setting)
    else
      render :action => "edit"
    end
  end

  def destroy
    @setting = Setting.find(params[:id])
    @setting.destroy

    redirect_to(settings_url)
  end
  
  protected
  
  def authorized?
    flash[:error] = "You need to login to do this." unless current_user
    current_user
  end
end
