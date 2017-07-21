class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :validate_search_key, only: [:search]

  def index
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.order('wage_lower_bound DESC').paginate(:page => params[:page], :per_page => 10)
    when 'by_upper_bound'
      Job.published.order('wage_upper_bound DESC').paginate(:page => params[:page], :per_page => 10)
    else
      Job.published.recent.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def show
    @job = Job.find(params[:id])

    if @job.is_hidden
      redirect_to root_path
      flash[:warning] = "抱歉，你无权查看！"
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to jobs_path
      flash[:notice] = "新增职位成功！！！"
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path
    flash[:alert] = "你已成功删除职位！！！"
  end

  def search
    if @query_string.present?
      # 显示符合关键字的公开职位 #
      search_result = Job.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.published.paginate(:page => params[:page], :per_page => 5)
    end
  end

  protected

  def validate_search_key
    # 去除特殊字符 #
    @query_string = params[:keyword].gsub(/\\|\'|\/|\?/, "") if params[:keyword].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    # 筛选多个栏位 #
    { :title_or_company_or_city_cont => query_string }
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden, :company, :city, :experience)
  end
end
