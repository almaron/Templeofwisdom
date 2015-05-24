class CharAvatarsController < ApplicationController

  before_action :get_avatar, only: [:update, :destroy]

  def create
    @avatar = CharAvatar.create avatar_params
  end

  def update
    @avatar.set_default_avatar
    @avatars = CharAvatar.where(char_id: @avatar.char_id)
  end

  def destroy
    @avatar.forum_posts.any? ? @avatar.update(char_id: nil) : @avatar.destroy
    render json: {success: true}
  end

  private

  def get_avatar
    @avatar = CharAvatar.find(params[:id])
  end

  def avatar_params
    params.require(:char_avatar).permit(:char_id, :remote_image_url, :image)
  end
end
