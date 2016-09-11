class SugoiHttpTesterRails::HostBasicAuthsController < ApplicationController
  def index
    @host_basic_auths = SugoiHttpTesterRails::HostBasicAuth.all
  end

  def new
    @host_basic_auth = SugoiHttpTesterRails::HostBasicAuth.new
  end

  def create
    @host_basic_auth = SugoiHttpTesterRails::HostBasicAuth.new(host_basic_auth_param)
    if @host_basic_auth.save
      redirect_to host_basic_auths_url, path: '作成しました'
    else
      render :new
    end
  end

  def edit
    @host_basic_auth = SugoiHttpTesterRails::HostBasicAuth.find(params[:id])
  end

  def update
    @host_basic_auth = SugoiHttpTesterRails::HostBasicAuth.find(params[:id])
    if @host_basic_auth.update(host_basic_auth_param)
      redirect_to host_basic_auths_url, path: '編集しました'
    else
      render :new
    end
  end

  private

  def host_basic_auth_param
    params.require(:host_basic_auth).permit!
  end
end
