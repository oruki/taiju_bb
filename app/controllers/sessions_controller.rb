#　ログイン/ログアウト処理を行うコントローラー
# This controller handles the login/logout function of the site.  

class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  # include AuthenticatedSystem ←2008.06.10 上記の指示によりコメントアウト

  # render new.rhtml #ログイン画面
  def new
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])

    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      # 下記を仮にｺﾒﾝﾄｱｳﾄした（ﾛｸﾞｲﾝ後必ずｳｪﾙｶﾑ画面に誘導するため）
      # 短時間の間の再ﾛｸﾞｲﾝに対処する場合は再考する
      # redirect_back_or_default('/welcome')
      redirect_to('/welcome')
      flash[:notice] = "ログインに成功しました"
    else
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "ログアウトしました"
  # redirect_back_or_default('/')
    redirect_back_or_default('/login')
  end

end