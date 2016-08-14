require "rails_helper"


RSpec.feature "Deleting an Article" do 



	before do
		@john = User.create(email: "john@example.com", password: "password")
		login_as(@john)
		@article = Article.create(title: "The article", description: "Body of the first article", user: @john)

		# visit "/"
		# click_link "Sign in"
		# fill_in "Email", with: @john.email
		# fill_in "Password", with: @john.password
		# click_button "Sign in"

		# expect(page).to have_content("Signed in successfully.")
		# expect(page).to have_content("Signed in as #{@john.email}")

	end

	scenario "A user deletes an article" do

		visit "/"
		click_link @article.title
		click_link "Delete Article"

		expect(page).to have_content("Article was successfully deleted")
		expect(current_path).to eq(articles_path)
	end


end