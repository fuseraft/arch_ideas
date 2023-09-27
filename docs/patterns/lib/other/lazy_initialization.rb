class DatabaseConnection
  def initialize(database_url)
    @database_url = database_url
    @connection = nil
  end

  def connect
    @connection ||= establish_connection
  end

  private

  def establish_connection
    puts "Connecting to database at #{@database_url}"
    # Perform actual connection logic here
    # ...
    # Return connection object
    Object.new
  end
end

connection = DatabaseConnection.new("mongodb://foo:bar@foobar:27017/foobardb")
puts "First connection:"
connection.connect
puts "Second connection:"
connection.connect
