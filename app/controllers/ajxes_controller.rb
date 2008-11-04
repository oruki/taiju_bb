class AjxesController < ApplicationController


# added 2008.07.13 &#36861;&#21152;
before_filter :login_required

  #------------------------------------------------------------------------------shidou_recs
  # GET /shidou_recs
  # GET /shidou_recs.xml

  def shidou_recs_ajx
    @shidou_recs = ShidouRec.find(:all, :order => "date DESC")

boy=params[:boy]
if (boy)
    @shidou_recs = ShidouRec.find(:all,:conditions=>['boy_id=?',boy], :order => "date DESC")
end

staff=params[:staff]
if (staff)
    @shidou_recs = ShidouRec.find(:all,:conditions=>['staff_id=?',staff], :order => "date DESC")
end
    respond_to do |format|
      format.html {}# index.html.erb
      format.xml  { render :xml => @shidou_recs }
      format.js
    end
  end
end

  #------------------------------------------------------------------------------school_recs extract_school_recs
  # GET /shidou_recs
  # GET /shidou_recs.xml

  def extract_school_recs
    @school_recs = SchoolRec.find(:all, :order => "date DESC")

boy=params[:boy]
if (boy)
    @school_recs = SchoolRec.find(:all,:conditions=>['boy_id=?',boy], :order => "date DESC")
end

staff=params[:staff]
if (staff)
    @school_recs = SchoolRec.find(:all,:conditions=>['staff_id=?',staff], :order => "date DESC")
end
    respond_to do |format|
      format.html {}# index.html.erb
      format.xml  { render :xml => @shidou_recs }

    end
  end
end