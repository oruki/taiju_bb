class EduInst < ActiveRecord::Base
#validations
validates_presence_of :name, :message => '←名前を入力してください'
validates_presence_of :kana_name, :message => '←フリガナを入力してください'
validates_presence_of :cat, :message => '←診察区分を入力してください'
validates_presence_of :tel, :message => '←電話番号を入力してください'

    has_many :jido_edu_rels
    has_many :boys,     :through => :jido_edu_rels    
end
