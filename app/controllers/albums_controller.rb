class AlbumsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @q = Album.ransack(params[:q])
    
    @albums = current_user.albums
    @albums = @q.result.includes(:tags, :taggings)
  end

  def show

    @album = Album.find(params[:id])

  end

  def new
    
    @album = current_user.albums.build

  end

  def create
    
    @album = current_user.albums.build(album_params)

    if @album.save

      redirect_to root_path

    else
      render :new
    end
    
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    redirect_to albums_path
  end


  def edit
    @album = Album.find(params[:id])
  end


  def update
    @album = Album.find_by(id: params[:id])
    
    if @album.update(album_params)
      redirect_to albums_path
    else
      render :edit
    end
  end

  def correct_user
    @album = current_user.albums.find_by(id: params[:id])
    redirect_to root_path, notice: "Not Allowed To Use This Record" if @album.nil? 
  end

  private

  def album_params
    params.require(:album).permit(:title, :body, :user_id, :published, :all_tags, images: [])
  end
end