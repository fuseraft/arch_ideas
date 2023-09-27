# Device interface
class Device
  def turn_on
    raise NotImplementedError, "Subclasses must implement the turn_on method"
  end

  def turn_off
    raise NotImplementedError, "Subclasses must implement the turn_off method"
  end
end

# Concrete Devices
class Phone < Device
  def turn_on
    puts "Turning on the phone..."
  end

  def turn_off
    puts "Turning off the phone..."
  end
end

class Laptop < Device
  def turn_on
    puts "Booting up the laptop..."
  end

  def turn_off
    puts "Shutting down the laptop..."
  end
end

# Factory interface
class DeviceFactory
  def create_device
    raise NotImplementedError, "Subclasses must implement the create_device method"
  end
end

# Concrete factories
class PhoneFactory < DeviceFactory
  def create_device
    Phone.new
  end
end

class LaptopFactory < DeviceFactory
  def create_device
    Laptop.new
  end
end

phone_factory = PhoneFactory.new
phone = phone_factory.create_device
phone.turn_on  # Turning on the phone...
phone.turn_off  # Turning off the phone...

laptop_factory = LaptopFactory.new
laptop = laptop_factory.create_device
laptop.turn_on  # Booting up the laptop...
laptop.turn_off  # Shutting down the laptop...
