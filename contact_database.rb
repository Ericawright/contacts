class ContactDatabase
  
  class << self
    def connection
      conn = PG.connect(
        dbname: 'd9sv67tflremhi',
        port: 5432,
        user: 'nzgklrreikspna',
        host: 'ec2-54-163-225-82.compute-1.amazonaws.com',
        password: 'w4CQheonjCXxDLM38rMpSaS5rl'
      )
    end
  end
end

#ContactDatabase::conn.exec()
