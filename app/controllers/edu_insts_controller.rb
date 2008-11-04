class EduInstsController < ApplicationController
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

  # GET /edu_insts/1
  # GET /edu_insts/1.xml
  def show
    @edu_inst = EduInst.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @edu_inst }
    end
  end

  # GET /edu_insts/new
  # GET /edu_insts/new.xml
  def new
    @edu_inst = EduInst.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @edu_inst }
    end
  end

  # GET /edu_insts/1/edit
  def edit
    @edu_inst = EduInst.find(params[:id])
  end

  # POST /edu_insts
  # POST /edu_insts.xml
  def create
    @edu_inst = EduInst.new(params[:edu_inst])

    respond_to do |format|
      if @edu_inst.save
        flash[:notice] = 'EduInst was successfully created.'
        format.html { redirect_to(@edu_inst) }
        format.xml  { render :xml => @edu_inst, :status => :created, :location => @edu_inst }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @edu_inst.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /edu_insts/1
  # PUT /edu_insts/1.xml
  def update
    @edu_inst = EduInst.find(params[:id])

    respond_to do |format|
      if @edu_inst.update_attributes(params[:edu_inst])
        flash[:notice] = '&#12524;&#12467;&#12540;&#12489;&#12399;&#26356;&#26032;&#12373;&#12428;&#12414;&#12375;&#12383;&#65288;&#25945;&#32946;&#27231;&#38306;&#65289;'
        format.html { redirect_to(@edu_inst) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @edu_inst.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /edu_insts/1
  # DELETE /edu_insts/1.xml
  def destroy
    @edu_inst = EduInst.find(params[:id])
    @edu_inst.destroy

    respond_to do |format|
      format.html { redirect_to(edu_insts_url) }
      format.xml  { head :ok }
    end
  end
end