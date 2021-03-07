class RecordsController < ApplicationController
  def index
    @records = current_user.records
    @record = Record.find_by("created_at >= ?", Time.zone.now.beginning_of_day) || Record.new
  end
  
  def show
    @record = Record.find(params[:id]) || Record.new
    @training_record = TrainingRecord.new
  end
  
  def new 
    if @record = Record.find_by("created_at >= ?", Time.zone.now.beginning_of_day)
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
  
end
