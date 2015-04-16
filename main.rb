require 'active_record'
require 'pry'
require 'pry-nav'

require_relative 'contact'
require_relative 'contact_list_menu'
require_relative 'phone_number'

ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'd7kiuv2c6cin6a',
  port: 5432,
  user: 'lzsqcfxcphfgqf',
  host: 'ec2-23-23-81-189.compute-1.amazonaws.com',
  password: 'DHOyzmtgbBoeGlTlotoRFQBvXv'
)

ContactListMenu.menu_select