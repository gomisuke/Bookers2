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

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed, dependent: :destroy
  has_many :follower_user, through: :followed, source: :follower, dependent: :destroy

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefucture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefucture::Prefecture.find(name: prefecture_name).code
  end

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

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
