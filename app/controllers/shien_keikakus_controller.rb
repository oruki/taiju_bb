class ShienKeikakusController < ApplicationController
# added 2008.06.10 added
before_filter :login_required

  # GET /shien_keikakus
  # GET /shien_keikakus.xml
  def index
    @shien_keikakus = ShienKeikaku.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shien_keikakus }
    end
  end

  # GET /shien_keikakus/1
  # GET /shien_keikakus/1.xml
  def show
    @shien_keikaku = ShienKeikaku.find(params[:id])
    @boy = @shien_keikaku.boy
    @attr ||= 'honnin_ikou'
    @seisakusha = @shien_keikaku.staff.name
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shien_keikaku }
      format.js
    end
  end

  # GET /shien_keikakus/new
  # GET /shien_keikakus/new.xml
  def new
    @shien_keikaku = ShienKeikaku.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shien_keikaku }
    end
  end

  # GET /shien_keikakus/1/edit---------------------------------------------------edit
  def edit
    @shien_keikaku = ShienKeikaku.find(params[:id])
  end


  # GET /shien_keikakus/1/putbox---------------------------------------------------putbox
  def putbox
    @shien_keikaku = ShienKeikaku.find(params[:id])
    @attr = params[:attr]
    respond_to do |format|
      format.html # edit_item.html.erb
      format.xml  { render :xml => @shien_keikaku }
      format.js
    end
  end





  # POST /shien_keikakus
  # POST /shien_keikakus.xml
  def create
    @shien_keikaku = ShienKeikaku.new(params[:shien_keikaku])

    respond_to do |format|
      if @shien_keikaku.save
        flash[:notice] = 'ShienKeikaku was successfully created.'
        format.html { redirect_to(@shien_keikaku) }
        format.xml  { render :xml => @shien_keikaku, :status => :created, :location => @shien_keikaku }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shien_keikaku.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /shien_keikakus/1
  # PUT /shien_keikakus/1.xml---------------------------------------------------------update
  def updateAlt
    @shien_keikaku = ShienKeikaku.find(params[:id])
    @attr = params[:attr]
  # GETTING THE ATTR VALUE
    @attrval = eval '@shien_keikaku' + '.' + @attr
    respond_to do |format|
      if @shien_keikaku.update_attributes(params[:shien_keikaku]) then
        flash[:notice] = 'ShienKeikaku was successfully updated(2008.07.06).'
    @attrval = eval '@shien_keikaku' + '.' + @attr
        format.html { redirect_to(@shien_keikaku) }
        format.xml  { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shien_keikaku.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /shien_keikakus/1
  # PUT /shien_keikakus/1.xml
  def update
    @shien_keikaku = ShienKeikaku.find(params[:id])
   # render(:partial => "comm", :object => @shien_keikaku)

    respond_to do |format|
      if @shien_keikaku.update_attributes(params[:shien_keikaku])
        flash[:notice] ='正常に更新されました（支援計画）'
        format.html { redirect_to(@shien_keikaku) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shien_keikaku.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shien_keikakus/1
  # DELETE /shien_keikakus/1.xml
  def destroy
    @shien_keikaku = ShienKeikaku.find(params[:id])
    @shien_keikaku.destroy

    respond_to do |format|
      format.html { redirect_to(shien_keikakus_url) }
      format.xml  { head :ok }
    end
  end
end