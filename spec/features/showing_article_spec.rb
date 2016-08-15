require "rails_helper"

RSpec.feature "Showing an Article" do 

	before do
		@john = User.create(email: "john@example.com", password: "password")
		@fred = User.create(email: "fred@example.com", password: "password")
		@article = Article.create(title: "The first article", description: "Body of the first article", user: @john)
	end

	scenario "A non-signed in user does not see Edit or Delete links" do 
		visit "/"
		click_link @article.title
		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.description)
		expect(current_path).to eq(article_path(@article))
		expect(page).not_to have_link("New Article")
		expect(page).not_to have_link("Edit Article")
		expect(page).not_to have_link("Delete Article")
	end

	scenario "A non-owner signed in cannot see both links"  do
		login_as(@fred)
		visit "/"
		click_link @article.title
		expect(page).to have_link("New Article")
		expect(page).not_to have_link("Edit Article")
		expect(page).not_to have_link("Delete Article")
	end

	scenario "Display individual article by user" do
		visit "/"
		login_as(@john)
		click_link @article.title

		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.description)
		expect(current_path).to eq(article_path(@article))
		expect(page).to have_link("New Article")
		expect(page).to have_link("Edit Article")
		expect(page).to have_link("Delete Article")

	end

end