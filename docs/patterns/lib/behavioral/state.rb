# Context class
class AlertSystem
  attr_accessor :state

  def initialize
    @state = NormalState.new(self)
  end

  def set_state(state)
    @state = state
  end

  def alert
    @state.alert
  end
end

# State interface
class AlertState
  def alert
    raise NotImplementedError, "Subclasses must implement the 'alert' method"
  end
end

# Concrete states
class NormalState < AlertState
  def initialize(alert_system)
    @alert_system = alert_system
  end

  def alert
    puts "Alert system is in normal state"
  end
end

class WarningState < AlertState
  def initialize(alert_system)
    @alert_system = alert_system
  end

  def alert
    puts "Alert system is in warning state"
    # Send a warning message to the operator
    # ...
  end
end

class EmergencyState < AlertState
  def initialize(alert_system)
    @alert_system = alert_system
  end

  def alert
    puts "Alert system is in emergency state"
    # Trigger an emergency response
    # ...
  end
end

alert_system = AlertSystem.new

alert_system.alert  # Output: "Alert system is in normal state"

alert_system.set_state(WarningState.new(alert_system))
alert_system.alert  # Output: "Alert system is in warning state"

alert_system.set_state(EmergencyState.new(alert_system))
alert_system.alert  # Output: "Alert system is in emergency state"
