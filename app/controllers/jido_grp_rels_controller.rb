class JidoGrpRelsController < ApplicationController
# added 2008.06.10 added
before_filter :login_required

  def sort_grp
    @jgrs = JidoGrpRel.find(:all, :order => "name")
    render :action => "index"
    respond_to do |format|
      format.html # sort_grp.html.erb
      format.xml  { render :xml => @jido_grp_rels }
    end
  end

  # GET /jido_grp_rels
  # GET /jido_grp_rels.xml----------------------------------------------------------index
  def index
    @jido_grp_rels = JidoGrpRel.find(:all)
    if params[:sort]=="grp"
      @jido_grp_rels = JidoGrpRel.find(:all, :order => :group_id )
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jido_grp_rels }
    end
  end

  # GET /jido_grp_rels/1
  # GET /jido_grp_rels/1.xml----------------------------------------------------------show
  def show
    @jido_grp_rel = JidoGrpRel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @jido_grp_rel }
    end
  end

  # GET /jido_grp_rels/new
  # GET /jido_grp_rels/new.xml----------------------------------------------------------
  def new
    @jido_grp_rel = JidoGrpRel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @jido_grp_rel }
    end
  end

  # GET /jido_grp_rels/1/edit
  def edit
    @jido_grp_rel = JidoGrpRel.find(params[:id])
  end

  # POST /jido_grp_rels
  # POST /jido_grp_rels.xml
  def create
    @jido_grp_rel = JidoGrpRel.new(params[:jido_grp_rel])

    respond_to do |format|
      if @jido_grp_rel.save
        flash[:notice] = 'JidoGrpRel was successfully created.'
        format.html { redirect_to(@jido_grp_rel) }
        format.xml  { render :xml => @jido_grp_rel, :status => :created, :location => @jido_grp_rel }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @jido_grp_rel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jido_grp_rels/1
  # PUT /jido_grp_rels/1.xml
  def update
    @jido_grp_rel = JidoGrpRel.find(params[:id])

    respond_to do |format|
      if @jido_grp_rel.update_attributes(params[:jido_grp_rel])
        flash[:notice] = 'JidoGrpRel was successfully updated.'
        format.html { redirect_to(@jido_grp_rel) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @jido_grp_rel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jido_grp_rels/1
  # DELETE /jido_grp_rels/1.xml
  def destroy
    @jido_grp_rel = JidoGrpRel.find(params[:id])
    @jido_grp_rel.destroy

    respond_to do |format|
      format.html { redirect_to(jido_grp_rels_url) }
      format.xml  { head :ok }
    end
  end
end