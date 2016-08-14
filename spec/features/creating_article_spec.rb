require 'rails_helper'

RSpec.feature "Creating Article" do
	scenario "A user creates a new articles" do
		visit "/"
		click_link "New Article"

		fill_in "Title", with: "Creating first article"
		fill_in "Description", with: "Lorem Ipsum"
		click_button "Create Article"

		expect(page).to have_content("Article has been created")
		expect(page.current_path).to eq(articles_path)
	end
	scenario "A user fails to create a new article" do
		visit "/"
		click_link "New Article"

		fill_in "Title", with: ""
		fill_in "Description", with: ""
		click_button "Create Article"

		expect(page).to have_content("Article has not been created")
		expect(page).to have_content("Title can't be blank")
		expect(page).to have_content("Description can't be blank")

	end
end