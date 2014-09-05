class AdminJournalPagesController < ApplicationController

  before_action :master_access
  before_action :get_page, except: [:create, :destroy, :destroy_image]

  def show
  end

  def create
    @page = JournalPage.create page_params
    render :show
  end

  def update
    @page.update page_params
    render :show
  end

  def reset
    @page.reset(params[:page_type])
    render :show
  end

  def destroy
    JournalPage.find(params[:id]).destroy
    render nothing: true
  end

  def destroy_image
    JournalImage.find(params[:image_id]).destroy
  end

  private

  def get_page
    @page = JournalPage.includes(:images).find(params[:id] || params[:page_id])
  end

  def page_params
    params.require(:page).permit(:id, :journal_id, :head, :content_text, :content_line, :page_type, :content_blocks, images_attributes:[:remote_image_url, :remote_url, :id, :_destroy])
  end

end
