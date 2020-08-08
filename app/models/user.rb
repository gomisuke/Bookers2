class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length:{ in: 2..20 }
  validates :introduction, length:{maximum:50}

  attachment :profile_image
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_commentd, dependent: :destroy
  
  #フォロー機能関連
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed, dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower, dependent: :destroy

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end


  #マップ関連
  include JpPrefecture
  jp_prefecture :prefecture_code

  geocoded_by :address_city
  after_validation :geocode

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  #検索機能
  def User.search(search, user_or_book, search_match)
    if user_or_book == "user_match"
      case search_match
      when "perfect"
        User.where(['name LIKE ?', "#{search}"])
      when "partial"
        User.where(['name LIKE ?', "%#{search}%"])
      when "forward"
        User.where(['name LIKE ?', "#{search}%"])
      when "back"
        User.where(['name LIKE ?', "%#{search}"])
      end
    else
      User.all
    end
  end

end
