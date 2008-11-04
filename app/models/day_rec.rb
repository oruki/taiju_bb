#日本語
class DayRec < ActiveRecord::Base

validates_presence_of :hizuke,   :message => '←日付を入力してください'
validates_presence_of :tenki,    :message => '←天気を入力してください'
validates_presence_of :dekigoto, :message => '←出来事を入力してください'
validates_presence_of :staff_id, :message => '←ｽﾀｯﾌを入力してください'

  named_scope :selected_year,  lambda { |x| { :conditions => ["strftime('%Y',hizuke) = ?", x ] }}
  named_scope :selected_month, lambda { |x| { :conditions => ["strftime('%m',hizuke) = ?", x ] }}
  named_scope :selected_boys,  lambda { |x| { :conditions => ["boy_id IN (?)", x ] }}
end