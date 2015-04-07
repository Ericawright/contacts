class Contact
 
  attr_accessor :name, :email
  
  def initialize(name, email)
    @name = name
    @email = email
    
  end
 
  # def to_string
  #   "#{@name},#{@email}"
  # end
  
  def to_array
    [@name, @email]
  end
 
 

  ## Class Methods
  class << self

    @@list_of_contacts = CSV.read('contacts.csv')

    def create(name, email)
      new_contact = Contact.new(name, email)
      @@list_of_contacts.each do |row|
        if row.include?(name||email)
          return "This is a duplicate entry!"
        end
      end
      CSV.open('contacts.csv', 'a') do |csv_object|
        csv_object << new_contact.to_array
        return "success!"
      end
    end

    def find(search_term)
      populate_array = []
      @@list_of_contacts.each_with_index do |row, real_ind|
        if row[0].include?(search_term) || row[1].include?(search_term)
          populate_array << "#{real_ind}: #{row[0]}, #{row[1]}"
        end
      end
      return populate_array
    end
 
    def all
      @@list_of_contacts.each_with_index do |row, real_ind|
        return "#{real_ind}: #{row[0]}, #{row[1]}"
      end
    
    end
    
    def show(index)
       @@list_of_contacts.each_with_index do |row, real_ind|
        if real_ind == index
          puts "#{real_ind}: #{row[0]}, #{row[1]}" 
          return 
        end
      end 
    end 
  end
end