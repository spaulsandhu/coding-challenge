require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:leslie) do
    User.create(
      first_name: "Leslie",
      last_name: "Knope",
      email: "waffles_everyday@pawnee.gov",
      password: "password"
    )
  end

  let(:post) do
    Post.create(
      user: leslie,
      title: "Why Anne Perkins is Amazing.",
      body: "Anne Perkins is an amazing unicorn and the most perfect human being."
    )
  end

  subject do 
    Comment.new(user: leslie, post: post, body: "This is a great comment")
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
    it "is invalid without a body" do
      subject.body = ""
      expect(subject).to_not be_valid
    end
    it "is invalid with a body shorter than 5 characters" do
      subject.body = "Cool"
      expect(subject).to_not be_valid
    end
  end
end
