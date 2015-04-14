# require 'csv'
require 'pg'
require_relative 'contact'
require_relative 'contact_database'
require_relative 'phone_number'

class ContactListMenu

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
      numbers = []
      puts "What is the contact's first name?"
      first_name =  self.get_input
      puts "What is the contact's last name?"
      last_name = self.get_input
      puts "What is the contact's email?"
      contact_email = self.get_input
      begin
        puts 'Do you want to enter a phone number? (y/n)'
        if STDIN.gets.chomp.downcase == 'y'
          phone = true
          puts 'Enter the type'
          type = STDIN.gets.chomp
          puts 'Enter the number'
          digits = STDIN.gets.chomp
          numbers << PhoneNumber.new(type, digits)
        else
          phone = false
        end
      end while phone == true
      puts Contact.create(first_name, last_name, contact_email, numbers)
    end


    def menu_select
      
      case @command
      when 'new'
        ContactListMenu.input_for_new_contact
      when 'list'
        puts Contact.all
      when 'show'
        puts Contact.show(@second_command.to_i)
      when 'find'
        puts Contact.find(@second_command)
      else
        puts 'invalid command'
        ContactListMenu.menu
      end
    end
  end
end

Contact.init
ContactListMenu.menu_select


