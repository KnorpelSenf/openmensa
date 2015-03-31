class ApplicationController < BaseController
  protect_from_forgery
  check_authorization

  before_action :setup_user

  rescue_from ::CanCan::AccessDenied,         with: :error_access_denied unless Rails.env.development?
  rescue_from ::ActiveRecord::RecordNotFound, with: :error_not_found     unless Rails.env.development?

  # **** setup ****

  def setup_user
    user = find_current_user
    if user && user.logged?
      self.current_user = user
      Time.zone         = current_user.time_zone
      I18n.locale       = current_user.language
    end

    if params[:user_id]
      @user = User.find params[:user_id]
    else
      @user = current_user
    end
  end

  def find_current_user
    User.find_by_id(session[:user_id])
  end

  # **** accessors & helpers ****

  def current_user=(user)
    session[:user_id] = user ? user.id : nil
    super
  end

  def current_ability
    current_user.ability
  end

  def flash_for(node, flashs = {})
    flash[node] ||= {}
    flash[node].merge! flashs
  end

  # **** authentication ****

  def require_authentication!
    unless current_user.logged?
      # redirect_to login_url(ref: request.fullpath)
      error_access_denied
      return false
    end
    true
  end

  # **** error handling and rendering ****

  def error_not_found
    error status: :not_found
  end

  def error_access_denied
    error status: :unauthorized
  end

  def error_too_many_requests
    error status: :too_many_requests
  end

  def render_error(error)
    layout = error[:layout] || 'application'
    file   = error[:file] || 'common/error'

    @title   = error[:title]
    @message = error[:message]

    if (params[:format] || 'html') == 'html'
      render template: file, layout: layout, status: error[:status]
    else
      super
    end
  end
end
