# Define the filters
class LowercaseFilter
  def process(text)
    text.downcase
  end
end

class RemovePunctuationFilter
  def process(text)
    text.gsub(/[^\w\s]/, "")
  end
end

class StopWordsFilter
  def initialize(stop_words)
    @stop_words = stop_words
  end

  def process(text)
    words = text.split
    filtered_words = words.reject { |word| @stop_words.include?(word.downcase) }
    filtered_words.join(" ")
  end
end

class StemmingFilter
  def process(text)
    # Perform stemming algorithm on text
    # ...
    text
  end
end

# Define the pipeline
class TextProcessor
  def initialize
    @filters = []
  end

  def add_filter(filter)
    @filters << filter
  end

  def process(text)
    @filters.inject(text) do |result, filter|
      filter.process(result)
    end
  end
end

stop_words = %w[the and a of]
text = "The quick brown fox jumps over the lazy dog."

processor = TextProcessor.new
processor.add_filter(LowercaseFilter.new)
processor.add_filter(RemovePunctuationFilter.new)
processor.add_filter(StopWordsFilter.new(stop_words))
processor.add_filter(StemmingFilter.new)

processed_text = processor.process(text)
puts processed_text  # Output: "quick brown fox jumps over lazy dog"
