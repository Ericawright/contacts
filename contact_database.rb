
## TODO: Implement CSV reading/writing
require 'csv'

class ContactDatabase
  contacts = CSV.read('contacts.csv')
  #contacts = CSV.parse(File.read('contacts.csv'))
  #puts contacts[1]
end