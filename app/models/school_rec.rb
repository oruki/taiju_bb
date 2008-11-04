class SchoolRec < ActiveRecord::Base
  SCHOOL_STATUS = [
    ["欠席",    "absent"],
    ["遅刻",    "late"],
    ["早退",    "hayabiki"],
    ["休校",    "off"]
  ]
  belongs_to :boy
  belongs_to :staff
  
  
validates_presence_of :boy_id, :message => '←児童が入力されていません'
validates_presence_of :staff_id, :message => '←指導員が入力されていません'
validates_presence_of :date, :message => '←年月日が入力されていません'
validates_presence_of :status, :message => '←区分が入力されていません'


  named_scope :of_today, :conditions => ["date(date)  = ?", Date.today ] 
  
  named_scope :selected_year,  lambda { |x| { :conditions => ["strftime('%Y',date) = ?", x ] }}   #因数xに年号を入れる（ﾃｷｽﾄ）
  named_scope :selected_month, lambda { |x| { :conditions => ["strftime('%m',date) = ?", x ] }}   #因数xに月数を入れる（ﾃｷｽﾄ）
  named_scope :selected_boys,  lambda { |x| { :conditions => ["boy_id IN (?)", x ] }}             # x=@boyids  
   
end