class Api::V1::UpvotesController < ApplicationController
  def create
    user_id = params[:user_id].to_i
    startup_id = params[:startup_id].to_i

    upvote = Upvote.find_by(user_id: user_id, startup_id: startup_id)

    if upvote
      upvote.destroy
      render json: { message: "Upvote removed successfully" }, status: :ok
    else
      upvote = Upvote.new(user_id: user_id, startup_id: startup_id)
      if upvote.save
        render json: { message: "Upvoted successfully", upvote: upvote }, status: :created
      else
        render json: { error: upvote.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def destroy
    user_id = params[:user_id].to_i
    startup_id = params[:startup_id].to_i

    upvote = Upvote.find_by(user_id: user_id, startup_id: startup_id)

    if upvote
      upvote.destroy
      render json: { message: "Upvote removed successfully" }, status: :ok
    else
      render json: { error: "Upvote not found" }, status: :not_found
    end
  end
end
