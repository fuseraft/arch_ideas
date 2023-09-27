class Logger
  @@instance = nil

  def self.instance
    if @@instance.nil?
      @@instance = allocate
      @@instance.send(:initialize)
    end
    @@instance
  end

  private_class_method :new

  def initialize; end

  def log(message)
    puts message
  end
end

logger1 = Logger.instance
logger1.log("Logger 1 initialized.")

logger2 = Logger.instance
logger2.log("Logger 2 initialized.")

puts logger1 == logger2  # true
