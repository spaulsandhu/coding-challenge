require "rails_helper"

RSpec.describe "User can search for posts, view them and delete them", type: :system do
  describe "posts index using search" do
    it "shows expected content" do    
      login_with_leslie
      first_post = Post.first
      expect(page).to have_content(first_post.title)
      find('span.absolute.top-0.right-0.px-4.py-3.close-x').click
      
      fill_in "query", with: "lets go dancing hella yeah!!!!"
      find(".bg-purple-white.shadow.rounded.border-0.p-3.w-full").native.send_keys(:return)
      
      expect(page).to_not have_content(first_post.title)

      fill_in "query", with: first_post.title
      find(".bg-purple-white.shadow.rounded.border-0.p-3.w-full").native.send_keys(:return)

      expect(page).to have_content(first_post.title)
    end
  end

  describe "user can click to view post details" do
    it "displays the details of the post" do
      login_with_leslie
      first_post = Post.first
      expect(page).to have_content(first_post.title)
      find('span.absolute.top-0.right-0.px-4.py-3.close-x').click

      # comments link
      within find(".mt-8") do
        find("a[href='#{post_path(first_post.id)}']").click
      end
      expect(page).to have_content(first_post.body)
      expect(page).to have_content("Delete Post")
    end 
  end

  describe "the post creator can delete the post" do
    it "deletes the post" do
      login_with_leslie
      first_post = Post.first
      expect(page).to have_content(first_post.title)
      find('span.absolute.top-0.right-0.px-4.py-3.close-x').click

      within find(".mt-8") do
        find("a[href='#{post_path(first_post.id)}']").click
      end
      
      click_on "Delete Post"
      expect(page).to_not have_content(first_post.title)
    end 
  end
end