require 'csv'
require_relative 'contact'
require_relative 'contact_database'

class ContactList

  @command = ARGV[0]
  @second_command = ARGV[1]

  class << self

    def menu
      puts "Here is a list of available commands:
      new  - Create a new contact
      list - List all contacts
      show - Show a contact
      find - Find a contact"
    end
    
    def get_input
      STDIN.gets.chomp
    end

    def input_for_new_contact
      puts "what is the contact's name?"
      contact_name =  self.get_input
      puts "what is the contact's email?"
      contact_email = self.get_input
      puts Contact.create(contact_name, contact_email)
    end

    def menu_select
      
      case @command
      when 'new'
        ContactList.input_for_new_contact
     
      when 'list'
        puts Contact.all

      when 'show'
        puts Contact.show(@second_command.to_i)

      when 'find'
        puts Contact.find(@second_command)
     
      else
        puts 'invalid command'
        ContactList.menu
      end
    end
  end
end
ContactList.menu_select


