class GuardiansController < ApplicationController
  # authentification 2008.06.10

  before_filter :login_required

#------------------------------------------------------------------INDEX
  # GET /guardians
  # GET /guardians.xml
  def index
    @guardians = Guardian.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @guardians }
    end
  end

#------------------------------------------------------------------SHOW
  # GET /guardians/1
  # GET /guardians/1.xml
  def show
    @guardian = Guardian.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @guardian }
    end
  end

#------------------------------------------------------------------NEW
  # GET /guardians/new
  # GET /guardians/new.xml
  def new
    @guardian = Guardian.new
    @zokugaras = %w{父 母 祖母 祖父 おじ おば 兄 姉 弟 妹 いとこ その他}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @guardian }
    end
  end

#------------------------------------------------------------------EDIT
  # GET /guardians/1/edit
  def edit
    @guardian = Guardian.find(params[:id])
    @zokugaras = %w{父 母 祖母 祖父 おじ おば 兄 姉 弟 妹 いとこ その他}
  end

#------------------------------------------------------------------CREATE
  # POST /guardians
  # POST /guardians.xml
  def create
    @guardian = Guardian.new(params[:guardian])

    respond_to do |format|
      if @guardian.save
        flash[:notice] = 'Guardian was successfully created.'
        format.html { redirect_to(@guardian) }
        format.xml  { render :xml => @guardian, :status => :created, :location => @guardian }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @guardian.errors, :status => :unprocessable_entity }
      end
    end
  end
#------------------------------------------------------------------UPDATE
  # PUT /guardians/1
  # PUT /guardians/1.xml
  def update
    @guardian = Guardian.find(params[:id])

    respond_to do |format|
      if @guardian.update_attributes(params[:guardian])
        flash[:notice] = 'Guardian was successfully updated.'
        format.html { redirect_to(@guardian) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @guardian.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /guardians/1
  # DELETE /guardians/1.xml
  def destroy
    @guardian = Guardian.find(params[:id])
    @guardian.destroy

    respond_to do |format|
      format.html { redirect_to(guardians_url) }
      format.xml  { head :ok }
    end
  end
end