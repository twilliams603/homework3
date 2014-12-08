##                     ##
##     HOMEWORK 3      ##
##	  			 	   ##
##   Taylor Williams   ##
##                     ##

require_relative 'lib/connect'
require_relative 'models'

puts "###################################################\n### Welcome to your address book ###\n###################################################"

def main_menu()
	workflow = ["create", "search", "quit"]
	user_input = []
	while not workflow.include? user_input do
		puts "\nEnter \"create\" to create a new entry.
			    Enter \"search\" to search for an entry.
			    Enter \"quit\" to quit the application.\n\n"
	    print ">"
		user_input = gets.chomp
		if not workflow.include? user_input
			puts "\nI'm sorry, that is not a valid entry. Please try again.\n"
		elsif user_input == "create"
			puts create
		elsif user_input == "search"
			puts search
		elsif user_input == "quit"
			puts "Don't worry. Your #{Name.count} entries are safe with me! Goodbye."
			exit
		end
	end
end

def create()
	entry = AddressEntry.new 
	puts "You are adding a new entry.\n"
	print "First name:"
	entry.first_name = gets.chomp
	print "Last name:"
	entry.last_name = gets.chomp

	print "How many phone numbers would you like to add?"
	number_of_phone = gets.chomp.to_i
	number_of_phone.times do
		phone = PhoneNumber.new
		print "Please provide a category: "
		phone.category = gets.chomp
		print "Please provide a phone number: "
		phone.digits = gets.chomp
		entry.phone_numbers.push phone
	end

	print "How many email addresses would you like to add?"
	number_of_email = gets.chomp.to_i
	number_of_email.times do
		email = EmailAddress.new
		print "Please provide a category: "
		email.category = gets.chomp
		print "Please provide an email address: "
		email.address = gets.chomp
		entry.emails.push email
	end

	puts "\nSaving...\n"
	if entry.save
		puts "Saved successfully!"
	else
		puts "Save failed."
		puts "Here were the validation messages:"
		puts "#{entry.errors.messages}"
	end

puts main_menu

end

def search
	puts "\nYou are searching your address book by last name.\n\n"
	prints "Please provide the last name of the entry you are searching for: "
	user_input = gets.chomp
	query = AddressEntry.where("last_name like ?", user_input)
	puts "\nFound #{query.count} matches!"

	query.each do |object|

		puts "\nFirst name: #{object.first_name}"
		puts "Last name: #{object.last_name}"

		puts "Phone numbers:"
		query_phone = Phone.where("name_id like ?", object.id)
		query_phone.each.with_index do |object, index|
			puts "    [#{index+1}] #{object.digits} (#{object.category})"
		end

		puts "Email addresses:\n"
		query_email = EmailAddress.where("name_id like ?", object.id)
		query_email.each.with_index do |object, index|
			puts "    [#{index+1}] #{object.address} (#{object.category})"
		end

		puts "\n************************************************"

	end

	puts main_menu

end

puts main_menu




# ################################################################################

# # Define variables
# Addr_book = {}
# entry = { :first_name => "first_name", :last_name => "last_name", :phone_number => "phone_number", :email => "email" }
# workflow = [ "create_new_entry", "view_existing_entry", "delete_existing_entry", "quit_app" ]
# play = 1

# # MAIN MENU
# def main_menu()
# 	menu_valid = 1
# 	puts ("\nWelcome to the address book!")
# 	puts "---"

# 	until menu_valid == 0
# 		puts "Main Menu:\n"
# 		puts "Select from the following:\n"

# 		puts "1) Create new entry"
# 		puts "2) View existing entry"
# 		puts "3) Delete existing entry"
# 		puts "4) Quit application\n"
# 		puts "Enter:"

# 		menu = gets.chomp.to_i

# 		if menu != 1 and menu != 2 and menu != 3 and menu != 4
# 			puts "Invalid entry. Please try again."
# 		else
# 			menu_valid = 1
# 			if menu == 1
# 				create_new_entry
# 			elsif menu == 2
# 				view_existing_entry
# 			elsif menu == 3
# 				delete_existing_entry
# 			elsif menu == 4
# 				puts "Bye!!"
# 				menu_valid = 0
# 			end
# 		end
# 	end
# end 

# # 1) CREATE NEW ENTRY Workflow
# def create_new_entry()
# 	puts "You are adding a new entry."
# 	entry = {}
# 	puts "First name:"
# 	entry[:first_name] = gets().chomp
# 	puts "Last name:"
# 	entry[:last_name] = gets().chomp
# 	puts "Phone number:"
# 	entry[:phone_number] = gets().chomp
# 	puts "Email:"
# 	entry[:email] = gets().chomp
# 	# entry.each do |entry_field, value|
# 	# 	puts "Enter the person's #{entry_field}:"
# 	# 	value = gets.chomp
# 	# 	puts entry.inspect
# 	# 	puts "---"
# 	# end
# 	entry_name = entry[:last_name] + ", " + entry[:first_name]
# 	Addr_book[entry_name] = entry
# 	puts Addr_book.inspect
# 	# Exit workflow and return to main menu.
# end

# # 2) VIEW EXISTING ENTRY Workflow
# def view_existing_entry()
# 	# Print overview of existing entries
# 	entry_valid = 0
# 	addr_book_array = []
# 	Addr_book.each do |entry_name, entry|
# 		addr_book_array.push entry_name
# 	end
# 	puts "---"
# 	addr_book_array.each_with_index do |element, index|
# 		puts index.to_s + "   " + element
# 	end
# 	# Prompt user for entry
# 	while entry_valid == 0
# 		puts "Which entry would you like to view? <0, 1, 2, etc.>"
# 		entry_to_view = gets.chomp.to_i
# 		entry_name = addr_book_array[entry_to_view]
# 		if Addr_book.key?(entry_name) == true
# 			Addr_book[entry_name].each do |key, value|
# 				puts key.to_s + ": " + value
# 			end
# 			puts "---"
# 			entry_valid = 1
# 		else 
# 			puts "That entry is bogus. Try again."
# 		end
# 	end
# 	# Exit this workflow and return to main menu
# end

# # 3) DELETE EXISTING ENTRY Workflow
# def delete_existing_entry()
# 	# Print overview of existing entries
# 	entry_valid = 0
# 	addr_book_array = []
# 	Addr_book.each do |entry_name, entry|
# 		addr_book_array.push entry_name
# 	end
# 	puts "---"
# 	addr_book_array.each_with_index do |element, index|
# 		puts index.to_s + "   " + element
# 	end
# 	# Prompt user for entry
# 	while entry_valid == 0
# 		puts "Which entry would you like to delete? <0, 1, 2, etc.>"
# 		entry_to_delete = gets.chomp.to_i
# 		entry_name = addr_book_array[entry_to_delete]
# 		if Addr_book.key?(entry_name) == true
# 			Addr_book.delete(entry_name)
# 			#.delete(key) # delete from a hash using .delete(key). give it the key you want to delete.
# 			# delete_at deletes an element at a specific index. (use for an array usually)
# 			puts "Entry deleted!"
# 			puts "---"
# 			entry_valid = 1
# 		else 
# 			puts "That entry is bogus. Try again."
# 		end
# 	end
# 	# Exit this workflow and return to main menu
	

# end

# main_menu

# ####################################################################################

# # Alphabetize
# for addr_book[last_name]
# if addr_book[last_name] < addr_book[last_name - 1] then addr_book.shift last_name
# end 

# # SORT ALPHABETICALLY


# addr_book.each do |entry|
# if entry[1] > (entry + 1)[1]
# 	addr_book.unshift entry
# 	addr_book.delete_at entry
# end
# puts addr_book.inspect

