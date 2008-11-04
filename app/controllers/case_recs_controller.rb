#日本語

class CaseRecsController < ApplicationController
  
before_filter :login_required

  # GET /case_recs
  # GET /case_recs.xml
  def index
    @case_recs = CaseRec.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @case_recs }
    end
  end
  # -----------------------------------------------------------------------------------show
  # GET /case_recs/1
  # GET /case_recs/1.xml
  def show
    @case_rec = CaseRec.find(params[:id])
    @boys = Boy.find(:all)
    
    b01 = CaseRec.find(:all).map{ |i| i.boy }          #boys in case_recs
    b02 = current_user.staff.boys                      #boys cared by current_user
    b03 =  b02 & b01                                   #union of arrey b01 and b02
    @options_for_boy = b03.map{|k| [k.name, k.id] }    #used in selection dropdown
    
    @options_for_boy.insert 0,["…児童を選択…" , '']
    

    if params[:boy_id]
      @case_rec = CaseRec.find( :first, :conditions=> ["boy_id = ?", params[:boy_id]] )
      #@case_rec = CaseRec.find(params[:boy_id])
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @case_rec }
    end
  end

  # GET /case_recs/new
  # GET /case_recs/new.xml
  def new
    @case_rec = CaseRec.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @case_rec }
    end
  end

  # GET /case_recs/1/edit
  def edit
    @case_rec = CaseRec.find(params[:id])
  end

  # POST /case_recs
  # POST /case_recs.xml
  def create
    @case_rec = CaseRec.new(params[:case_rec])

    respond_to do |format|
      if @case_rec.save
        flash[:notice] = 'CaseRec was successfully created.'
        format.html { redirect_to(@case_rec) }
        format.xml  { render :xml => @case_rec, :status => :created, :location => @case_rec }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @case_rec.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /case_recs/1
  # PUT /case_recs/1.xml
  def update
    @case_rec = CaseRec.find(params[:id])

    respond_to do |format|
      if @case_rec.update_attributes(params[:case_rec])
        flash[:notice] = 'CaseRec was successfully updated.'
        format.html { redirect_to(@case_rec) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @case_rec.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /case_recs/1
  # DELETE /case_recs/1.xml
  def destroy
    @case_rec = CaseRec.find(params[:id])
    @case_rec.destroy

    respond_to do |format|
      format.html { redirect_to(case_recs_url) }
      format.xml  { head :ok }
    end
  end
end