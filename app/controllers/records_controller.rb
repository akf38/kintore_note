class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit]
  
  def index
    @records = current_user.records
    @record = Record.find_by(created_at: Time.zone.now.all_day, user_id: current_user.id) || Record.new
  end
  
  def show
    @record = Record.find(params[:id]) || Record.new
    @training_record = TrainingRecord.new
    @training_records = TrainingRecord.includes([:training]).where(record_id: @record.id)
  end
  
  def new 
    if @record = Record.find_by(created_at: Time.zone.now.all_day, user_id: current_user.id)
      redirect_to record_path(@record)
    else
      # 本日の日付を取得。
      @today_date =  Date.current.strftime('%Y/%m/%d')
      @record = Record.new
      @training_record = TrainingRecord.new
    end
  end
  
  def edit
    @record = Record.find(params[:id])
    @training_record = TrainingRecord.new
  end
  
  private
  
  def ensure_correct_user
    @record = Record.find(params[:id])
    @user = @record.user
    unless @user == current_user
      redirect_to record_path(@record)
    end
  end
  
end
