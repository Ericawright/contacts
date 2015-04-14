# require 'pg'

class Contact
 
  attr_accessor :first_name, :last_name, :email, :phone_number, :id
  
  def initialize(first_name, last_name, email, id = nil)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @id = id
    @phone_number = []
  end
 
  def to_s
    message = "#{id}: #{first_name}, #{last_name}, #{email}"
    phone_number.each do |phone|
      message << phone.to_s
    end
    message
  end
  
  # def to_array
  #   [@name, @email, @phone_number]
  # end
 
  class << self

    def init
      @@list_of_contacts = []
      ContactDatabase.connection.exec('SELECT * FROM contacts;').each do |row|
        id = row['id'].to_i
        first_name = row['first_name']
        last_name = row['last_name']
        email = row['email']
        @phones = []
        row['phone_number'].to_s.split(",").each do |phone|
          @parts = phone.split(":")
          type = @parts[0]
          digits = @parts[1]
          @phones << PhoneNumber.new(type,digits)
        end
        temp = Contact.new(first_name, last_name, email, id)
        temp.phone_number = @phones 
        @@list_of_contacts << temp
      end
      @@list_of_contacts
    end

    def create(first_name, last_name, email, phone_number=[])
      @@list_of_contacts.each do |obj|
        if obj.first_name == first_name && obj.last_name == last_name || obj.email == email
          return "This is a duplicate entry!"
        end
      end
      new_contact = Contact.new(first_name, last_name, email)
      new_contact.phone_number = phone_number
      return 'success'
    end

    def find(search_term)
      populate_array = []
      @@list_of_contacts.each do |obj|
        if obj.first_name.include?(search_term) || obj.last_name.include?(search_term) || obj.email.include?(search_term)
          populate_array << obj
        end
      end
      populate_array
    end
 
    def all
      @@list_of_contacts
    end
    
    def show(index)
       @@list_of_contacts.each do |obj|
        if obj.id == index
          return obj 
        end 
      end 
      return "Contact does not exist"
    end 
  end
end


