class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :description, :state, :notes
end
