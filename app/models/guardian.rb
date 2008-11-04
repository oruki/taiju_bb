class Guardian < ActiveRecord::Base

#validation
validates_presence_of :name, :message => '名前を入力してください'
validates_presence_of :kana_name, :message => 'フリガナを入力してください'
validates_presence_of :birth_date, :message => '生年月日を入力してください'
validates_presence_of :sex, :message => '性別を入力してください'

    has_many :jido_guardian_rels
    has_many :boys,     :through => :jido_guardian_rels
    has_many :stay_out_recs
end