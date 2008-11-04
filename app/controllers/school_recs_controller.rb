class SchoolRecsController < ApplicationController
# added 2008.06.10 added
before_filter :login_required
#----------------------------------------------------------------------------INPLACREDIT

# in_place_edit_for :school_rec, :message_to
# in_place_edit_for :school_rec, :message_from

#-----------------------------------------------------------------------------------------------------------------------------INDEX
  # GET /school_recs
  # GET /school_recs.xml
  def index
    @school_recs = SchoolRec.find(:all, :order => "date DESC")
    
    if params[:boy]
      @school_recs = SchoolRec.find(:all, :conditions=>['boy_id=?',params[:boy]], :order => "date DESC")
    end
  
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
        @school_recs = SchoolRec.selected_year(yy).find(:all, :order => "date Desc")
      when "tm"
        @school_recs = SchoolRec.selected_year(yy).selected_month(Date.today.strftime("%m")).find(:all, :order => "date Desc")                     
      else
        @school_recs = SchoolRec.selected_year(yy).selected_month(params[:month]).find(:all, :order => "date Desc") 
    end
    #boy,staffで多重検索するためのｾｯｼｮﾝｽﾄｱ
    session[:ext] = @school_recs.map{|i| i.id}
#------------------------------------------------------------------------------------------------**
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @school_recs }
    end
  end

#-----------------------------------------------------------------------------------------------------------------------------SHOW
  # GET /school_recs/1
  # GET /school_recs/1.xml
  def show
    @school_rec = SchoolRec.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @school_rec }
    end
  end

#-----------------------------------------------------------------------------------------------------------------------------NEW
  # GET /school_recs/new
  # GET /school_recs/new.xml
  def new
  # ADDED BELOW(2008.07.10)

    @school_rec = SchoolRec.new
    # ログインユーザーがスタッフIDを持っている場合はstaff_idを先にセットする（2008.07.10）
    @school_rec.staff_id = current_user.staff.id if current_user
    @school_rec.date = Date.today
    @school_rec.boy_id = params[:boy_id] if params[:boy_id]
    @school_rec.date = params[:date] if params[:date]    
    # 以上変更

    @school_recs = SchoolRec.find(:all, :order => "date DESC")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @school_rec }
    end
  end

#-----------------------------------------------------------------------------------------------------------------------------EDIT
  # GET /school_recs/1/edit
  def edit
    #ADDED BELOW(2008.07.10)
    @school_recs = SchoolRec.find(:all, :order => "date DESC")
    @school_rec = SchoolRec.find(params[:id])
    
        @school_rec.boy_id = params[:boy_id] if params[:boy_id]
        
  end

#-----------------------------------------------------------------------------------------------------------------------------CREATE
  # POST /school_recs
  # POST /school_recs.xml
  def create
    @school_rec = SchoolRec.new(params[:school_rec])

    respond_to do |format|
      if @school_rec.save
        flash[:notice] = 'SchoolRec was successfully created.'
        format.html { redirect_to(@school_rec) }
        format.xml  { render :xml => @school_rec, :status => :created, :location => @school_rec }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @school_rec.errors, :status => :unprocessable_entity }
      end
    end
  end

#-----------------------------------------------------------------------------------------------------------------------------UPDATE
  # PUT /school_recs/1
  # PUT /school_recs/1.xml
  def update
    @school_rec = SchoolRec.find(params[:id])

    respond_to do |format|
      if @school_rec.update_attributes(params[:school_rec])
        flash[:notice] = 'SchoolRec was successfully updated.'
        format.html { redirect_to(@school_rec) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @school_rec.errors, :status => :unprocessable_entity }
      end
    end
  end

#-----------------------------------------------------------------------------------------------------------------------------DESTROY
  # DELETE /school_recs/1
  # DELETE /school_recs/1.xml
  def destroy
    @school_rec = SchoolRec.find(params[:id])
    @school_rec.destroy

    respond_to do |format|
      format.html { redirect_to(school_recs_url) }
      format.xml  { head :ok }
    end
  end
end