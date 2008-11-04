class ShidouRecsController < ApplicationController

# added 2008.06.10 追加
before_filter :login_required

#----------------------------------------------------------------------------INPLACREDIT
in_place_edit_for :shidou_rec, :cat
in_place_edit_for :shidou_rec, :desc

#--------------------------------------------------------------------------------------------------------------INDEX
  # GET /shidou_recs
  # GET /shidou_recs.xml
  def index

  # 7/10 次行追加
    @shidou_recs = ShidouRec.find(:all, :order => "date DESC") 

  # 8/5 次行追加
  # @shidou_recs = ShidouRec.pagenate( :page => params[:page], :per_page => 2)
#------------------------------------------------------------------------------------------------**
    session[:kk] = params[:knd]                           #recs to display is stored in session[:kk] sel.rjs should render it
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
        @shidou_recs = ShidouRec.selected_year(yy).find(:all, :order => "date Desc")
      when "tm"
        @shidou_recs = ShidouRec.selected_year(yy).selected_month(Date.today.strftime("%m")).find(:all, :order => "date Desc")                     
      else
        @shidou_recs = ShidouRec.selected_year(yy).selected_month(params[:month]).find(:all, :order => "date Desc") 
    end
    #boy,staffで多重検索するためのｾｯｼｮﾝｽﾄｱ
    session[:ext] = @shidou_recs.map{|i| i.id}
#------------------------------------------------------------------------------------------------**
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shidou_recs }
    end
  end

#--------------------------------------------------------------------------------------------------------------SHOW
  # GET /shidou_recs/1
  # GET /shidou_recs/1.xml
  def show
    @shidou_rec = ShidouRec.find(params[:id])

boy=params[:boy]
if (boy)
    @shidou_recs = ShidouRec.find(:all,:conditions=>['boy_id=?',boy])
end

staff=params[:staff]
if (staff)
    @shidou_recs = ShidouRec.find(:all,:conditions=>['staff_id=?',staff])
end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shidou_rec }
    end
  end
#--------------------------------------------------------------------------------------------------------------NEW
  # GET /shidou_recs/new
  # GET /shidou_recs/new.xml

  def new

    @shidou_rec = ShidouRec.new
    # ログインユーザーがスタッフIDを持っている場合はstaff_idを先にセットする（2008.07.10）
    @shidou_rec.staff_id =current_user.staff.id if current_user
    @shidou_rec.date=Date.today
    # 以上変更
    @shidou_rec.boy_id = params[:boy_id] if params[:boy_id]
    @shidou_rec.date = params[:date] if params[:date] 
    @shidou_recs = ShidouRec.find(:all, :order=> "date DESC")

boy=params[:boy]
if (boy)
    @shidou_recs = ShidouRec.find(:all,:conditions=>['boy_id=?',boy])
end

staff=params[:staff]
if (staff)
    @shidou_recs = ShidouRec.find(:all,:conditions=>['staff_id=?',staff])
end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shidou_rec }
    end
  end

#--------------------------------------------------------------------------------------------------------------EDIT
  # GET /shidou_recs/1/edit
  def edit
    @shidou_rec = ShidouRec.find(params[:id])

  # BELOW LINE ADDED
    @shidou_recs = ShidouRec.find(:all, :order=> "date DESC")
boy=params[:boy]
if (boy)
    @shidou_recs = ShidouRec.find(:all,:conditions=>['boy_id=?',boy], :order=> "date DESC")
end

staff=params[:staff]
if (staff)
    @shidou_recs = ShidouRec.find(:all,:conditions=>['staff_id=?',staff], :order=> "date DESC")
end
  end

#--------------------------------------------------------------------------------------------------------------CREATE
  # POST /shidou_recs
  # POST /shidou_recs.xml
  def create
    @shidou_rec = ShidouRec.new(params[:shidou_rec])

    respond_to do |format|
      if @shidou_rec.save
        flash[:notice] = 'ShidouRec was successfully created.'
        format.html { redirect_to(@shidou_rec) }
        format.xml  { render :xml => @shidou_rec, :status => :created, :location => @shidou_rec }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shidou_rec.errors, :status => :unprocessable_entity }
      end
    end
  end

#--------------------------------------------------------------------------------------------------------------UPDATE
  # PUT /shidou_recs/1
  # PUT /shidou_recs/1.xml
  def update
    @shidou_rec = ShidouRec.find(params[:id])

    respond_to do |format|
      if @shidou_rec.update_attributes(params[:shidou_rec])
        flash[:notice] = 'ShidouRec was successfully updated.'
        format.html { redirect_to(@shidou_rec) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shidou_rec.errors, :status => :unprocessable_entity }
      end
    end
  end

#--------------------------------------------------------------------------------------------------------------DESTROY
  # DELETE /shidou_recs/1
  # DELETE /shidou_recs/1.xml
  def destroy
    @shidou_rec = ShidouRec.find(params[:id])
    @shidou_rec.destroy

    respond_to do |format|
      format.html { redirect_to(shidou_recs_url) }
      format.xml  { head :ok }
    end
  end
end