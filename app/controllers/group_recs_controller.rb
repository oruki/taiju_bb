class GroupRecsController < ApplicationController
# added 2008.07.31 added
before_filter :login_required
#------------------------------------------------------------------------------------------------------INDEX
  # GET /group_recs
  # GET /group_recs.xml
  def index
    @group_recs = GroupRec.find(:all, :order => "hizuke DESC")
    
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
        @group_recs = GroupRec.selected_year(yy).find(:all, :order => "hizuke Desc")
      when "tm"
        @group_recs = GroupRec.selected_year(yy).selected_month(Date.today.strftime("%m")).find(:all, :order => "hizuke Desc")                     
      else
        @group_recs = GroupRec.selected_year(yy).selected_month(params[:month]).find(:all, :order => "hizuke Desc") 
    end
#------------------------------------------------------------------------------------------------**
    @groups=Group.find(:all).map{|g| [g.name, g.cat, g.id]}
    @groups=Group.find(:all).map{|g| [g.name, g.cat, g.id]}
    if params[:grp]
      @group_recs = GroupRec.find(:all, :conditions => {:group_id => params[:grp] }, :order => "hizuke DESC")
    end
#------------------------------------------------------------------------------------------------**
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @group_recs }
    end
  end

#------------------------------------------------------------------------------------------------------SHOW
  # GET /group_recs/1
  # GET /group_recs/1.xml
  def show
    @group_rec = GroupRec.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group_rec }
    end
  end
  
#------------------------------------------------------------------------------------------------------NEW
  # GET /group_recs/new
  # GET /group_recs/new.xml
  def new
    @group_rec = GroupRec.new
  #ADDED BELOW LINE
    @gp=Group.find(:all).map{|i| [i.name, i.id] }    # for selection box used in new view

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group_rec }
    end
  end
  
#------------------------------------------------------------------------------------------------------EDIT
  # GET /group_recs/1/edit
  def edit
    @group_rec = GroupRec.find(params[:id])
  #ADDED BELOW LINE
    @group_recs = GroupRec.find(:all, :order => "hizuke DESC")
    @gp=Group.find(:all).map{|i| [i.name, i.id] }    # for selection box used in new view
  end
  
#------------------------------------------------------------------------------------------------------CREATE
  # POST /group_recs
  # POST /group_recs.xml
  def create
    @group_rec = GroupRec.new(params[:group_rec])

    respond_to do |format|
      if @group_rec.save
        flash[:notice] = 'GroupRec was successfully created.'
        format.html { redirect_to(@group_rec) }
        format.xml  { render :xml => @group_rec, :status => :created, :location => @group_rec }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group_rec.errors, :status => :unprocessable_entity }
      end
    end
  end
#------------------------------------------------------------------------------------------------------UPDATE
  # PUT /group_recs/1
  # PUT /group_recs/1.xml
  def update
    @group_rec = GroupRec.find(params[:id])

    respond_to do |format|
      if @group_rec.update_attributes(params[:group_rec])
        flash[:notice] = 'GroupRec was successfully updated.'
        format.html { redirect_to(@group_rec) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group_rec.errors, :status => :unprocessable_entity }
      end
    end
  end
#------------------------------------------------------------------------------------------------------DESTROY
  # DELETE /group_recs/1
  # DELETE /group_recs/1.xml
  def destroy
    @group_rec = GroupRec.find(params[:id])
    @group_rec.destroy

    respond_to do |format|
      format.html { redirect_to(group_recs_url) }
      format.xml  { head :ok }
    end
  end
end