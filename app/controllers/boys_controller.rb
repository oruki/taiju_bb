class BoysController < ApplicationController
# added 2008.06.10 added　UTF設定追加
before_filter :login_required

def caluculate
  @boys = Boy.find(:all)
end


#----------------------------------------------------------------------------------------------------INDEX
  # GET /boys
  # GET /boys.xml
  def index
 #   @boys = Boy.find(:all)

#2008-08-08 性別により抽出するラジオボタンを追加
case params[:abc]
when "1" #boys
    @boys = Boy.find(:all, :conditions => ['sex=?', 1] )
when "2" #girls
    @boys = Boy.find(:all, :conditions => ['sex=?', 2] )
else
    @boys = Boy.find(:all)
end
    @n = @boys.size
#

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @boys }
    end
  end

#----------------------------------------------------------------------------------------------------SHOW
  # GET /boys/1
  # GET /boys/1.xml
  def show
    @boy = Boy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @boy }
    end
  end

#----------------------------------------------------------------------------------------------------NEW
  # GET /boys/new
  # GET /boys/new.xml
  def new
    @boy = Boy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @boy }
    end
  end

#----------------------------------------------------------------------------------------------------EDIT
  # GET /boys/1/edit
  def edit
    @boy = Boy.find(params[:id])
  end

#----------------------------------------------------------------------------------------------------CREATE
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

#----------------------------------------------------------------------------------------------------UPDATE
  # PUT /boys/1
  # PUT /boys/1.xml
  def update
    @boy = Boy.find(params[:id])

    respond_to do |format|
      if @boy.update_attributes(params[:boy])
        flash[:notice] = '正常に更新されました（児童）'
        format.html { redirect_to(@boy) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @boy.errors, :status => :unprocessable_entity }
      end
    end
  end

#----------------------------------------------------------------------------------------------------DELETE
  # DELETE /boys/1
  # DELETE /boys/1.xml
  def destroy
    @boy = Boy.find(params[:id])
    @boy.destroy
        flash[:notice] = 'Boy was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to(boys_url) }
      format.xml  { head :ok }
    end
  end
end