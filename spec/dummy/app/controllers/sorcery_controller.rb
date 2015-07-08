class SorceryController < ActionController::Base
  protect_from_forgery
  before_filter :require_login, only: [:test_logout, :test_should_be_logged_in, :some_action]

  def index
  end

  def some_action
    render nothing: true
  end

  def test_login
    @user = login(params[:email], params[:password])
    render nothing: true
  end

  def test_return_to
    @user = login(params[:email], params[:password])
    redirect_back_or_to(:index, notice: 'haha!')
  end

  def test_logout
    logout
    render nothing: true
  end
end
