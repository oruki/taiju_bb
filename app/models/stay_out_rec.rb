class StayOutRec < ActiveRecord::Base
  belongs_to :staff
  belongs_to :boy
  belongs_to :guardian
  
  validates_presence_of :boy, :staff, :guardian
   
  named_scope :selected_year,  lambda { |x| { :conditions => ["strftime('%Y',date) = ?", x ] }}   #&#22240;&#25968;x&#12395;&#24180;&#21495;&#12434;&#20837;&#12428;&#12427;&#65288;&#65411;&#65399;&#65405;&#65412;&#65289;
  named_scope :selected_month, lambda { |x| { :conditions => ["strftime('%m',date) = ?", x ] }}   #&#22240;&#25968;x&#12395;&#26376;&#25968;&#12434;&#20837;&#12428;&#12427;&#65288;&#65411;&#65399;&#65405;&#65412;&#65289;
  named_scope :selected_boys,  lambda { |x| { :conditions => ["boy_id IN (?)", x ] }}             # x=@boyids  
    
end
 