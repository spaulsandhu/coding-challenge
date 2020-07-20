require "rails_helper"

RSpec.describe User, type: :model do
  subject do 
    User.new(
      first_name: "Leslie",
      last_name: "Knope",
      email: "waffles_everyday@pawnee.gov",
      password: "password"
    )
  end

  context "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is invalid without a first_name" do
      subject.first_name = ""
      expect(subject).to_not be_valid
    end

    it "is invalid without a last_name" do
      subject.last_name = ""
      expect(subject).to_not be_valid
    end

    it "is invalid without an email address" do
      subject.email = ""
      expect(subject).to_not be_valid
    end

    it "is invalid without a password and password_confirmation" do
      subject.password = ""
      subject.password_confirmation = ""
      expect(subject).to_not be_valid
    end
  end

  context "instance methods" do
    describe "#name" do
      it "returns a string that includes the first and last_name fields" do
        expect(subject.name).to eq("Leslie Knope")
      end
    end
  end

  describe "when a record is destroyed" do
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
      3.times do 
        create_posts  
      end

      5.times do
        create_comments
      end
    end

    it "deletes all associated post records" do
      expect(Post.all.size).to eq(3)
      ron.destroy
      expect(Post.all.size).to eq(0)
    end
    it "deletes all associated comment records" do
      expect(Comment.all.size).to eq(5)
      ron.destroy
      expect(Comment.all.size).to eq(0)
    end
  end
end
