class HomeController < ApplicationController
  def index
    @q = Album.ransack(params[:q])
    @albums = Album.where(published:true)
    @albums = @q.result.includes(:tags, :taggings)
  end
end
