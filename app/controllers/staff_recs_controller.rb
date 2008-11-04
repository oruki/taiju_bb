class StaffRecsController < ApplicationController
#----------------------------------------------------------------------------------------------------------------NEW_STAFF
  def new_staff_rec
    @staff_rec = StaffRec.new(params[:staff_rec])
    @staff_rec.naiyo = "&#20869;&#23481;&#12384;"
    @staff_rec.save
  end
  def new_staff_rec2
    @staff_rec = StaffRec.new
    #set attend_id to current attend id
    @staff_rec.attend_id = params[:attnd].id
    #@staff_rec.date      = "#{params[:attnd].to_date.to_s} #{params[:hour]}:#{params[:min]}:00".to_time
    #@staff_rec.in_out    = params[:in_out]
    #@staff_rec.yoken     = params[:yoken]
    @staff_rec.naiyo     = params[:naiyo]
    if @staff_rec.save
      flash[:notice] = 'StaffRec was successfully created.'
    else
      format.html { render :action => "new" }
    end
  end
#----------------------------------------------------------------------------------------------------------------INDEX
  # GET /staff_recs
  # GET /staff_recs.xml
  def index
    @staff_recs = StaffRec.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staff_recs }
    end
  end
#----------------------------------------------------------------------------------------------------------------SHOW
  # GET /staff_recs/1
  # GET /staff_recs/1.xml
  def show
    @staff_rec = StaffRec.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staff_rec }
    end
  end
#----------------------------------------------------------------------------------------------------------------NEW
  # GET /staff_recs/new
  # GET /staff_recs/new.xml
  def new
    @staff_rec = StaffRec.new


    @options_for_attend = Attend.find(:all).map{|i| [i.staff.name, i.id]}    
    @options_for_attend .insert 0,["&#8230;&#25351;&#23566;&#21729;&#12434;&#36984;&#25246;&#8230;" , '']


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staff_rec }
    end
  end
#----------------------------------------------------------------------------------------------------------------EDIT
  # GET /staff_recs/1/edit
  def edit
    @staff_rec = StaffRec.find(params[:id])
  end
#----------------------------------------------------------------------------------------------------------------CREATE
  # POST /staff_recs
  # POST /staff_recs.xml
  def create
    @staff_rec = StaffRec.new(params[:staff_rec])

    respond_to do |format|
      if @staff_rec.save
        flash[:notice] = 'StaffRec was successfully created.'
        format.html { redirect_to(@staff_rec) }
        format.xml  { render :xml => @staff_rec, :status => :created, :location => @staff_rec }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staff_rec.errors, :status => :unprocessable_entity }
      end
    end
  end
#----------------------------------------------------------------------------------------------------------------UPDATE
  # PUT /staff_recs/1
  # PUT /staff_recs/1.xml
  def update
    @staff_rec = StaffRec.find(params[:id])

    respond_to do |format|
      if @staff_rec.update_attributes(params[:staff_rec])
        flash[:notice] = 'StaffRec was successfully updated.'
        format.html { redirect_to(@staff_rec) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @staff_rec.errors, :status => :unprocessable_entity }
      end
    end
  end
#----------------------------------------------------------------------------------------------------------------DESTROY
  # DELETE /staff_recs/1
  # DELETE /staff_recs/1.xml
  def destroy
    @staff_rec = StaffRec.find(params[:id])
    @staff_rec.destroy

    respond_to do |format|
      format.html { redirect_to(staff_recs_url) }
      format.xml  { head :ok }
    end
  end
end