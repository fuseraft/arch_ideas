class QueryBuilder
  def initialize
    @query = {}
  end

  def where(column, value)
    @query["predicates"] = { column => value }
    self
  end

  def order_by(column, direction)
    @query["sort"] = { column => direction }
    self
  end

  def limit(count)
    @query["limit"] = count
    self
  end

  def to_sql
    # Convert query to SQL format
    sql = "SELECT * FROM table"
    sql += " WHERE #{format_query(@query)}" if @query.any?
    sql += " ORDER BY #{format_sort(@query["sort"])}" if @query["sort"]
    sql += " LIMIT #{@query["limit"]}" if @query["limit"]
    sql
  end

  private

  def format_query(query)
    query["predicates"].map { |column, value| "#{column} = '#{value}'" }.join(" AND ")
  end

  def format_sort(sort)
    sort.map { |column, direction| "#{column} #{direction}" }.join(", ")
  end
end

query = QueryBuilder.new.where("name", "Scott").order_by("age", "desc").limit(10).to_sql
puts query  # Output: SELECT * FROM table WHERE name = 'Scott' ORDER BY age desc LIMIT 10
