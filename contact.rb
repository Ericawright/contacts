class Contact
 
  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end
 
  def to_string
    "#{@name},#{@email}"
  end
  
  def to_array
    [@name, @email]
  end
 
 @list_of_contacts = []

  ## Class Methods
  class << self
    def create(name, email)
      new_contact = Contact.new(name, email)
      # @list_of_contacts << {name: name, email: email}
      # TODO: Will initialize a contact as well as add it to the list of contacts
      CSV.open('contacts.csv', 'a') do |csv_object|
          csv_object.add_row(new_contact.to_array)
      end
      #   CSV.open('contacts.csv', 'r') do |csv_object|
          
      # end
    end
 
    def find(index)
      i = 0
       CSV.foreach('contacts.csv') do |row|
        if i == index
          puts "#{i}: #{row[0]}, #{row[1]}" 
          return 
        end
        i += 1
      end 
    end
 
    def all
      # TODO: Return the list of contacts, as is
      i = 1
      CSV.foreach('contacts.csv') do |row|
        #contact_array = row.inspect
        #puts "#{i} #{contact_array}"
        puts "#{i}: #{row[0]}, #{row[1]}"
        i += 1
      end
      # CSV.open('contacts.csv', 'r') do |csv_object|
      #   contacts.array.each_with index do |row_array|
      #     puts csv_object
      #   end
      # end
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
    end
    
  end
 
end