class JidoGuardianRelsController < ApplicationController
# added 2008.06.10 added
  before_filter :login_required

  # GET /jido_guardian_rels
  # GET /jido_guardian_rels.xml
  def index
    @jido_guardian_rels = JidoGuardianRel.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jido_guardian_rels }
    end
  end

  # GET /jido_guardian_rels/1
  # GET /jido_guardian_rels/1.xml
  def show
    @jido_guardian_rel = JidoGuardianRel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @jido_guardian_rel }
    end
  end

  # GET /jido_guardian_rels/new
  # GET /jido_guardian_rels/new.xml
  def new
    @jido_guardian_rel = JidoGuardianRel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @jido_guardian_rel }
    end
  end

  # GET /jido_guardian_rels/1/edit
  def edit
    @jido_guardian_rel = JidoGuardianRel.find(params[:id])
  end

  # POST /jido_guardian_rels
  # POST /jido_guardian_rels.xml
  def create
    @jido_guardian_rel = JidoGuardianRel.new(params[:jido_guardian_rel])

    respond_to do |format|
      if @jido_guardian_rel.save
        flash[:notice] = 'JidoGuardianRel was successfully created.'
        format.html { redirect_to(@jido_guardian_rel) }
        format.xml  { render :xml => @jido_guardian_rel, :status => :created, :location => @jido_guardian_rel }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @jido_guardian_rel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jido_guardian_rels/1
  # PUT /jido_guardian_rels/1.xml
  def update
    @jido_guardian_rel = JidoGuardianRel.find(params[:id])

    respond_to do |format|
      if @jido_guardian_rel.update_attributes(params[:jido_guardian_rel])
        flash[:notice] = 'JidoGuardianRel was successfully updated.'
        format.html { redirect_to(@jido_guardian_rel) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @jido_guardian_rel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jido_guardian_rels/1
  # DELETE /jido_guardian_rels/1.xml
  def destroy
    @jido_guardian_rel = JidoGuardianRel.find(params[:id])
    @jido_guardian_rel.destroy

    respond_to do |format|
      format.html { redirect_to(jido_guardian_rels_url) }
      format.xml  { head :ok }
    end
  end
end