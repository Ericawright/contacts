
  

#     def connection
#       conn = PG.connect(
#         dbname: 'd9sv67tflremhi',
#         port: 5432,
#         user: 'nzgklrreikspna',
#         host: 'ec2-54-163-225-82.compute-1.amazonaws.com',
#         password: 'w4CQheonjCXxDLM38rMpSaS5rl'
#       )
#     end
#   end
# end
require 'active_record'

require_relative 'contact'
require_relative 'contact_list_menu'
require_relative 'phone_number'

ActiveRecord::Base.logger = Logger.new(STDOUT)

class ContactDatabase

  class << self
    
    def connection
      ActiveRecord::Base.establish_connection(
        adapter: 'postgresql',
        database: 'd9sv67tflremhi',
        port: 5432,
        user: 'nzgklrreikspna',
        host: 'ec2-54-163-225-82.compute-1.amazonaws.com',
        password: 'w4CQheonjCXxDLM38rMpSaS5rl'
      )
    end
  end
end
ContactDatabase.connection

#Contact.init
# ContactListMenu.menu_select