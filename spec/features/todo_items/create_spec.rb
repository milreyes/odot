require 'spec_helper'

describe "Adding todo items" do

	let! (:todo_list) {TodoList.create(title: "Groceries", description: "Grocery List.")}

	it "is successful with valide content" do
		visit_todo_list(todo_list)
		click_link "New Todo Item"
		fill_in "Content", with: "Milk"
		click_button "Save"
		expect(page).to have_content "Added todo list item."
		within("ul.todo_items") do
			expect(page).to have_content "Milk"
		end
	end

	it "displays an error with no content" do
		visit_todo_list todo_list
		click_link "New Todo Item"
		fill_in "Content", with: ""
		click_button "Save"
		within("div.flash") do
			expect(page).to have_content("There was a problem adding that todo list item.")
		end
		expect(page).to have_content("Content can't be blank")
	end


	it "displays an error with when todo item has less than 2 characters long" do
		visit_todo_list todo_list
		click_link "New Todo Item"
		fill_in "Content", with: "A"
		click_button "Save"
		within("div.flash") do
			expect(page).to have_content("There was a problem adding that todo list item.")
		end
		expect(page).to have_content("Content is too short (minimum is 2 characters)")
	end

end

