class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :description, :state
end
