# Abstract Factory
class DatabaseFactory
  def create_reader
    raise NotImplementedError, "Subclasses must implement the create_reader method"
  end

  def create_writer
    raise NotImplementedError, "Subclasses must implement the create_writer method"
  end
end

# Concrete Factories
class MySqlDatabaseFactory < DatabaseFactory
  def create_reader
    MySqlReader.new
  end

  def create_writer
    MySqlWriter.new
  end
end

class OracleDatabaseFactory < DatabaseFactory
  def create_reader
    OracleReader.new
  end

  def create_writer
    OracleWriter.new
  end
end

# Abstract Products
class Reader
  def read
    raise NotImplementedError, "Subclasses must implement the read method"
  end
end

class Writer
  def write(data)
    raise NotImplementedError, "Subclasses must implement the write method"
  end
end

# Concrete Products
class MySqlReader < Reader
  def read
    puts "Reading data from MySql database"
  end
end

class MySqlWriter < Writer
  def write(data)
    puts "Writing data to MySql database"
  end
end

class OracleReader < Reader
  def read
    puts "Reading data from Oracle database"
  end
end

class OracleWriter < Writer
  def write(data)
    puts "Writing data to Oracle database"
  end
end

my_sql_factory = MySqlDatabaseFactory.new
oracle_factory = OracleDatabaseFactory.new

my_sql_reader = my_sql_factory.create_reader
my_sql_writer = my_sql_factory.create_writer
my_sql_reader.read
my_sql_writer.write("Data to be written")

oracle_reader = oracle_factory.create_reader
oracle_writer = oracle_factory.create_writer
oracle_reader.read
oracle_writer.write("Data to be written")
