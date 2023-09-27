# Prototype interface
class Prototype
  def clone
    raise NotImplementedError, "Subclasses must implement the clone method"
  end
end

# Concrete Prototypes
class Document < Prototype
  attr_accessor :title, :content

  def clone
    Document.new(title, content)
  end

  def initialize(title, content)
    @title = title
    @content = content
  end
end

class Image < Prototype
  attr_accessor :file_name, :file_size, :format

  def clone
    Image.new(file_name, file_size, format)
  end

  def initialize(file_name, file_size, format)
    @file_name = file_name
    @file_size = file_size
    @format = format
  end
end

document = Document.new("Prototype Pattern", "This is an example of the Prototype Pattern in Ruby.")
document_clone = document.clone

puts document.title  # Prototype Pattern
puts document_clone.title  # Prototype Pattern

image = Image.new("image.jpg", "1024", "jpg")
image_clone = image.clone

puts image.file_name  # image.jpg
puts image_clone.file_name  # image.jpg
