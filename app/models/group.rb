class Group < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :cat
  validates_presence_of :misc
    
  has_many :group_recs
  has_many :jido_grp_rels
  has_many :boys, :through => :jido_grp_rels
end