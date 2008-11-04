class ShienKeikaku < ActiveRecord::Base
  validates_presence_of :date, :boy, :staff

  belongs_to :boy
  belongs_to :staff
  has_many   :tanki_shien_keikakus

#-------------------------------------------------------NamedScope
# 抽出する
#  named_scope :selected_year,  lambda { |x| { :conditions => ["strftime('%Y',date) = ?", x ] }}   
#  named_scope :selected_month, lambda { |x| { :conditions => ["strftime('%m',date) = ?", x ] }}   
#  named_scope :selected_boys,  lambda { |x| { :conditions => ["boy_id IN (?)", x ] }}    

   named_scope :cat_01, :conditions => {:cat => 'cat-01'}
   named_scope :cat_02, :conditions => {:cat => 'cat-02'}
   named_scope :cat_03, :conditions => {:cat => 'cat-03'}
   named_scope :cat_04, :conditions => {:cat => 'cat-04'}
end