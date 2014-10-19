class Api::V3::ArticlesController < Api::ArticlesController
  def index
    @articles = Article.all

    if params[:ids]
      @articles = @articles.where(id: params[:ids])
    end

    render json: @articles
  end
end
