class Button
  def click(text_box)
    text_box.update(self)
  end
end

class TextBox
  def update(button)
    self.text = case button
      when OkButton
        "Ok button was clicked"
      when CancelButton
        "Cancel button was clicked"
      end
  end

  attr_accessor :text
end

class OkButton < Button
end

class CancelButton < Button
end

button = OkButton.new
text_box = TextBox.new
button.click(text_box)
puts text_box.text  # "Ok button was clicked"
