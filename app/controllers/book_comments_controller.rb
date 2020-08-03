class BookCommentsController < ApplicationController
	before_action :correct_user, only: [:destroy]

	def create
		@book = Book.find(params[:book_id])
		@comment = BookComment.new(comment_params)
		@comment.user = current_user
		@comment.book = @book
		@comment.save
		redirect_back(fallback_location: root_path)
	end

	def destroy
		@comment = BookComment.find(params[:id])
		@comment.destroy
		redirect_back(fallback_location: root_path)
	end



	private

		def comment_params
			params.require(:book_comment).permit(:comment)
		end

		def correct_user
			@comment_user = BookComment.find(params[:id]).user
			if current_user.id != @comment_user.id
				redirect_back(fallback_location: root_path)
			end
		end

end
