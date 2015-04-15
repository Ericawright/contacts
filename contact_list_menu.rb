
class ContactListMenu

  @command = ARGV[0]
  @second_command = ARGV[1]

  class << self

    def menu
      puts "Here is a list of available commands:
      new  - Create a new contact
      list - List all contacts
      show - Show a contact
      find - Find a contact
      destroy - destroy selected contact
      update - change a contact's info"
    end
    
    def get_input
      STDIN.gets.chomp
    end

    def input_for_contact
      @numbers = []
      puts "What is the contact's first name?"
      @temp_first_name = self.get_input
      puts "What is the contact's last name?"
      @temp_last_name = self.get_input
      puts "What is the contact's email?"
      @temp_contact_email = self.get_input
      begin
        puts 'Do you want to enter a phone number? (y/n)'
        if STDIN.gets.chomp.downcase == 'y'
          phone = true
          puts 'Enter the type'
          type = STDIN.gets.chomp
          puts 'Enter the number'
          digits = STDIN.gets.chomp
          @numbers << PhoneNumber.new(type, digits)
        else
          phone = false
        end
      end while phone == true
    end


    def menu_select
      
      case @command
      when 'new'
        ContactListMenu.input_for_contact
        puts Contact.create(@temp_first_name, @temp_last_name, @temp_contact_email, @numbers)
      when 'list'
        puts Contact.all
      when 'show'
        puts Contact.show(@second_command.to_i)
      when 'find'
        puts Contact.find(@second_command)
      when 'destroy'
        current = Contact.show(@second_command.to_i)
        current.destroy
      when 'update'
        puts current = Contact.show(@second_command.to_i)
        ContactListMenu.input_for_contact
        current.update(@temp_first_name, @temp_last_name, @temp_contact_email, @numbers)

      else
        puts 'invalid command'
        ContactListMenu.menu
      end
    end
  end
end




