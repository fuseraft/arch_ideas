# Implementor interface
class Formatter
  def format(text)
    raise NotImplementedError, "Subclasses must implement the format method"
  end
end

# Concrete Implementors
class HtmlFormatter < Formatter
  def format(text)
    "<html><body>#{text}</body></html>"
  end
end

class PlainTextFormatter < Formatter
  def format(text)
    text
  end
end

# Abstraction
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(title, text, formatter)
    @title = title
    @text = text
    @formatter = formatter
  end

  def generate_report
    formatted_text = @formatter.format(@text)
    puts "#{@title}\n#{formatted_text}"
  end
end

html_formatter = HtmlFormatter.new
plain_text_formatter = PlainTextFormatter.new

report1 = Report.new("Sales Report", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", html_formatter)
report1.generate_report

report2 = Report.new("Expense Report", "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", plain_text_formatter)
report2.generate_report
