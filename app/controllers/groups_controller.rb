class GroupsController < ApplicationController
# added 2008.06.10 added
  before_filter :login_required
#-----------------------------------------------------------------------------------------------------------INDEX
  # GET /groups
  # GET /groups.xml
  def index
    @groups = Group.find(:all)

#------------------------------------------------------------------------------------------------**
    session[:kk] = params[:knd]       #recs to display is stored in session[:kk] sel.rjs should render it
    session[:jj] = params[:jido]  if params[:jido]
    session[:yy] = params[:year]  if params[:year]
    session[:mm] = params[:month] if params[:month]
             
    if params[:year]      #params[:year]
      yy = params[:year]
    else
      yy = Date.today.strftime("%Y")
    end
    
    case params[:month]   #.find(:all, :order => "date Desc")
                          #named_scope
      when "aa"
        @group_recs = GroupRec.selected_year(yy).find(:all, :order => "hizuke Desc")
      when "tm"
        @group_recs = GroupRec.selected_year(yy).selected_month(Date.today.strftime("%m")).find(:all, :order => "hizuke Desc")                     
      else
        @group_recs = GroupRec.selected_year(yy).selected_month(params[:month]).find(:all, :order => "hizuke Desc") 
    end
#------------------------------------------------------------------------------------------------**
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end
#-----------------------------------------------------------------------------------------------------------SHOW
  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to(@group) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to(@group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
    end
  end
end