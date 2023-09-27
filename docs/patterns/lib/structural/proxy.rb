# Subject interface
class Image
  def display
    raise NotImplementedError, "Subclasses must implement the 'display' method"
  end
end

# Real subject
class RealImage < Image
  def initialize(file_name)
    @file_name = file_name
    load_image_from_disk
  end

  def display
    puts "Displaying image '#{@file_name}'."
  end

  private

  def load_image_from_disk
    # Load the image from disk
    puts "Loading image '#{@file_name}' from disk."
  end
end

# Proxy
class ImageProxy < Image
  def initialize(file_name)
    @file_name = file_name
  end

  def display
    # Lazy load the real image when it is first displayed
    real_image.display
  end

  private

  def real_image
    @real_image ||= RealImage.new(@file_name)
  end
end

image1 = ImageProxy.new("image1.jpg")
image2 = ImageProxy.new("image2.jpg")

image1.display  # Loading image 'image1.jpg' from disk. 
                # Displaying image 'image1.jpg'.
image2.display  # Loading image 'image2.jpg' from disk. 
                # Displaying image 'image2.jpg'.
image1.display  # Displaying image 'image1.jpg'.
