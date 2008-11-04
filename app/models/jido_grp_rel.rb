class JidoGrpRel < ActiveRecord::Base
  validates_presence_of :boy
  validates_presence_of :group
  belongs_to :boy
  belongs_to :group
end