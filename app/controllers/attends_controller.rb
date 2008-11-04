class AttendsController < ApplicationController
  # authentification 2008.06.10
  before_filter :login_required
#---------------------------------------------  

  def schedule
   @yotei=params[:index]
  end

#---------------------------------------------  
  def next_index(x)
    if current_user.staff
      @attends = Attend.find(:all, :conditions => ['staff_id=?', current_user.staff.id], :order => "time_start DESC") 
    else
      @attends = Attend.find(:all, :order => "time_start DESC") 
    end
    @attends.index(x) - 1
  end
  def prev_index(x)
    if current_user.staff
      @attends = Attend.find(:all, :conditions => ['staff_id=?', current_user.staff.id], :order => "time_start DESC") 
    else
      @attends = Attend.find(:all, :order => "time_start DESC") 
    end
    @attends.index(x) + 1
  end

def unfold
  @attend = Attend.find(params[:id])
  @grp_recs_today = GroupRec.find(:all).select {|j| j.hizuke == @attend.time_start.to_date }
end
#-------------------------------------------------------------------------------グループ記録の選択表示切替
  def grp_recs(k)
    session[:grp] = params[:grp] if params[:grp]
    @attend = Attend.find(params[:id])
  
    @thegroups = @attend.staff.boys.map{ |i| i.groups }.flatten.uniq              #ｸﾞﾙｰﾌﾟ達のidの配列
    @thegroup_ids = @thegroups.map{ |i| i.id }    
  
    x = GroupRec.find(:all).select {|j| j.hizuke == @attend.time_start.to_date }  #本日の日付のグループ記録
    case k
    when 'all'
      @grp_recs_today = x
    when 'on'
      @grp_recs_today = x.select {|i|  @thegroup_ids.include?(i.group_id) }       #xの内そのgroup_idが[:grp_ids]に含まれるもの
    when 'off'
      @grp_recs_today = GroupRec.find(:all).select {|j| j.hizuke == @attend.time_start.to_date }
    end
  end
  
#-------------------------------------------------------------------------------グループ記録の選択表示切替
  def sel_grp_recs2
    grp_recs(session[:grp])
  end
  
  def sel_grp_recs
    session[:grp] = params[:grp] if params[:grp]
    @attend = Attend.find(params[:id])
  
    @thegroups = @attend.staff.boys.map{ |i| i.groups }.flatten.uniq              #ｸﾞﾙｰﾌﾟ達のidの配列
    @thegroup_ids = @thegroups.map{ |i| i.id }    

    x = GroupRec.find(:all).select {|j| j.hizuke == @attend.time_start.to_date }  #本日の日付のグループ記録
    case session[:grp]
    when 'all'
      @grp_recs_today = x
    when 'on'
      @grp_recs_today = x.select {|i|  @thegroup_ids.include?(i.group_id) }       #xの内そのgroup_idが[:grp_ids]に含まれるもの
    when 'off'
      @grp_recs_today = GroupRec.find(:all).select {|j| j.hizuke == @attend.time_start.to_date }
    end
  end
#-------------------------------------------------------------------------------------------------------------
  def dsp
    if request.post?
      @result1 = params[:selectedboy]
      @result2 = params[:x]
      session[:theboy]=params[:selectedboy]
    end
  end
#------------------------------------------------------------------------------------------------------------------INDEX
  # GET /attends
  # GET /attends.xml
  def index

    if current_user.staff
      @attends = Attend.find(:all, :conditions => ['staff_id=?', current_user.staff.id], :order => "time_start DESC") 
    else
      @attends = Attend.find(:all, :order => "time_start DESC") 
    end

#2008-08-13 年月により抽出するラジオボタンを追加------↓
mm = params[:month].to_i if params[:month]
if params[:year]
  yy = params[:year].to_i
else
  yy = Date.today.year
end

if params[:year] and params[:month]
    @attends = @attends.find_all{ |k| k.time_start.to_date.month == mm }
end
#-----------------------------------------------------↑
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attends }
    end
  end
#-------------------------------------------------------------------------------------------------------------boy_shidou_recs
#当該日付当該児童の複数指導記録を求めなければ'-'を返す
  def boy_shidou_recs(boy)
    if boy.shidou_recs.blank?
      k = '-'
    else
      k = boy.shidou_recs.select{ |j| j.date == @attend.time_start.to_date } 
    end
    if k.blank?
      k = '-'
    else
      k
    end
  end
#-------------------------------------------------------------------------------------------------------------boy_school_recs
#当該日付当該児童の複数学校記録を求めなければ'-'を返す
  def boy_school_recs(boy)
    if boy.school_recs.blank?
      k = '-'
    else
      k = boy.school_recs.select{ |j| j.date == @attend.time_start.to_date } 
    end
    if k.blank?
      k = '-'
    else
      k
    end
  end
#-------------------------------------------------------------------------------------------------------------boy_med_recs
#当該日付当該児童の複数医療記録を求めなければ'-'を返す
  def boy_med_recs(boy)
    if boy.med_recs.blank?
      k = '-'
    else
      k = boy.med_recs.select{ |j| j.date == @attend.time_start.to_date } 
    end
    if k.blank?
      k = '-'
    else
      k
    end
  end
#-------------------------------------------------------------------------------------------------------------boy_stay_out_recs
#当該期間当該児童の複数医療記録を求めなければ'-'を返す
  def boy_stay_out_recs(boy)
    if boy.stay_out_recs.blank?
      k = '-'
    else
      k = boy.stay_out_recs.select{ |j| ( j.period_from..j.period_to ) === @attend.time_start.to_date } 
    end
    if k.blank?
      k = '-'
    else
      k
    end
  end
  
  
#------------------------------------------------------------------------------------------------------------------------
  def groups_of_staff
    @attend.staff.boys.map{ |i| i.groups }.flatten.uniq  #担当児童のｸﾞﾙｰﾌﾟ達の配列をﾌﾗｯﾄ化+ﾕﾆｰｸ化
  end
  
  def group_ids_of_staff
    groups_of_staff.map{ |i| i.id }
  end

  def group_recs_of_groups                               #ｸﾞﾙｰﾌﾟ達のidを含むgroup_recの配列をﾌﾗｯﾄ化
    ids = groups_of_staff.map{ |i| i.id }                #ｸﾞﾙｰﾌﾟ達のidの配列
    ids.map{ |k| GroupRec.find(:all, :conditions => ["group_id = ?", k], :order => "hizuke DESC") }.flatten
  end
  
  def group_recs_of_today
    GroupRec.find(:all).select {|j| j.hizuke == @attend.time_start.to_date }
  end  
  
  
#------------------------------------------------------------------------------------------------------------------------SHOW
  # GET /attends/1
  # GET /attends/1.xml
  def show
    @attend = Attend.find(params[:id])
    @icon02 = "/images/maximize.gif"
    @staff_recs= StaffRec.find(:all)
#---------------------------------------------------------------------------------------see if he/she is a staff 
  if current_user.staff and params[:main]
    @attend = current.user.staff.attends[0]
  end
#---------------------------------------------------------------------------------------prev/next
  @next = next_index(@attend)
  @prev = prev_index(@attend)

  @dif= (@attend.time_end - @attend.time_start)/3600 
    @attend = Attend.find(params[:id])
#---------------------------------------------------------------------------------------ｸﾞﾙｰﾌﾟ記録（group_recs）の抽出
    @group_recs = GroupRec.find(:all, :order => "hizuke DESC")
    @group_rec = @group_recs[0]
    @gp=Group.find(:all).map{|i| [i.name, i.id] }
    
#このｽﾀｯﾌが担当する児童の属するｸﾞﾙｰﾌﾟを判定する
  #担当児童のｸﾞﾙｰﾌﾟ達の配列をﾌﾗｯﾄ化+ﾕﾆｰｸ化
    @thegroups = @attend.staff.boys.map{ |i| i.groups }.flatten.uniq
  #ｸﾞﾙｰﾌﾟ達のidの配列
    @thegroup_ids = @thegroups.map{ |i| i.id }
    @thegroup_names = @thegroups.map{ |i| i.name }
#ｸﾞﾙｰﾌﾟ達のidを含むgroup_recの配列
    @thegroup_recs = @thegroup_ids.map{ |k| GroupRec.find(:all, :conditions => ["group_id = ?", k], :order => "hizuke DESC") }
  #これをﾌﾗｯﾄにする
    @thegroup_recs = @thegroup_recs.flatten

#最新の日付を含むthegroup_recsの先頭ﾚｺｰﾄﾞ
    @grp_recs_size = @thegroup_recs.size
    @newest_grp_rec = @thegroup_recs[0] if @thegroup_recs
    #@is_todays_rec = @thegroup_recs[0].hizuke == Date.today
    @thegroup_rec = @thegroup_recs[0]
    @group_now = @thegroups[0]
   # @grp_recs_today = GroupRec.find( :all, :conditions => ["hizuke = ?", @attend.time_start.to_date])
    
    @grp_recs_today = GroupRec.find(:all).select {|j| j.hizuke == @attend.time_start.to_date }
    

    @grp_recs_today_on = @grp_recs_today.select {|j| @thegroup_ids.include?(j.group.id)}

    @grp_recs_today_size = @grp_recs_today.size
#--------------------------------------------------------------------------------------
    x = GroupRec.find(:all).select {|j| j.hizuke == @attend.time_start.to_date }  #本日の日付のグループ記録
    if session[:grp]
    case session[:grp]
    when 'all'
      @grp_recs_today = x
    when 'on'
      @grp_recs_today = x.select {|i|  @thegroup_ids.include?(i.group_id) }       #xの内そのgroup_idが[:grp_ids]に含まれるもの
    when 'off'
      @grp_recs_today = GroupRec.find(:all).select {|j| j.hizuke == @attend.time_start.to_date }
    end
    end
    @grp_recs_today_on = @grp_recs_today.select {|j| @thegroup_ids.include?(j.group.id)}

    @grp_recs_today_size = @grp_recs_today.size    
    
#--------------------------------------------------------------------------------------各種記録の担当児童日毎該当表

  @boys   = @attend.staff.boys      #このｽﾀｯﾌの担当児童(@boys)
  @boyids = @boys.map{|i| i.id}     #担当児童のidの集合（配列）@boyids

  #このｽﾀｯﾌの担当児童を含むstay_out_recsをもとめる
  #その各ﾚｺｰﾄﾞについてmapで要素をboy.name/case_category/dayInRange?（attendの日付がstay_out_recの範囲か？）の３要素に変換する
  #上記の配列（の配列）をpartialのobjectに指定してpartial（_myjidou）を呼ぶ

  @boysincharge = @boys.map {|i| [i.name,
                                  i.stay_out_recs.select{ |j| (j.period_from..j.period_to) === @attend.time_start.to_date if i.stay_out_recs }.size ]}
  @boysincharge2 = @boys.map {|i| [i.name, boy_stay_out_recs(i)]}
  @boysincharge3 = @boys.map {|i| [i.name, boy_stay_out_recs(i), boy_school_recs(i)]}
  @boysincharge4 = @boys.map {|i| [i.name, boy_stay_out_recs(i), boy_school_recs(i), boy_med_recs(i), i.groups.map{|k|[k.name]}.to_s , i]}

  @boysincharge5 = @boys.map { |i| [i.name,                 #児童名前 jido[0] in _myjido.html.erb
                                    boy_shidou_recs(i),     #指導記録 jido[1] in _myjido.html.erb 該当ﾚｺｰﾄﾞ
                                    boy_school_recs(i),     #学校記録 jido[2] in _myjido.html.erb                               
                                    boy_med_recs(i),        #医療記録 jido[3] in _myjido.html.erb 
                                    boy_stay_out_recs(i),   #外泊記録 jido[4] in _myjido.html.erb
                                    i.groups.map{|k|[k.name]}.to_s, #ｸﾞﾙｰﾌﾟ  # jido[5] in _myjido.html.erb
                                    i] }                                     # jido[6] in _myjido.html.erb  


@k=ShidouRec.find(:all).select {|i| @boyids.include?(i.boy.id) } 
@m=ShidouRec.find(:all).select {|i| @boyids.include?(580145149) }
#--------------------------------------------------------------------------------------recs中のboy/staffをクリックして抽出実行
  boy=params[:boy]
  staff=params[:staff]
  if (boy)
    @shidou_recs = ShidouRec.find(:all,:conditions=>['boy_id=?',boy])
  else
    if (staff)
      @shidou_recs = ShidouRec.find(:all,:conditions=>['staff_id=?',staff])
    else
      if params[:k]
        @shidou_recs   = @k
        @school_recs   = SchoolRec.find(:all).select  {|i| @boyids.include?(i.boy.id) }
        @med_recs      = MedRec.find(:all).select     {|i| @boyids.include?(i.boy.id) }
        @stay_out_recs = StayOutRec.find(:all).select {|i| @boyids.include?(i.boy.id) }
      else
        @shidou_recs = ShidouRec.find(:all)
        @med_recs = MedRec.find(:all)
        @school_recs = SchoolRec.find(:all)
        @stay_out_recs = StayOutRec.find(:all)
      end
    end
  end

#--------------------------------------------------------------------------------------

    respond_to do |format|
      format.html # show.html.erb
      format.js      
      format.xml  { render :xml => @attend }

    end
  end

#------------------------------------------------------------------------------------------------------------------NEW
  # GET /attends/new
  # GET /attends/new.xml
  def new
    @time=Time.zone.now
    @attend = Attend.new
    #ログインユーザーがスタッフIDを持っている場合はstaff_idを先にセットする（2008.06.15）
    if current_user.staff
      @attend.staff_id = current_user.staff.id
      @attend.time_start=Time.now # if session[:staff]
      # 追加したコード
      @staffs = Staff.find(:all)
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @attend }
    end
  end

#-------------------------------------------------------------------------------------------------------------EDIT
  # GET /attends/1/edit
  def edit
    @attend = Attend.find(params[:id])
  end

#-------------------------------------------------------------------------------------------------------------CREATE
  # POST /attends
  # POST /attends.xml
  def create
    @attend = Attend.new(params[:attend])

    respond_to do |format|
      if @attend.save
        flash[:notice] = '登録に成功しました（出勤簿）'
        format.html { redirect_to(@attend) }
        format.xml  { render :xml => @attend, :status => :created, :location => @attend }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @attend.errors, :status => :unprocessable_entity }
      end
    end
  end
#-------------------------------------------------------------------------------------------------------------UPDATE
  # PUT /attends/1
  # PUT /attends/1.xml
  def update
    @attend = Attend.find(params[:id])
    respond_to do |format|
      if @attend.update_attributes(params[:attend])
        flash[:notice] = 'Attend was successfully updated.'
        format.html { redirect_to(@attend) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @attend.errors, :status => :unprocessable_entity }
      end
    end
  end
#-------------------------------------------------------------------------------------------------------------DESTROY
  # DELETE /attends/1
  # DELETE /attends/1.xml
  def destroy
    @attend = Attend.find(params[:id])
    @attend.destroy

    respond_to do |format|
      format.html { redirect_to(attends_url) }
      format.xml  { head :ok }
    end
  end
#-------------------------------------------------------------------------------------------------------------
private

end