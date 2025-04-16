class Api::V1::StartupsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  def index
    @startups = Startup.includes(:upvotes).all
    render json: @startups.map { |startup| 
      startup.as_json.merge(upvotes_count: startup.upvotes.count) 
    }
  end

 
  def show
    @startup = Startup.includes(:upvotes).find_by(id: params[:id])
    if @startup
      render json: { 
        msg: "Startup detail fetched successfully", 
        data: @startup.as_json.merge(upvotes_count: @startup.upvotes.count)
      }
    else
      render json: { msg: "Failed to fetch Startup detail" }, status: :not_found
    end
  end

  def create
    @startup = current_user.startups.new(startups_params)
    if(@startup.save)
      render json:{msg:"Startup created Sucessfully", data:@startup}
    else
      render json:{ errors: startup.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @startup= current_user.startups.find(params[:id])
    if(@startup.update(startups_params))
      render json: @startup
    else
      render json: { errors: startup.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def trendingStartups
    @startups = Startup.left_joins(:upvotes).group("startups.id").select("startups.*, count(upvotes.id) as upvotes_count").order("upvotes_count desc").limit(5) 
    render json: @startups
  end

  def myStartupsInformation
    @startups = Startup.where(user_id:params[:user_id])
    if(@startups)
      render json: @startups, status: :ok
    else
      render json: { msg: "Failed to fetch Startup detail" }, status: :not_found
    end
  end
  def destroy
    @startup = current_user.startups.find(params[:id])
    @startup.destroy
    render json: { msg: "Startup deleted successfully" }
  end

  private

   def startups_params
    params.require(:startup).permit(:name,:description,:tagline,:category,:logo,:websitelink,:xlink,:linkedin,:launchtype)
   end
 
end
