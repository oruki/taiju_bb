#このｺﾝﾄﾛｰﾗｰを利用するﾋﾞｭｰ：部分ﾃﾝﾌﾟﾚｰﾄ（_shidou;_school_recs;_med_recs;_stay_out_recs）から参照される
#用途：対象児童／指導員のみを含むｵﾌﾞｼﾞｪｸﾄ（ﾚｺｰﾄﾞ）を抽出する
#rout:各ｱｸｼｮﾝに対するﾋﾞｭｰは.rjsﾌｧｲﾙでreplace_htmlを実行する（AJAX）

class SelectsController < ApplicationController
  # authentification 2008.06.10
  before_filter :login_required
  
  #不要なら削除する
  def fold
    @attend = params[:id]
  end

  #----------------------------------------------------------------------------------------------
  #今月のﾚｺｰﾄﾞだけを抽出する
  #次のdef selの中に実装されているので他の部分で使用のない場合は削除できる
  def sel_this_month
    #session[:kk] = params[:knd]  
    @case_rec = CaseRec.find(params[:id])
    
    @shidou_recs   = @case_rec.boy.shidou_recs
    @school_recs   = @case_rec.boy.school_recs
    @med_recs      = @case_rec.boy.med_recs
    @stay_out_recs = @case_rec.boy.stay_out_recs
    
    #params[:year]が設定されていない場合はyyを今年に設定する
    yy = Date.today.strftime("%Y")
    mm = Date.today.strftime("%m")

    @shidou_recs   =   @shidou_recs.selected_year(yy).selected_month(mm)
    @school_recs   =   @school_recs.selected_year(yy).selected_month(mm)
    @med_recs      =      @med_recs.selected_year(yy).selected_month(mm)
    @stay_out_recs = @stay_out_recs.selected_year(yy).selected_month(mm)
  end


  #----------------------------------------------------------------------------------------------SEL
  #attendおよびday_recから参照される
  #ﾋﾞｭｰから検索条件としてknd jido yy mm / 呼び出しﾋﾞｭｰ　対象児童　年　月　が送られる
  #shidou_recでﾃﾞｰﾀ件数が1000程度で処理が非常に重い
  def sel
    #@shidou_recs = ShidouRec.find(:all, :order => "date DESC")
    session[:kk] = params[:knd]   if params[:knd]    #recs to display is stored in session[:kk] sel.rjs should render it
    session[:jj] = params[:jido]  if params[:jido]
    session[:mm] = params[:month] if params[:month]
    
    #params[:year]が設定されていない場合はyyを今年に設定する
    
    if params[:year]
      yy = params[:year]
      session[:yy] = yy
    else
      yy = Date.today.strftime("%Y")
      session[:yy] = yy
    end
        
    case params[:view]
    when "attend_view"
        @attend = Attend.find(params[:id])
        case params[:month]
        when "aa"
          @shidou_recs     = ShidouRec.selected_year('2008')
        # @shidou_recs     = ShidouRec.selected_year(yy).find(:all, :order => "date Desc") if params[:knd]=='shidou'
          @school_recs     = SchoolRec.selected_year(yy).find(:all, :order => "date Desc") if params[:knd]=='school'
          @med_recs           = MedRec.selected_year(yy).find(:all, :order => "date Desc") if params[:knd]=='med'
          @stay_out_recs =  StayOutRec.selected_year(yy).find(:all, :order => "date Desc") if params[:knd]=='stay_out'
        when "tm"
          @shidou_recs     = ShidouRec.selected_year(yy).selected_month(Date.today.strftime("%m")).find(:all, :order => "date Desc") if params[:knd]=='shidou'
          @school_recs     = SchoolRec.selected_year(yy).selected_month(Date.today.strftime("%m")).find(:all, :order => "date Desc") if params[:knd]=='school'
          @med_recs           = MedRec.selected_year(yy).selected_month(Date.today.strftime("%m")).find(:all, :order => "date Desc") if params[:knd]=='med'      
          @stay_out_recs =  StayOutRec.selected_year(yy).selected_month(Date.today.strftime("%m")).find(:all, :order => "date Desc") if params[:knd]=='stay_out'
        else
          @shidou_recs     = ShidouRec.selected_year(yy).selected_month(params[:month]).find(:all, :order => "date Desc") if params[:knd]=='shidou'
          @school_recs     = SchoolRec.selected_year(yy).selected_month(params[:month]).find(:all, :order => "date Desc") if params[:knd]=='school'
          @med_recs           = MedRec.selected_year(yy).selected_month(params[:month]).find(:all, :order => "date Desc") if params[:knd]=='med'
          @stay_out_recs =  StayOutRec.selected_year(yy).selected_month(params[:month]).find(:all, :order => "date Desc") if params[:knd]=='stay_out'
        end
    when "case_rec_view"
        @case_rec = CaseRec.find(params[:id])
        case params[:month]        
        when "aa"
          @shidou_recs     = ShidouRec.selected_year(yy).selected_boys(@case_rec.boy).find(:all, :order => "date Desc")
          @school_recs     = SchoolRec.selected_year(yy).selected_boys(@case_rec.boy).find(:all, :order => "date Desc")
          @med_recs           = MedRec.selected_year(yy).selected_boys(@case_rec.boy).find(:all, :order => "date Desc")
          @stay_out_recs  = StayOutRec.selected_year(yy).selected_boys(@case_rec.boy).find(:all, :order => "date Desc")
        when "tm"
          @shidou_recs     = ShidouRec.selected_year(yy).selected_month(Date.today.strftime("%m")).selected_boys(@case_rec.boy).find(:all, :order => "date Desc")
          @school_recs     = SchoolRec.selected_year(yy).selected_month(Date.today.strftime("%m")).selected_boys(@case_rec.boy).find(:all, :order => "date Desc")
          @med_recs           = MedRec.selected_year(yy).selected_month(Date.today.strftime("%m")).selected_boys(@case_rec.boy).find(:all, :order => "date Desc")
          @stay_out_recs =  StayOutRec.selected_year(yy).selected_month(Date.today.strftime("%m")).selected_boys(@case_rec.boy).find(:all, :order => "date Desc")            
        else
          @shidou_recs     = ShidouRec.selected_year(yy).selected_month(params[:month]).selected_boys(@case_rec.boy).find(:all, :order => "date Desc")
          @school_recs     = SchoolRec.selected_year(yy).selected_month(params[:month]).selected_boys(@case_rec.boy).find(:all, :order => "date Desc")
          @med_recs           = MedRec.selected_year(yy).selected_month(params[:month]).selected_boys(@case_rec.boy).find(:all, :order => "date Desc")
          @stay_out_recs  = StayOutRec.selected_year(yy).selected_month(params[:month]).selected_boys(@case_rec.boy).find(:all, :order => "date Desc")
        end
    else    
    end        
  end
 


  #-----------------------------------------------------------------------------------select_accounts
  # method for extracting specific boy in list
  def select_accounts
    @accounts = Account.find(:all, :order => "hizuke DESC")
    if params[:boy]
      @accounts = Account.find(:all, :conditions=>['boy_id=?',params[:boy]], :order => "hizuke DESC")
    end
  end

#-----------------------------------------------------------------------------------
def select_jido_in_jido_edu_rels
  @jido_edu_rels = JidoEduRel.find(:all)
  if params[:boy]
    @jido_edu_rels = JidoEduRel.find(:all, :conditions=>['boy_id=?',params[:boy]])
  end
  if params[:edu_inst_name]
    @jido_edu_rels = JidoEduRel.find(:all, :conditions=>['edu_inst_id=?',params[:edu_inst_name]])
  end
  if params[:edu_inst_cat]
    @jido_edu_rels = JidoEduRel.find(:all).select {|i| i.edu_inst.cat == params[:edu_inst_cat]} 
  end
end

#下記の一連のｱｸｼｮﾝは各記録の中のstaff,boyをクリックして対象指導員、児童を抽出するメソッド
#期間（）情報を含む複合検索とするか方針が必要
#---------------------------------------------------------------------------------生活指導記録部分ﾃﾝﾌﾟﾚｰﾄ（shared/_shidou.html.erb）から呼ぶ
   #session[:ext] is set in controller/index
   #session[:ext] is set again after this action
   #@*_recs can be accessed by finding session
   def hit
    @shidou_recs = ShidouRec.find(session[:ext])                                                           #表示中のﾚｺｰﾄﾞ群を@school_recsに
    if params[:boy]                                                                                        #児童名がｸﾘｯｸされた場合
      @shidou_recs = @shidou_recs.select{|i| i.boy_id.to_s == params[:boy]}                                #boy_id.to_s string value needed
      @shidou_recs = @shidou_recs.sort {|x, y| y.date <=> x.date}                                          #日付で降順ソート
      @shidou_recs_cnt = @shidou_recs.size
    end
    if params[:staff]                                                                                      #指導員名がｸﾘｯｸされた場合 
      @shidou_recs = @shidou_recs.select{|i| i.staff_id.to_s == params[:staff]}                            #boy_id.to_s string value needed
      @shidou_recs = @shidou_recs.sort {|x, y| y.date <=> x.date}  
      @shidou_recs_cnt = @shidou_recs.size
    end
    session[:ext] = @shidou_recs.map{|i| i.id}
  end

#---------------------------------------------------------------------------------学校記録部分ﾃﾝﾌﾟﾚｰﾄ（shared/_school_recs.html.erb）から呼ぶ
  def kick
   #session[:ext] is set in controller/index
   #session[:ext] is set again after this action
   #@*_recs can be accessed by finding session
    @school_recs = SchoolRec.find(session[:ext])                                                           #表示中のﾚｺｰﾄﾞ群を@school_recsに
    if params[:boy]
      @school_recs = @school_recs.select {|i| i.boy_id.to_s == params[:boy]}                               #指定児童を含むﾚｺｰﾄﾞ抽出
      @school_recs = @school_recs.sort {|x, y| y.date <=> x.date}
      @school_recs_cnt = @school_recs.size                                                                 #日付で降順ソート
    end
    if params[:staff]
      @school_recs = @school_recs.select {|i| i.staff_id.to_s == params[:staff]}
      @school_recs = @school_recs.sort {|x, y| y.date <=> x.date}
      @school_recs_cnt = @school_recs.size                                                                 #日付で降順ソート
    end
    session[:ext] = @school_recs.map{|i| i.id}
  end

#----------------------------------------------------------------------------------医療記録部分ﾃﾝﾌﾟﾚｰﾄ（shared/_med_recs.html.erb）から呼ぶ
  def med
   #session[:ext] is set in controller/index
   #session[:ext] is set again after this action
   #@*_recs can be accessed by finding session
    @med_recs = MedRec.find(session[:ext])                                                           #表示中のﾚｺｰﾄﾞ群を@school_recsに
    if params[:boy]
      @med_recs = @med_recs.select {|i| i.boy_id.to_s == params[:boy]}                               #指定児童を含むﾚｺｰﾄﾞ抽出
      @med_recs = @med_recs.sort {|x, y| y.date <=> x.date}
      @med_recs_cnt = @med_recs.size                                                                 #日付で降順ソート
    end
    if params[:staff]
      @med_recs = @med_recs.select {|i| i.staff_id.to_s == params[:staff]}
      @med_recs = @med_recs.sort {|x, y| y.date <=> x.date}
      @med_recs_cnt = @med_recs.size                                                                 #日付で降順ソート
    end
    session[:ext] = @med_recs.map{|i| i.id}
  end
#----------------------------------------------------------------------------------外泊記録部分ﾃﾝﾌﾟﾚｰﾄ（shared/_stay_out_recs.html.erb）から呼ぶ
  def stay_out
   #session[:ext] is set in controller/index
   #session[:ext] is set again after this action
   #@*_recs can be accessed by finding session
    @stay_out_recs = StayOutRec.find(session[:ext])                                                           #表示中のﾚｺｰﾄﾞ群を@school_recsに
    if params[:boy]
      @stay_out_recs = @stay_out_recs.select {|i| i.boy_id.to_s == params[:boy]}                               #指定児童を含むﾚｺｰﾄﾞ抽出
      @stay_out_recs = @stay_out_recs.sort {|x, y| y.date <=> x.date}
      @stay_out_recs_cnt = @stay_out_recs.size                                                                 #日付で降順ソート
    end
    if params[:staff]
      @stay_out_recs = @stay_out_recs.select {|i| i.staff_id.to_s == params[:staff]}
      @stay_out_recs = @stay_out_recs.sort {|x, y| y.date <=> x.date}
      @stay_out_recs_cnt = @stay_out_recs.size                                                                 #日付で降順ソート
    end
    session[:ext] = @stay_out_recs.map{|i| i.id}
  end

#----------------------------------------------------------------------------------show_all
  def show_all
    @shidou_recs =    ShidouRec.find(:all, :order => "date DESC")
    @school_recs =    SchoolRec.find(:all, :order => "date DESC")
    @med_recs =          MedRec.find(:all, :order => "date DESC")
    @stay_out_recs = StayOutRec.find(:all, :order => "date DESC")
  end

end