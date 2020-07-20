require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:leslie) do
    User.new(
      first_name: "Leslie",
      last_name: "Knope",
      email: "waffles_everyday@pawnee.gov",
      password: "password"
    )
  end

  subject do
    Post.new(
      user: leslie,
      title: "Why Anne Perkins is Amazing.",
      body: "Anne Perkins is an amazing unicorn and the most perfect human being."
    )
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
    it "is invalid without a title" do 
      subject.title = ""
      expect(subject).to_not be_valid
    end
    it "is invalid without a body" do
      subject.body = ""
      expect(subject).to_not be_valid
    end
    it "is invalid with a body shorter than 10 characters" do
      subject.body = "123456789"
      expect(subject).to_not be_valid
    end
  end

  describe "when a record is destroyed" do
    def create_comments
      Comment.create(user: leslie, post: subject, body: "A new comment!")
    end

    before do 
      3.times do
        create_comments
      end
    end

    it "deletes all associated comment records" do
      expect(subject.comments.size).to eq(3)
      subject.destroy
      expect(subject.comments.size).to eq(0)
    end
  end
end
