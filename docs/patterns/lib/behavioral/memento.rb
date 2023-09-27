# Originator class
class Editor
  attr_accessor :content

  def create_state
    EditorState.new(@content)
  end

  def restore_state(state)
    @content = state.content
  end
end

# Memento class
class EditorState
  attr_reader :content

  def initialize(content)
    @content = content
  end
end

# Caretaker class
class History
  def initialize
    @states = []
  end

  def push_state(state)
    @states << state
  end

  def pop_state
    @states.pop
  end
end

editor = Editor.new
history = History.new

editor.content = "This is the first version."
history.push_state(editor.create_state)

editor.content = "This is the second version."
history.push_state(editor.create_state)

editor.content = "This is the third version."
history.push_state(editor.create_state)

editor.restore_state(history.pop_state)
puts editor.content  # "This is the third version."

editor.restore_state(history.pop_state)
puts editor.content  # "This is the second version."

editor.restore_state(history.pop_state)
puts editor.content  # "This is the first version."
