class JidosController < ApplicationController
# added 2008.06.10 added
before_filter :login_required

  # GET /jidos
  # GET /jidos.xml
  def index
    @jidos = Jido.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jidos }
    end
  end

  # GET /jidos/1
  # GET /jidos/1.xml
  def show
    @jido = Jido.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @jido }
    end
  end

  # GET /jidos/new
  # GET /jidos/new.xml
  def new
    @jido = Jido.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @jido }
    end
  end

  # GET /jidos/1/edit
  def edit
    @jido = Jido.find(params[:id])
  end

  # POST /jidos
  # POST /jidos.xml
  def create
    @jido = Jido.new(params[:jido])

    respond_to do |format|
      if @jido.save
        flash[:notice] = 'Jido was successfully created.'
        format.html { redirect_to(@jido) }
        format.xml  { render :xml => @jido, :status => :created, :location => @jido }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @jido.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jidos/1
  # PUT /jidos/1.xml
  def update
    @jido = Jido.find(params[:id])

    respond_to do |format|
      if @jido.update_attributes(params[:jido])
        flash[:notice] = 'Jido was successfully updated.'
        format.html { redirect_to(@jido) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @jido.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jidos/1
  # DELETE /jidos/1.xml
  def destroy
    @jido = Jido.find(params[:id])
    @jido.destroy

    respond_to do |format|
      format.html { redirect_to(jidos_url) }
      format.xml  { head :ok }
    end
  end
end