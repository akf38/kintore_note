class TrainingsController < ApplicationController
  before_action :authenticate_user!

  def index
    part = Part.find(params[:part_id])
    render json: part.trainings.select(:id, :name)
  end

  def show
    @training = Training.find(params[:id])
    @user = User.find(params[:user_id])
    # グラフ描画のためのデータ。親テーブルと結合し、user_id,training_idに該当するものを、最新30件取得。時間表示をchartkick指定にあわせて、再度配列化。
    # rubocop:disable Airbnb/RiskyActiverecordInvocation
    training_records = TrainingRecord.joins(:record).where("records.user_id = #{@user.id} ")
    # rubocop:enable Airbnb/RiskyActiverecordInvocation
    training_records = training_records.includes([:record]).where(training_id: @training.id)
    training_records = training_records.order(created_at: :desc)
    @training_records = training_records.page(params[:page]).per(15)
    data = training_records.limit(30)
    weight_data = data.select(:created_at, :weight)
    @weight_data = weight_data.map { |d| [d.created_at.strftime('%Y%m%d').to_s, d.weight] }
  end
end
