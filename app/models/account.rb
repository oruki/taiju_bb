# Model for manage accounting deposit or money of boys
class Account < ActiveRecord::Base
    validates_presence_of :boy_id
    validates_presence_of :amount 
    belongs_to :boy
    belongs_to :guardian
end