class CaseRec < ActiveRecord::Base
  belongs_to :boy
  validates_presence_of :boy
end  