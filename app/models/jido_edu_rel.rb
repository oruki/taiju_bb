class JidoEduRel < ActiveRecord::Base
  validates_presence_of :boy
  validates_presence_of :edu_inst
  
  belongs_to :boy
  belongs_to :edu_inst
end