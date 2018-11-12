class CollectionsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @collections = Collection.all
  end

  def show
    @collection = Collection.find(params[:id])
    @books = @collection.books
  end
end
