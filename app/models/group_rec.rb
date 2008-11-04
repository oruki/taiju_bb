class GroupRec < ActiveRecord::Base
#日本語
  validates_presence_of :hizuke
  belongs_to :group
  belongs_to :staff

  named_scope :selected_year,  lambda { |x| { :conditions => ["strftime('%Y',hizuke) = ?", x ] }}
  named_scope :selected_month, lambda { |x| { :conditions => ["strftime('%m',hizuke) = ?", x ] }}
  named_scope :selected_boys,  lambda { |x| { :conditions => ["boy_id IN (?)", x ] }}
end