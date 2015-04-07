require_relative 'contact'
require_relative 'contact_database'

class ContactList

  @command = ARGV[0]
  @second_command = ARGV[1]

  def self.menu
    puts "Here is a list of available commands:
    new  - Create a new contact
    list - List all contacts
    show - Show a contact
    find - Find a contact"
  end
  
  def self.get_input
    STDIN.gets.chomp
  end


  def self.input_for_new_contact
    puts "what is the contact's name?"
    contact_name =  self.get_input
    puts "what is the contact's email?"
    contact_email = self.get_input
    Contact.create(contact_name, contact_email)
  end

  def self.menu_select
    
    case @command

    when 'new'
      ContactList.input_for_new_contact

    when 'list'
      Contact.all

    when 'show'
      Contact.show(@second_command.to_i)

    when 'find'
      Contact.find(@second_command)
      
    end
  end

end
#ContactList.menu
ContactList.menu_select

#puts bob = Contact.create('Bob', 'bob@computer')


