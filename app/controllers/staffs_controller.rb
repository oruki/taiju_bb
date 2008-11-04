class StaffsController < ApplicationController
# added 2008.06.10 added
before_filter :login_required




# p416 orange-book
def image
  staff = Staff.find(params[:id])
  case staff.imgf
  when 'gif'
    content_type = 'image/gif'
  when 'png'
    content_type = 'image/png'
  else
    content_type = 'image/jpeg'
  end

  send_data staff.imgd,
    :type => content_type, :disposition => "inline"

end

  # GET /staffs
  # GET /staffs.xml
  def index
    @staffs = Staff.find(:all)
    @rec_count = @staffs.size
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @staffs }
    end
  end


  # GET /staffs/1
  # GET /staffs/1.xml
  def show
    @staff = Staff.find(params[:id])
    @time = Time.now

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @staff }
    end
  end


  # GET /staffs/new
  # GET /staffs/new.xml
  def new
    @staff = Staff.new
    @list= %w{院長 副院長 書記 指導員 家庭支援専門相談員 保育士 指導員 栄養士 調理師 嘱託医 セラピスト}
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @staff }
    end
  end


  # GET /staffs/1/edit
  def edit
    @staff = Staff.find(params[:id])
    @list= %w{院長 副院長 書記 指導員 家庭支援専門相談員 保育士 指導員 栄養士 調理師 嘱託医 セラピスト}
    #このスタッフの担当する子供たち
    @population = 127767944
    @num_boys = @staff.boys.size
    @c = "SimpleStrings"
    @time = Time.now
 
  end

  # POST /staffs
  # POST /staffs.xml
  def create
    @staff = Staff.new(params[:staff])

    respond_to do |format|
      if @staff.save
        flash[:notice] = 'Staff was successfully created.'
        format.html { redirect_to(@staff) }
        format.xml  { render :xml => @staff, :status => :created, :location => @staff }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @staff.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /staffs/1
  # PUT /staffs/1.xml
  def update
    @staff = Staff.find(params[:id])

    respond_to do |format|
      if @staff.update_attributes(params[:staff])
        flash[:notice] = '更新しました（指導員）'
        format.html { redirect_to(@staff) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @staff.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /staffs/1
  # DELETE /staffs/1.xml
  def destroy
    @staff = Staff.find(params[:id])
    @staff.destroy

    respond_to do |format|
      format.html { redirect_to(staffs_url) }
      format.xml  { head :ok }
    end
  end
end