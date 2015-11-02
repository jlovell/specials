class SpecialsController < ApplicationController
  def create
    new_special = Special.create(special_params)
    @restaurant_id = new_special.restaurant_id
    @form_id = params[:form_id]
  end

  private

  def special_params
    params.require(:special).permit(:restaurant_id, :day, :type, :content)
  end
end
