# Flyweight factory
class FontFactory
  def initialize
    @fonts = {}
  end

  def get_font(name, size)
    if @fonts[name]
      # Return an existing font if we've already created one with the same name
      @fonts[name]
    else
      # Otherwise, create a new font and store it in the hash
      font = Font.new(name, size)
      @fonts[name] = font
      font
    end
  end
end

# Flyweight
class Font
  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size
  end

  def render(text)
    # Render the text using this font
    puts "Rendering '#{text}' using #{@name} font in size #{@size}."
  end
end

factory = FontFactory.new

font1 = factory.get_font("Arial", 12)
font2 = factory.get_font("Times New Roman", 16)
font3 = factory.get_font("Arial", 12)

puts font1.object_id  # 60
puts font2.object_id  # 80
puts font3.object_id  # 60

font1.render("Hello, world!")
font2.render("This is a test.")
font3.render("Flyweight pattern example in Ruby.")
