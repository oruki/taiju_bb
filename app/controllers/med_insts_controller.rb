class MedInstsController < ApplicationController
# added 2008.06.10 added
before_filter :login_required

in_place_edit_for :med_inst, :name

  # GET /med_insts
  # GET /med_insts.xml
  def index
    @med_insts = MedInst.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @med_insts }
    end
  end

  # GET /med_insts/1
  # GET /med_insts/1.xml
  def show
    @med_inst = MedInst.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @med_inst }
    end
  end

  # GET /med_insts/new
  # GET /med_insts/new.xml
  def new
    @med_inst = MedInst.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @med_inst }
    end
  end

  # GET /med_insts/1/edit
  def edit
    @med_inst = MedInst.find(params[:id])
  end

  # POST /med_insts
  # POST /med_insts.xml
  def create
    @med_inst = MedInst.new(params[:med_inst])

    respond_to do |format|
      if @med_inst.save
        flash[:notice] = '１件のレコードが新規に作成されました（医療機関）'
        format.html { redirect_to(@med_inst) }
        format.xml  { render :xml => @med_inst, :status => :created, :location => @med_inst }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @med_inst.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /med_insts/1
  # PUT /med_insts/1.xml
  def update
    @med_inst = MedInst.find(params[:id])

    respond_to do |format|
      if @med_inst.update_attributes(params[:med_inst])
        flash[:notice] = 'レコードは正しく更新されました（医療機関）'
        format.html { redirect_to(@med_inst) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @med_inst.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /med_insts/1
  # DELETE /med_insts/1.xml
  def destroy
    @med_inst = MedInst.find(params[:id])
    @med_inst.destroy

    respond_to do |format|
      format.html { redirect_to(med_insts_url) }
      format.xml  { head :ok }
    end
  end
end