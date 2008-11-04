class DaichosController < ApplicationController
# added 2008.06.10 added　日本語
before_filter :login_required


  # GET /daichos
  # GET /daichos.xml
#----------------------------------------------------------------------------------------------INDEX
  def index
    @daichos = Daicho.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @daichos }
    end
  end

  # GET /daichos/1
  # GET /daichos/1.xml
#----------------------------------------------------------------------------------------------SHOW
  def show
    @daicho = Daicho.find(params[:id])


    b01 = Daicho.find(:all).map{ |i| i.boy }           #boys in daichos
    b02 = current_user.staff.boys                      #boys cared by current_user
    b03 =  b02 & b01                                   #union of arrey b01 and b02
    @options_for_boy = b03.map{|k| [k.name, k.id] }    #used in selection dropdown
    
    #
    @guardians = @daicho.boy.guardians
    @guardian_ids = @guardians.map{|i| i.id}
    @guardians = Guardian.find(:all).select {|i| @guardian_ids.include?(i.id) } 

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @daicho }
    end
  end

  # GET /daichos/new
  # GET /daichos/new.xml
#----------------------------------------------------------------------------------------------NEW
  def new
    @daicho = Daicho.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @daicho }
    end
  end

  # GET /daichos/1/edit
  def edit
    @daicho = Daicho.find(params[:id])
  end

  # POST /daichos
  # POST /daichos.xml
#----------------------------------------------------------------------------------------------CREATE
  def create
    @daicho = Daicho.new(params[:daicho])

    respond_to do |format|
      if @daicho.save
        flash[:notice] = 'Daicho was successfully created.'
        format.html { redirect_to(@daicho) }
        format.xml  { render :xml => @daicho, :status => :created, :location => @daicho }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @daicho.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /daichos/1
  # PUT /daichos/1.xml
#----------------------------------------------------------------------------------------------UPDATE
  def update
    @daicho = Daicho.find(params[:id])

    respond_to do |format|
      if @daicho.update_attributes(params[:daicho])
        flash[:notice] = 'Daicho was successfully updated.'
        format.html { redirect_to(@daicho) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @daicho.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /daichos/1
  # DELETE /daichos/1.xml
#----------------------------------------------------------------------------------------------DESTROY
  def destroy
    @daicho = Daicho.find(params[:id])
    @daicho.destroy

    respond_to do |format|
      format.html { redirect_to(daichos_url) }
      format.xml  { head :ok }
    end
  end
end