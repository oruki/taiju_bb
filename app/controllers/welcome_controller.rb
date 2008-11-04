class WelcomeController < ApplicationController
 # この一行を追加
  before_filter :login_required
  def index
  end
end