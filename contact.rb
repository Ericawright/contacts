require 'pg'

class Contact
 
  attr_accessor :name, :email, :phone_number
  
  def initialize(name, email, phone_number = [])
    @name = name
    @email = email
    @phone_number = phone_number
  end
 
  def to_s
    message = " #{name},#{email}"
    phone_number.each do |phone|
      message << phone.to_s
    end
    message
  end
  
  def to_array
    [@name, @email, @phone_number]
  end
 
 
  ## Class Methods
  class << self

    def init
      @@list_of_contacts = []
      
      CSV.readlines('contacts.csv').each do |row|
        phones = []
        name = row[0]
        email = row[1]
        row[2..-1].each do |phone|
          @parts = phone.split(":")
          type = @parts[0]
          digits = @parts[1]
          phones << PhoneNumber.new(type, digits)
        end
        @@list_of_contacts << Contact.new(name, email, phones)
      end
    end

    def connection
      conn = PG.connect(
        dbname: 'd9sv67tflremhi',
        port: 5432,
        user: 'nzgklrreikspna',
        host: 'ec2-54-163-225-82.compute-1.amazonaws.com',
        password: 'w4CQheonjCXxDLM38rMpSaS5rl'
      )
     #  conn.exec( "SELECT * FROM contacts" ) do |results|
     #    results.each do |contact|
     #      puts contact.inspect
     #    end
     # end

    end

    def create(name, email, phone_number=[])
      new_contact = Contact.new(name, email, phone_number)
      @@list_of_contacts.each do |row|
        if row.include?(name||email)
          return "This is a duplicate entry!"
        end
      end
      CSV.open('contacts.csv', 'a') do |csv_object|
        line = []
        line<< new_contact.name
        line<< new_contact.email
        new_contact.phone_number.each do |ph|
          line<< "#{ph.type}:#{ph.digits}"
      end
        csv_object << line
      end
      return 'success'
    end

    def find(search_term)
      populate_array = []
      @@list_of_contacts.each_with_index do |row, real_ind|
        if row.name.include?(search_term) || row.email.include?(search_term)
          populate_array << "#{real_ind+1}: #{row}"
        end
      end
      populate_array
    end
 
    def all
      populate_array = []
      @@list_of_contacts.each_with_index do |row, real_ind|
        populate_array << "#{real_ind+1}: #{row}"
      end
      populate_array
    end
    
    def show(index)
       @@list_of_contacts.each_with_index do |row, real_ind|
        if real_ind == index-1
          return"#{real_ind+1}: #{row}" 
        end 
      end 
      return "Contact does not exist"
    end 
  end
end

Contact.connection




