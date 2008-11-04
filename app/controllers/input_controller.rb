class InputController < ApplicationController
# added 2008.06.10 added
before_filter :login_required

  # GET /edu_insts
  # GET /edu_insts.xml
  def index
    @edu_insts = EduInst.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @edu_insts }
    end
  end

  # GET /edu_insts
  # GET /edu_insts.xml----------------------------------------------------------------------------
  def testup
    @shien_keikaku=ShienKeikaku.find(params[:id])

    respond_to do |format|
      format.html # testup.html.erb
      format.xml  { render :xml => @edu_insts }
    end
  end



  # GET /boys/1/edit
  def edit
    @boy = Boy.find(params[:id])
  end

  # POST /boys
  # POST /boys.xml
  def create
    @boy = Boy.new(params[:boy])

    respond_to do |format|
      if @boy.save
        flash[:notice] = 'Boy was successfully created.'
        format.html { redirect_to(@boy) }
        format.xml  { render :xml => @boy, :status => :created, :location => @boy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @boy.errors, :status => :unprocessable_entity }
      end
    end
  end



  # PUT /shien_keikakus/1
  # PUT /shien_keikakus/1.xml--------------------------------------------------------
  def update
    @shien_keikaku = ShienKeikaku.find(params[:id])

    respond_to do |format|
      if @shien_keikaku.update_attributes(params[:shien_keikaku])
        flash[:notice] = 'ShienKeikaku was successfully updated.'
        format.html { redirect_to(:controller => "shien_keikakus", :action => "show", :id => @shien_keikaku) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shien_keikaku.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /boys/1
  # DELETE /boys/1.xml
  def destroy
    @boy = Boy.find(params[:id])
    @boy.destroy

    respond_to do |format|
      format.html { redirect_to(boys_url) }
      format.xml  { head :ok }
    end
  end
end