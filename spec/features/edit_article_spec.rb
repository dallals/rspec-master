require "rails_helper"

RSpec.feature "Editing an Article" do

	before do
			@article = Article.create(title: "The article", description: "Body of the first article")
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