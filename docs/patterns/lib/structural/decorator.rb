# Component interface
class Text
  def content
    raise NotImplementedError, "Subclasses must implement the content method"
  end
end

# Concrete component
class PlainText < Text
  def initialize(text)
    @text = text
  end

  def content
    @text
  end
end

# Decorator
class TextDecorator < Text
  def initialize(text)
    @text = text
  end

  def content
    @text.content
  end
end

# Concrete decorator
class BoldTextDecorator < TextDecorator
  def content
    "<b>#{super}</b>"
  end
end

plain_text = PlainText.new("This is plain text.")
puts plain_text.content  # This is plain text.

bold_text = BoldTextDecorator.new(plain_text)
puts bold_text.content  # <b>This is plain text.</b>
