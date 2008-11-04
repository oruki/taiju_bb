class MedRecsController < ApplicationController
# added 2008.06.10 added
before_filter :login_required
#-----------------------------------------------------------------------------------------------------------------------------INDEX
  # GET /med_recs
  # GET /med_recs.xml
  def index
    @med_recs = MedRec.find(:all, :order => "date Desc")
#------------------------------------------------------------------------------------------------**
    session[:kk] = params[:knd]       #recs to display is stored in session[:kk] sel.rjs should render it
    session[:jj] = params[:jido]  if params[:jido]
    session[:yy] = params[:year]  if params[:year]
    session[:mm] = params[:month] if params[:month]
             
    if params[:year]      #params[:year]が設定されていない場合はyyを今年に設定する
      yy = params[:year]
    else
      yy = Date.today.strftime("%Y")
    end
    
    session[:yy] ||= yy
        
    case params[:month]   #配列の降順指定のため末尾に.find(:all, :order => "date Desc")を追加
                          #named_scopeはモデル名の直下に使用する
      when "aa"
        @med_recs = MedRec.selected_year(yy).find(:all, :order => "date Desc")
      when "tm"
        @med_recs = MedRec.selected_year(yy).selected_month(Date.today.strftime("%m")).find(:all, :order => "date Desc")                     
      else
        @med_recs = MedRec.selected_year(yy).selected_month(params[:month]).find(:all, :order => "date Desc") 
    end
    #boy,staffで多重検索するためのｾｯｼｮﾝｽﾄｱ
    session[:ext] = @med_recs.map{|i| i.id}
#------------------------------------------------------------------------------------------------**

#2008-08-08 年月により抽出するラジオボタンを追加

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @med_recs }
    end
  end
#-----------------------------------------------------------------------------------------------------------------------------SHOW
  # GET /med_recs/1
  # GET /med_recs/1.xml
  def show
    @med_rec = MedRec.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @med_rec }
    end
  end
#-----------------------------------------------------------------------------------------------------------------------------NEW
  # GET /med_recs/new
  # GET /med_recs/new.xml
  def new
    @med_rec = MedRec.new
  #ADDED
    @med_recs = MedRec.find(:all, :order => "date Desc")
    # ログインユーザーがスタッフIDを持っている場合はstaff_idを先にセットする（2008.07.10）
    @med_rec.staff_id = current_user.staff.id if current_user
    @med_rec.date = params[:date] if params[:date] 
    @med_rec.boy_id = params[:boy_id] if params[:boy_id]
  # 以上変更    
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @med_rec }
    end
  end
#-----------------------------------------------------------------------------------------------------------------------------EDIT
  # GET /med_recs/1/edit
  def edit
    @med_rec = MedRec.find(params[:id])
  #ADDED
    @med_recs = MedRec.find(:all, :order => "date Desc")

  end
#-----------------------------------------------------------------------------------------------------------------------------CREATE
  # POST /med_recs
  # POST /med_recs.xml
  def create
    @med_rec = MedRec.new(params[:med_rec])

    respond_to do |format|
      if @med_rec.save
        flash[:notice] = 'MedRec was successfully created.'
        format.html { redirect_to(@med_rec) }
        format.xml  { render :xml => @med_rec, :status => :created, :location => @med_rec }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @med_rec.errors, :status => :unprocessable_entity }
      end
    end
  end
#-----------------------------------------------------------------------------------------------------------------------------UPDATE
  # PUT /med_recs/1
  # PUT /med_recs/1.xml
  def update
    @med_rec = MedRec.find(params[:id])

    respond_to do |format|
      if @med_rec.update_attributes(params[:med_rec])
        flash[:notice] = 'MedRec was successfully updated.'
        format.html { redirect_to(@med_rec) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @med_rec.errors, :status => :unprocessable_entity }
      end
    end
  end
#-----------------------------------------------------------------------------------------------------------------------------DESTROY
  # DELETE /med_recs/1
  # DELETE /med_recs/1.xml
  def destroy
    @med_rec = MedRec.find(params[:id])
    @med_rec.destroy

    respond_to do |format|
      format.html { redirect_to(med_recs_url) }
      format.xml  { head :ok }
    end
  end
end