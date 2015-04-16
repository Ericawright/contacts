
class ContactListMenu

  @command = ARGV[0]
  @second_command = ARGV[1]
  @third_command = ARGV[2]
  @fourth_command =  ARGV[3]

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
      puts "What is the contact's first name?"
      @temp_first_name = self.get_input.downcase
      puts "What is the contact's last name?"
      @temp_last_name = self.get_input.downcase
      puts "What is the contact's email?"
      @temp_contact_email = self.get_input.downcase
    end

    def input_for_phone_number
      @numbers = []
      begin
        puts 'Do you want to enter a phone number? (y/n)'
        if STDIN.gets.chomp.downcase == 'y'
          phone = true
          puts 'Enter the type'
          type = STDIN.gets.chomp
          puts 'Enter the number'
          digits = STDIN.gets.chomp
          @numbers << @current.phone_numbers.new(phone_type: type, number: digits)
        else
          phone = false
        end
      end while phone == true
      @numbers.each {|obj| obj.save}
    end

    def menu_select
      
      case @command
      when 'list'
        p Contact.all
        p Contact.phone_numbers
      when 'show'
        p Contact.find(@second_command)
      when 'find'
        p Contact.find_by(@second_command.to_sym => @third_command.downcase)
      when 'new'
        ContactListMenu.input_for_contact
        @current = Contact.new(first_name: @temp_first_name, last_name: @temp_last_name, email: @temp_contact_email)
        ContactListMenu.input_for_phone_number
        @current.save
      when 'destroy'
        @current = Contact.find_by(id: @second_command)
        @current.destroy
      when 'update'
        @current = Contact.find(@second_command)
        @current.update(@third_command.underscore.to_sym => @fourth_command)
      else
        puts 'invalid command'
        ContactListMenu.menu
      end
    end
  end
end




