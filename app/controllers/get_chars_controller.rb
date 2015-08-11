class GetCharsController < ApplicationController

  def messages
    @chars = Char.where(status_id: (2..5).to_a)
    render json: @chars.to_json(only: [:id, :name])
  end

end
