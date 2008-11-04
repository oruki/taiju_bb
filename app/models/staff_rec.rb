class StaffRec < ActiveRecord::Base  
  validates_presence_of :attend_id
  belongs_to :attend
  belongs_to :staff
end