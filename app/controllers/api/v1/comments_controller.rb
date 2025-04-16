class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create 
    @startup = Startup.find(params[:startup_id])
    @comment = @startup.comments.build(user: current_user, context: params[:context])

    if @comment.save
      render json: { message: "Comment created successfully" }, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy
    render json: { message: "Comment deleted" }, status: :ok
  end

end
