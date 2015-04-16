class PhoneNumber < ActiveRecord::Base
  belongs_to :contact, dependent: :destroy
end
  # attr_accessor :type, :digits

  # def initialize(type, digits)
  #   @type = type
  #   @digits = digits
  # end

  # def to_s
  #   " #{@type}: #{@digits}"
  # end

