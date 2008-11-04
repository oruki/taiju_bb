class Rel < ActiveRecord::Base
  validates_presence_of :boy
  validates_presence_of :staff
  belongs_to :boy
  belongs_to :staff
end