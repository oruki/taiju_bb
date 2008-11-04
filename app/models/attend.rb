class Attend < ActiveRecord::Base
  validates_presence_of :staff_id, :message => '←指導員が入力されていません'
  validates_presence_of :time_start, :message => '←開始時が入力されていません'
  validates_presence_of :time_end, :message => '←終了時が入力されていません'
  validates_presence_of :misc, :message => '←備考が入力されていません'  
  validate :validates_work_hour
  
  belongs_to :staff
  has_many :staff_recs
#-------------------------------------------------------NamedScope
#今日の日付を持つﾃﾞｰﾀを抽出する
named_scope :of_today, :conditions => ["date(time_start)  = ?", Date.today ] 

#-------------------------------------------------------work_hour
  def work_hour
   if Attend.time_end
     Attend.time_end - Attend.time_start
   else
     "not calcu"
   end
  end
#-------------------------------------------------------
  def validates_work_hour
  unless work_hour = 1*60*60..24*60*60
    errors.add_to_base(" no good ")
  end
  end 
    
end