class ORM

  def initialize

  end

  # def save
  #   if @id == nil
  #     alt_phone = []
  #     @phone_number.each do |obj|
  #       alt_phone << obj.to_s
  #     end
  #     sql = "INSERT INTO contacts(first_name, last_name, email, phone_number) VALUES ($1, $2, $3, $4) RETURNING *"
  #     results = ContactDatabase.connection.exec_params(sql, [@first_name, @last_name, @email, alt_phone.join(',')])
  #     @id = results[0]["id"]
  #     puts 'saved'
  #   else
  #     sql = "UPDATE contacts SET first_name = $1, last_name = $2, email = $3, phone_number = $4 WHERE id=$5"
  #     ContactDatabase.connection.exec_params(sql, [@first_name, @last_name, @email, @phone_number, @id])
  #     puts 'updated'
  #   end   
  # end


  def new

  end

  def find

  end

  def find_by

  end

  def save

  end

  def destroy

  end

end