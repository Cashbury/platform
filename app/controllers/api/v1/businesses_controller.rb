class Api::V1::BusinessesController < Api::V1::BaseController

  def create
  	@business = Business.new(business_params)
  	if @business.create_new_for(current_user)
  		render 'create'
  	else
  		render_api_response({ :errors => @business.errors.full_messages })
  	end
  end

  def show
    @business = Business.find(params[:id])
    render :show
  end

  private
  def business_params
    params.require(:business).permit!
  end

end