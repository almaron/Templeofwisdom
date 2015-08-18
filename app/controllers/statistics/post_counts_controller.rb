class Statistics::PostCountsController < ApplicationController
  before_action :admin_access

  def index
    @counts = Statistics::PostCount.paginate(page: params[:page], per_page: 30)
    @today = Statistics::PostCount.today
  end

  def create
    unless (@count = Statistics::PostCount.find_by date: in_date)
      @count = Statistics::PostCount.create_date in_date
    end
    respond_to do |format|
      format.html {
        redirect_to statistics_post_counts_path
      }
      format.js {
        render js: "alert('#{@count.count}'); document.getElementById('statsForm').reset()"
      }
    end
  end

  private

  def in_date
    Date.parse(params[:date])
  end
end
