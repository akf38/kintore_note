class TrainingRecordsController < ApplicationController
  def create
    @record = Record.find(params[:record_id])
    @training_record = TrainingRecord.new(training_record_params)
    @training_record.record_id = @record.id
    if @training_record.save
      redirect_to new_record_path
    else
      render 'records/new'
    end
  end
  
  def update
    @record = Record.find(params[:record_id])
    @training_record = TrainingRecord.find(params[:id])
    if @training_record.update(training_record_params)
      redirect_to edit_record_path(@record)
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
end
