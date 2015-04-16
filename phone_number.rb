class PhoneNumber < ActiveRecord::Base
  belongs_to :contact, dependent: :destroy
end


