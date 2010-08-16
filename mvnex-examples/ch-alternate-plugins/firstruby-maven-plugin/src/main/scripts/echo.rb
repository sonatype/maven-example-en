# Prints a Message
# @goal echo
# @phase validate
class Echo < Mojo

  # @parameter type="java.lang.String" default-value="Hello Maven World" expression="${message}"
  # @required true
  # @readonly false
  # @deprecated false
  def message
  end

  def execute
    info $message
  end

end

run_mojo Echo
