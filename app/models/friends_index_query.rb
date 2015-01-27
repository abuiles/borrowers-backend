class FriendsIndexQuery
  attr_reader :params, :scope

  def initialize(scope, params)
    @scope = scope
    @params = params
  end

  def self.find(scope, params)
    self.new(scope, params).find
  end

  def find
    result = scope

    if params[:sortBy]
      order_query = params[:sortBy].underscore

      if order_query == 'full_name'
        order_query = 'first_name'
      end

      if params[:sortAscending] == "true"
        order_query =  "#{order_query} ASC"
      else
        order_query =  "#{order_query} DESC"
      end

      result = result.order(order_query)
    end

    result
  end
end
