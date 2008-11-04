class DayRecsController < ApplicationController
# added 2008.07.31 added　日本語
before_filter :login_required

#-----------------------------------------------------------------------index
  # GET /day_recs
  # GET /day_recs.xml
  def index
    @day_recs = DayRec.find(:all, :order => "hizuke DESC")

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
        @day_recs = DayRec.selected_year(yy).find(:all, :order => "hizuke Desc")
      when "tm"
        @day_recs = DayRec.selected_year(yy).selected_month(Date.today.strftime("%m")).find(:all, :order => "hizuke Desc")                     
      else
        @day_recs = DayRec.selected_year(yy).selected_month(params[:month]).find(:all, :order => "hizuke Desc") 
    end
#------------------------------------------------------------------------------------------------**

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @day_recs }
    end
  end
#-----------------------------------------------------------------------show
  # GET /day_recs/1
  # GET /day_recs/1.xml
  def show
    @day_rec = DayRec.find(params[:id])
#collection of the day
    @group_recs = GroupRec.find(:all,:conditions=>['hizuke=?',@day_rec.hizuke])

    @shidou_recs = ShidouRec.find(:all,:conditions=>['date=?',@day_rec.hizuke])

    @school_recs = SchoolRec.find(:all,:conditions=>['date=?',@day_rec.hizuke])

    @med_recs = MedRec.find(:all,:conditions=>['date=?',@day_rec.hizuke])

    @stay_out_recs = StayOutRec.find(:all,:conditions=>['date=?',@day_rec.hizuke])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @day_rec }
    end
  end
#-----------------------------------------------------------------------new
  # GET /day_recs/new
  # GET /day_recs/new.xml
  def new
    @day_rec = DayRec.new
    @day_recs = DayRec.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @day_rec }
    end
  end
#-----------------------------------------------------------------------edit
  # GET /day_recs/1/edit
  def edit
    @day_rec = DayRec.find(params[:id])
#BELOW ADDED ON 2008.07.11
    @day_recs = DayRec.find(:all, :order => "hizuke DESC")

  end
#-----------------------------------------------------------------------create
  # POST /day_recs
  # POST /day_recs.xml
  def create
    @day_rec = DayRec.new(params[:day_rec])

    respond_to do |format|
      if @day_rec.save
        flash[:notice] = 'DayRec was successfully created.'
        format.html { redirect_to(@day_rec) }
        format.xml  { render :xml => @day_rec, :status => :created, :location => @day_rec }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @day_rec.errors, :status => :unprocessable_entity }
      end
    end
  end
#-----------------------------------------------------------------------update
  # PUT /day_recs/1
  # PUT /day_recs/1.xml
  def update
    @day_rec = DayRec.find(params[:id])

    respond_to do |format|
      if @day_rec.update_attributes(params[:day_rec])
        flash[:notice] = '登録に成功しました（業務記録）'
        format.html { redirect_to(@day_rec) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @day_rec.errors, :status => :unprocessable_entity }
      end
    end
  end
#-----------------------------------------------------------------------delete
  # DELETE /day_recs/1
  # DELETE /day_recs/1.xml
  def destroy
    @day_rec = DayRec.find(params[:id])
    @day_rec.destroy

    respond_to do |format|
      format.html { redirect_to(day_recs_url) }
      format.xml  { head :ok }
    end
  end
end