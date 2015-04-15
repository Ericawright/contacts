# require 'pg'

class Contact < ORM
 
  attr_accessor :first_name, :last_name, :email, :phone_number, :id
  
  def initialize(first_name, last_name, email, id = nil)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @id = id
    @phone_number = []
  end
 
  def to_s
    message = "#{id}: #{first_name} #{last_name}, #{email},"
    @phone_number.each do |phone|
      message << phone.to_s
    end
    message
  end

  def save
    alt_phone = []
    @phone_number.each do |obj|
      alt_phone << obj.to_s
    end
    if @id == nil
      sql = "INSERT INTO contacts(first_name, last_name, email, phone_number) VALUES ($1, $2, $3, $4) RETURNING *"
      results = ContactDatabase.connection.exec_params(sql, [@first_name, @last_name, @email, alt_phone.join(',')])
      @id = results[0]["id"]
      puts 'saved'
    else
      sql = "UPDATE contacts SET first_name = $1, last_name = $2, email = $3, phone_number = $4 WHERE id=$5"
      ContactDatabase.connection.exec_params(sql, [@first_name, @last_name, @email, alt_phone.join(','), @id])
      puts 'updated'
    end   
  end

  def destroy
    ContactDatabase.connection.exec_params("DELETE FROM contacts WHERE id = #{@id}")
    puts 'DELETED'
  end

  def update(first_name, last_name, email, numbers)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone_number = numbers
    self.save
  end
 
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
      new_contact.save
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
          return obj if obj.id == index
      end 
      return "Contact does not exist"
    end 
  end
end


