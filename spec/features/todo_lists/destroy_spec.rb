require 'spec_helper'

describe "Editing todo lists" do

	# This method takes a current list and a hash for the title and description.
	
	let! (:todo_list) {TodoList.create(title: "Groceries", description: "Grocery List.")}

	def destroy_todo_list(todo_list)

		visit "/todo_lists"

		within "#todo_list_#{todo_list.id}" do
		
			click_link "Destroy"

		end

		# todo_list.reload

	end
	
	it "is succesful when clicking the destroy link" do

		destroy_todo_list todo_list

		expect(page).to_not have_content(todo_list.title)
		expect(TodoList.count).to eq(0)

	end

end