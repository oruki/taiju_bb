class Staff < ActiveRecord::Base

validates_presence_of :name, :message => '←名前が入力されていません'
validates_presence_of :kana_name, :message => '←フリガナが入力されていません'
validates_presence_of :birth_date, :message => '←生年月日が入力されていません'
validates_presence_of :sex, :message => '←性別が入力されていません'
validates_presence_of :user_id, :message => '←ﾕｰｻﾞｰIDを入力してください（管理者にお問合せ願います）'

  has_many :staff_recs
  has_many :group_recs
  has_many :stay_out_recs
  belongs_to :user
  has_many :shien_keikakus
  has_many :rels
  has_many :boys, :through => :rels
  has_many :shidou_recs
  has_many :school_recs
  has_many :attends
  has_many :med_recs

def uploaded_image=(image)
  if image.respond_to?(:content_type) and
    image.content_type.match(/^image\b/)

    self.imgf =
      File.extname(image.original_filename)[1..-1].downcase
    self.imgd = image.read
  end
end


end