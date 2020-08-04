class SearchsController < ApplicationController

	def search
		@search_word  = params[:search]
		@user_or_book = params[:model]
		@search_match = params[:match]
		if @user_or_book == "user_match"
			@users = User.search(@search_word, @user_or_book, @search_match)
		else
			@books = Book.search(@search_word, @user_or_book, @search_match)
		end
	end
end
