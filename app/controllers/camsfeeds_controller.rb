class CamsfeedsController < ApplicationController
	  def index
	  end

	 def import
	  Camsfeed.import(params[:file])
	  redirect_to root_url, notice: "Products imported."
	 end

end
