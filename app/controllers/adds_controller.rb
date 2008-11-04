class AddsController < ApplicationController
  # GET /adds
  # GET /adds.xml
  def index
    @adds = Add.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @adds }
    end
  end

  # GET /adds/1
  # GET /adds/1.xml
  def show
    @add = Add.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @add }
    end
  end

  # GET /adds/new
  # GET /adds/new.xml
  def new
    @add = Add.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @add }
    end
  end

  # GET /adds/1/edit
  def edit
    @add = Add.find(params[:id])
  end

  # POST /adds
  # POST /adds.xml
  def create
    @add = Add.new(params[:add])

    respond_to do |format|
      if @add.save
        flash[:notice] = 'Add was successfully created.'
        format.html { redirect_to(@add) }
        format.xml  { render :xml => @add, :status => :created, :location => @add }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @add.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /adds/1
  # PUT /adds/1.xml
  def update
    @add = Add.find(params[:id])

    respond_to do |format|
      if @add.update_attributes(params[:add])
        flash[:notice] = 'Add was successfully updated.'
        format.html { redirect_to(@add) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @add.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /adds/1
  # DELETE /adds/1.xml
  def destroy
    @add = Add.find(params[:id])
    @add.destroy

    respond_to do |format|
      format.html { redirect_to(adds_url) }
      format.xml  { head :ok }
    end
  end
end
