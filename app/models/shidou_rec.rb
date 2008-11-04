class ShidouRec < ActiveRecord::Base
  belongs_to :boy
  belongs_to :staff

  validates_presence_of :date, :boy_id, :staff_id, :cat, :desc

#--------------------------------------------------------------------------------NamedScope
#  expr [NOT] IN ( value-list ) ﾃﾞｰﾀ抽出
# 
   named_scope :of_today,       :conditions => ["date(date)  = ?", Date.today ] 
   named_scope :of_attend_date, lambda { |x| { :conditions => ["date(date) = ?", x ] }}      #日付ﾌｨｰﾙﾄﾞがxであるようなﾚｺｰﾄﾞを抽出
   
   named_scope :selected_year,  lambda { |x| { :conditions => ["strftime('%Y',date) = ?", x ] }}   
   named_scope :selected_month, lambda { |x| { :conditions => ["strftime('%m',date) = ?", x ] }}   
   named_scope :selected_boys,  lambda { |x| { :conditions => ["boy_id IN (?)", x ] }}             # x=@boyids　boy_idに該当するﾃﾞｰﾀ抽出   
end