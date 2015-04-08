class PhoneNumber
  attr_accessor :type, :digits

  def initialize(type, digits)
    @type = type
    @digits = digits
  end

  def to_s
    "#{@type}: #{@digits}"
  end

end