class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_is_admin
    if !current_user.admin?
      redirect_to root_path
      flash[:alert] = "你不是管理员！没有权限！"
    end
  end
end
