class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :description, :state, :notes
end
