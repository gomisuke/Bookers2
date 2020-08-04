class Book < ApplicationRecord
	validates :title, presence: true
	validates :body, presence: true, length:{maximum:200}
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

	def favorited_by(user)
		favorites.where(user_id: user.id).exists?
	end

	def Book.search(search, user_or_book, search_match)
		if user_or_book == "book_match"
	      case search_match
	      when "perfect"
	        Book.where(['title LIKE ?', "#{search}"])
	      when "partial"
	        Book.where(['title LIKE ?', "%#{search}%"])
	      when "forward"
	        Book.where(['title LIKE ?', "#{search}%"])
	      when "back"
	        Book.where(['title LIKE ?', "%#{search}"])
	      end
	    else
	      Book.all
	    end
	end
end
