
## TODO: Implement CSV reading/writing

class ContactDatabase
  contacts = CSV.read('contacts.csv')
  #contacts = CSV.parse(File.read('contacts.csv'))
  #puts contacts[1]
end