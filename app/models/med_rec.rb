class MedRec < ActiveRecord::Base
  validates_presence_of :date
  validates_presence_of :boy
  validates_presence_of :staff  
  validates_presence_of :med_inst 
  belongs_to :boy
  belongs_to :med_inst
  belongs_to :staff
    
  named_scope :selected_year,  lambda { |x| { :conditions => ["strftime('%Y',date) = ?", x ] }}
  named_scope :selected_month, lambda { |x| { :conditions => ["strftime('%m',date) = ?", x ] }}
  named_scope :selected_boys,  lambda { |x| { :conditions => ["boy_id IN (?)", x ] }}             # x=@boyids  
  
end