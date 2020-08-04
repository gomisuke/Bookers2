class RelationshipsController < ApplicationController

	def create
		current_user.follow(params[:id])
		redirect_back(fallback_location: root_path)
	end

	def destory
		current_user.unfollow(params[:id])
		redirect_back(fallback_location: root_path)
	end

	def following_index
		@user = User.find(params[:id])
	end

	def follower_index
		@user = User.find(params[:id])
	end
end
