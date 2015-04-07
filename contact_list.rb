require_relative 'contact'
require_relative 'contact_database'

class ContactList

  def self.menu
    puts "Here is a list of available commands:
    new  - Create a new contact
    list - List all contacts
    show - Show a contact
    find - Find a contact"
  end
  
  def self.get_input
    gets.chomp
  end
    def self.input_for_id
    puts "what is the id number?"
    Contact.find(self.get_input.to_i)
  end

  def self.input_for_new_contact
    puts "what is the contact's name?"
    contact_name =  self.get_input
    puts "what is the contact's email?"
    contact_email = self.get_input
    Contact.create(contact_name, contact_email)
  end

  def self.menu_select (selection)
    
    case selection
    when 'new'
      ContactList.input_for_new_contact

    when 'list'
      Contact.all

    when 'show'

    when 'find'
      ContactList.input_for_id
    end
  end

end
ContactList.menu
ContactList.menu_select(ContactList.get_input)

#puts bob = Contact.create('Bob', 'bob@computer')


