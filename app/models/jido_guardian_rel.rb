class JidoGuardianRel < ActiveRecord::Base
  validates_presence_of :boy
  validates_presence_of :guardian
  validates_presence_of :relation
  belongs_to :boy
  belongs_to :guardian
end 