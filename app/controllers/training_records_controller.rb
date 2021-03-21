class TrainingRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :create, :destroy]
  
  def create
    @record = Record.find(params[:record_id])
    @training_record = TrainingRecord.new(training_record_params)
    @training_record.record_id = @record.id
    if @training_record.save
      redirect_to record_path(@record)
    else
      @training_records = TrainingRecord.includes([:training]).where(record_id: @record.id)
      render 'records/show'
    end
  end
  
  def new_record_create
    # start_timeに現在時刻を作成時刻を記録する。(simplecalenderの仕様にあわせている)
    @record = Record.create(user_id: current_user.id, start_time: Time.zone.now)
    @training_record = TrainingRecord.new(training_record_params)
    @training_record.record_id = @record.id
    if @training_record.save
      redirect_to record_path(@record)
    else
      @record.destroy
      render 'records/new'
    end
  end
  
  def update
    @record = Record.find(params[:record_id])
    @training_record = TrainingRecord.find(params[:id])
    if @training_record.update(training_record_params)
      redirect_to record_path(@record)
    else
      render 'records/edit'
    end
  end
  
  def destroy
    @record = Record.find(params[:record_id])
    @training_record = TrainingRecord.find(params[:id])
    @training_record.destroy
    redirect_to edit_record_path(@record)
  end
  
  private
  
  def training_record_params
    params.require(:training_record).permit(:training_id, :weight, :rep, :set)
  end
  
  def ensure_correct_user
    @record = Record.find(params[:record_id])
    @user = @record.user
    unless @user == current_user
      redirect_to record_path(@record)
    end
  end
  
end
