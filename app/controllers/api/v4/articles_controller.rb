class Api::V4::ArticlesController < Api::ArticlesController
  def index
    @articles = Article.all

    if params[:ids]
      @articles = @articles.where(id: params[:ids])
    end

    if params[:friend_id]
      @articles  = @articles.where(friend_id: params[:friend_id])
    end

    render json: @articles
  end
end
