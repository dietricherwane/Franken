# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
User.create (:username => 'duke', :phone_number => 1111, :gender => 'm', :area=> 'angre')
User.create (:username => 'ada', :phone_number => 2222, :gender => 'm')