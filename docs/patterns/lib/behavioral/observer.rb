# Observable class
class WeatherStation
  attr_reader :temperature, :humidity, :pressure

  def initialize
    @observers = []
    @temperature = 0
    @humidity = 0
    @pressure = 0
  end

  def add_observer(observer)
    @observers << observer
  end

  def remove_observer(observer)
    @observers.delete(observer)
  end

  def update_weather(temperature, humidity, pressure)
    @temperature = temperature
    @humidity = humidity
    @pressure = pressure
    notify_observers
  end

  private

  def notify_observers
    @observers.each { |observer| observer.update(self) }
  end
end

# Observer interface
class WeatherObserver
  def update(weather_station)
    raise NotImplementedError, "Subclasses must implement the 'update' method"
  end
end

# Concrete observer
class DisplayScreen < WeatherObserver
  def update(weather_station)
    puts "Temperature: #{weather_station.temperature}"
    puts "Humidity: #{weather_station.humidity}"
    puts "Pressure: #{weather_station.pressure}"
  end
end

weather_station = WeatherStation.new

screen = DisplayScreen.new
weather_station.add_observer(screen)

weather_station.update_weather(25, 60, 1013)
