# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

#clean all values
print "Clearing Universities table... (Please wait)\n"
print "Current row count: #{University.count}\n"
University.delete_all
print "Cleanup Done, current row count: #{University.count}\n\n"

#add all values from CSV
print "Populating DB with USA higher education institutions data... (Please wait)\n"

row_count = 0

CSV.foreach(Rails.root.join("db/seed/university.csv") , :headers=>true) do |row|
  row_count+=1 if University.create(Hash.new.replace row)
end

print "#{row_count} universities added to DB\n"