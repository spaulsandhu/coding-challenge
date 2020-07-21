require "rails_helper"

RSpec.describe "Login and Logout", type: :system do
  describe "login page" do
    it "shows expected content" do
      visit root_path
      expect(page).to have_content("Please Login")
    end
  end

  describe "login failure" do
    it "fails to log in with bad email address or password" do
      visit root_path
      fill_in "email", with: "i_love_feature_tests@gmail.com"
      fill_in "password", with: "password"
      click_on "Log In"
      expect(page).to have_content("It looks like there was a problem with your email address or password, please try again.")
      expect(page).to_not have_content("Create Post")
    end
  end

  describe "successful login" do
    let(:ron) do 
      User.create(
        first_name: "Ron", 
        last_name: "Swanson", 
        email: "scotch_life@pawnee.gov", 
        password: "baconsteak"
      ) 
    end

    def create_posts
      Post.create(user: ron, title: "Great Post!", body: "Why am I writing a blog post when I could be fishing?")
    end

    def create_comments
      Comment.create(user: ron, post: Post.first, body: "This is a comment")
    end

    before do
      create_posts
      create_comments
    end
    
    it "successfully logs the user into the app" do
      visit root_path
      fill_in "email", with: ron.email
      fill_in "password", with: ron.password
      click_on "Log In"

      expect(page).to have_content("You've successfully logged in. Enjoy the best app ever.")
      expect(page).to have_content("Create Post")
    end

    it "redirects to the post index page" do
      visit root_path
      fill_in "email", with: ron.email
      fill_in "password", with: ron.password
      click_on "Log In"

      expect(page).to have_content(Post.first.title)
    end
  end
end

