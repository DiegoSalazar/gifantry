class TagsController < ApplicationController
  def index
    render json: ActsAsTaggableOn::Tag.where("name LIKE ?", "%#{params[:q]}%")
  end
end
