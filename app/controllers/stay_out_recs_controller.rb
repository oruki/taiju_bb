class StayOutRecsController < ApplicationController
# added 2008.06.10 added
before_filter :login_required
#-----------------------------------------------------------------------------------------------------------------------------INDEX
  # GET /stay_out_recs
  # GET /stay_out_recs.xml
  def index
    @stay_out_recs = StayOutRec.find(:all, :order => "date DESC")
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
        @stay_out_recs = StayOutRec.selected_year(yy).find(:all, :order => "date Desc")
      when "tm"
        @stay_out_recs = StayOutRec.selected_year(yy).selected_month(Date.today.strftime("%m")).find(:all, :order => "date Desc")                     
      else
        @stay_out_recs = StayOutRec.selected_year(yy).selected_month(params[:month]).find(:all, :order => "date Desc") 
    end
    #boy,staffで多重検索するためのｾｯｼｮﾝｽﾄｱ
    session[:ext] = @stay_out_recs.map{|i| i.id}
#------------------------------------------------------------------------------------------------**
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stay_out_recs }
    end
  end

#-----------------------------------------------------------------------------------------------------------------------------SHOW
  # GET /stay_out_recs/1
  # GET /stay_out_recs/1.xml
  def show
    @stay_out_rec = StayOutRec.find(params[:id])
#ADDED
    @stay_out_recs = StayOutRec.find(:all)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stay_out_rec }
    end
  end



#-----------------------------------------------------------------------------------------------------------------------------NEW
  # GET /stay_out_recs/new
  # GET /stay_out_recs/new.xml
  def new
    @stay_out_rec = StayOutRec.new("rcv_name" => params[:thestaff],"boy_id" => params[:boy_id])
#ADDED
    @stay_out_recs = StayOutRec.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stay_out_rec }
    end
  end

#-----------------------------------------------------------------------------------------------------------------------------EDIT
  # GET /stay_out_recs/1/edit
  def edit
    @stay_out_rec = StayOutRec.find(params[:id])
#ADDED
    @stay_out_recs = StayOutRec.find(:all)
  end
#-----------------------------------------------------------------------------------------------------------------------------CREATE
  # POST /stay_out_recs
  # POST /stay_out_recs.xml
  def create
    @stay_out_rec = StayOutRec.new(params[:stay_out_rec])

    respond_to do |format|
      if @stay_out_rec.save
        flash[:notice] = 'StayOutRec was successfully created.'
        format.html { redirect_to(@stay_out_rec) }
        format.xml  { render :xml => @stay_out_rec, :status => :created, :location => @stay_out_rec }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @stay_out_rec.errors, :status => :unprocessable_entity }
      end
    end
  end

#-----------------------------------------------------------------------------------------------------------------------------UPDATE
  # PUT /stay_out_recs/1
  # PUT /stay_out_recs/1.xml
  def update
    @stay_out_rec = StayOutRec.find(params[:id])

    respond_to do |format|
      if @stay_out_rec.update_attributes(params[:stay_out_rec])
        flash[:notice] = 'StayOutRec was successfully updated.'
        format.html {redirect_to(@stay_out_rec) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stay_out_rec.errors, :status => :unprocessable_entity }
      end
    end
  end

#-----------------------------------------------------------------------------------------------------------------------------DESTROY
  # DELETE /stay_out_recs/1
  # DELETE /stay_out_recs/1.xml
  def destroy
    @stay_out_rec = StayOutRec.find(params[:id])
    @stay_out_rec.destroy

    respond_to do |format|
      format.html { redirect_to(stay_out_recs_url) }
      format.xml  { head :ok }
    end
  end
end