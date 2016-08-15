require "rails_helper"

RSpec.feature "Listing Articles" do 

	before do 
		@article1 = Article.create(title: "The first article", description: "Body of the first article")
		@article2 = Article.create(title: "The second article", description: "Body of the second article")
	end

	scenario "List all articles" do
		visit "/"

		expect(page).to have_content(@article1.title)
		expect(page).to have_content(@article1.description)
		expect(page).to have_content(@article2.title)
		expect(page).to have_content(@article2.description)
		expect(page).to have_link(@article1.title)
		expect(page).to have_link(@article2.title)
		expect(page).not_to have_link("New Article")
	end
end
