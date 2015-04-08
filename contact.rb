class Contact
 
  attr_accessor :name, :email, :phone_number
  
  def initialize(name, email, phone_number = [])
    @name = name
    @email = email
    @phone_number = phone_number
  end
 
  def to_s
    message = "#{name},#{email}"
    phone_number.each do |phone|
      message << phone.to_s
    end
    message
  end
  
  def to_array
    [@name, @email, @phone_number]#.reject{ |e| e.empty? }
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
        # puts phones
        # populate_all << "#{real_ind}: #{row[0]} #{row[1]} #{phones}"
        @@list_of_contacts << Contact.new(name, email, phones)
      end
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
        if row[0].include?(search_term) || row[1].include?(search_term)
          populate_array << "#{real_ind}: #{row[0]}, #{row[1]}"
        end
      end
      populate_array
    end
 
    def all
      @@list_of_contacts
      # populate_all = []

      # phones = []
      # @@list_of_contacts.each_with_index do |row, real_ind|
      #   row.each_with_index do |str, i|
      #     @name = str[0]
      #     @email = str[1]
      #     if i >= 2 
      #       @parts = str.split(":")
      #       type = @parts[0]
      #       digits = @parts[1]
      #       phones << PhoneNumber.new(type, digits)
      #     end
      #   end
      #   # puts phones
      #   # populate_all << "#{real_ind}: #{row[0]} #{row[1]} #{phones}"
      #   puts Contact.new(@name, @email, phones).to_string
      # end
    end
    
    def show(index)
       @@list_of_contacts.each_with_index do |row, real_ind|
        if real_ind == index
          return"#{real_ind}: #{row[0]}, #{row[1]}" 
        end 
      end 
      return "Contact does not exist"
    end 
  end
end




