require "rails_helper"

RSpec.feature "Editing an Article" do

	before do
		@article = Article.create(title: "The article", description: "Body of the first article")
		@john = User.create(email: "john@example.com", password: "password")

		visit "/"
		click_link "Sign in"
		fill_in "Email", with: @john.email
		fill_in "Password", with: @john.password
		click_button "Sign in"

		expect(page).to have_content("Signed in successfully.")
		expect(page).to have_content("Signed in as #{@john.email}")

	end

	scenario "Edit article" do
		visit "/"
		click_link @article.title
		click_link "Edit Article" 
		# expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.description)
		expect(current_path).to eq(edit_article_path(@article))
		fill_in "Title", with: "Creating first article"
		fill_in "Description", with: "Lorem Ipsum"
		click_button "Update Article"
		
		expect(page).to have_content("Article was successfully updated")
		expect(page).to have_content("Creating first article")
		expect(page).to have_content("Lorem Ipsum")
	end

	scenario "A user fails to create a update article" do
		visit "/"
		click_link @article.title
		click_link "Edit Article"
		expect(current_path).to eq(edit_article_path(@article))
		fill_in "Title", with: ""
		fill_in "Description", with: ""
		click_button "Update Article"
		
		expect(page).to have_content("Article has not been updated")
		expect(page).to have_content("Title can't be blank")
		expect(page).to have_content("Description can't be blank")

	end
end