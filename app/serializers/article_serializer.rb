class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :description, :state, :notes

  embed :ids

  has_one :friend
end
