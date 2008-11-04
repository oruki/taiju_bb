class Boy < ActiveRecord::Base
validates_presence_of :name,      :message => '←児童の名前が入力されていません'
validates_presence_of :kana_name, :message => '←児童のフリガナが入力されていません'
validates_presence_of :birthdate, :message => '←児童の生年月日が入力されていません'
validates_presence_of :sex,       :message => '←児童の性別が入力されていません'
  has_many :shien_keikakus
  
  has_many :accounts

  has_many :rels
  has_many :staffs,    :through => :rels

  has_many :shidou_recs
  has_many :school_recs

  has_many :jido_grp_rels
  has_many :groups,   :through => :jido_grp_rels

  has_many :jido_guardian_rels
  has_many :guardians,  :through => :jido_guardian_rels

  has_many :med_recs

  has_many :jido_edu_rels
  has_many :edu_insts,  :through => :jido_edu_rels
  
  has_many :stay_out_recs

  has_many :daichos
  has_many :shien_keikakus

  has_many :case_recs
#--------------------------------------------------------------------------------NamedScope

  named_scope :selected_boys,  lambda { |x| { :conditions => ["id IN (?)", "#{x.boys.map{|i| [i.id]} }"  ] }}             # x=@staff

  
end