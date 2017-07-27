class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_is_admin
  before_action :find_job_and_check_permission, only: [:edit, :update, :destroy]
  layout "admin"

  def index
    @jobs = current_user.jobs.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
     @job.user = current_user
    if @job.save
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to admin_jobs_path
      flash[:notice] = " 修改成功！！！"
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to admin_jobs_path
    flash[:alert] = "删除成功！！！"
  end

  def publish
    @job = Job.find(params[:id])
    @job.publish!
    redirect_to :back
  end

  def hide
    @job = Job.find(params[:id])
    @job.hide!
    redirect_to :back
  end


  private

  def find_job_and_check_permission
    @job = Job.find(params[:id])
    if current_user != @job.user
      redirect_to admin_jobs_path
      flash[:alert] = "你没有这个权限！！！"
    end
  end

  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden, :company, :city, :experience)
  end
end
