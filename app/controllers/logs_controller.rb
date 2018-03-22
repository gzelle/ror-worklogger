class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user, only: :destroy
  before_action :prepare_projects

  # GET /logs
  # GET /logs.json
  def index
    @logs = current_user.logs

    if params[:start_date].present? && params[:end_date].present?
      date_filters(params[:start_date], params[:end_date])
      if params[:start_date] <= params[:end_date]
        @logs = Log.filter_dates(current_user, params[:start_date], params[:end_date])
      else
        date_filters(nil,nil)
        flash_alerts("End date cannot be earlier than start date.", root_path)
      end
    end
    @total_hours = Log.get_total_hours(@logs)
  end

  # GET /logs/1
  # GET /logs/1.json
  def show
    @log = Log.find(params[:id])
  end

  # GET /logs/new
  def new
    @log = Log.new
  end

  # GET /logs/1/edit
  def edit
  end

  # POST /logs
  # POST /logs.json
  def create
    @log = current_user.logs.build(log_params)

    respond_to do |format|
      if @log.save
        format.html { redirect_to logs_path, notice: 'Log was successfully created.' }
        format.json { render :show, status: :created, location: @log }
      else
        format.html { render :new }
        format.json { render json: @log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /logs/1
  # PATCH/PUT /logs/1.json
  def update
    respond_to do |format|
      if @log.update(log_params)
        format.html { redirect_to @log, notice: 'Log was successfully updated.' }
        format.json { render :show, status: :ok, location: @log }
      else
        format.html { render :edit }
        format.json { render json: @log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logs/1
  # DELETE /logs/1.json
  def destroy
    @log.destroy
    respond_to do |format|
      format.html { redirect_to logs_url, notice: 'Log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_params
      params.require(:log).permit(:duration, :project_id, :remarks, :date, :user_id, :start_date, :end_date)
    end

    def correct_user
      @log = current_user.logs.find_by(id: params[:id])
      redirect_to login_path if @log.nil?
    end

    def prepare_projects
      @projects = Project.all
    end

    def date_filters(startdate, enddate)
      # Variables for printing on views
      @start_date = startdate
      @end_date = enddate
    end

    def flash_alerts(alert, path)
      flash.now[:notice] = alert
      return path
    end
end
