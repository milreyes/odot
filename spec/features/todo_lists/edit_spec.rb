require 'spec_helper'

describe "Editing todo lists" do

	# This method takes a current list and a hash for the title and description.
	
	let! (:todo_list) {TodoList.create(title: "Groceries", description: "Grocery List.")}

	def edit_todo_list(todo_list, options={})

		options[:new_title] ||= "New title"
		options[:new_description] ||= "New description"

		visit "/todo_lists"

		within "#todo_list_#{todo_list.id}" do
		
			click_link "Edit"

		end

		fill_in "Title", with: options[:new_title]
		fill_in "Description", with: options[:new_description]
		click_button "Update Todo list"

		todo_list.reload

	end
	
	it "updates a todo list succesfully with correct information" do

		edit_todo_list todo_list

		expect(page).to have_content "Todo list was successfully updated"
		expect(todo_list.title).to eq("New title")
		expect(todo_list.description).to eq("New description")

	end

	it "displays an error when the title is left empty" do
		edit_todo_list todo_list, new_title: ""
		expect(page).to have_content("error")
	end

	it "displays an error with too short a title" do
		edit_todo_list todo_list, new_title: "hi"
		expect(page).to have_content("error")
	end

	it "displays an error when the description is left empty" do
		edit_todo_list todo_list, new_description: ""
		expect(page).to have_content("error")
	end

	it "displays an error with too short a description" do
		edit_todo_list todo_list, new_description: "Food"
		expect(page).to have_content("error")
	end

end
