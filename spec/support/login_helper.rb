module LoginHelper
  attr_reader :leslie

  def leslie
    @leslie = User.first
  end

  def create_user
    User.create(
      first_name: "Leslie", 
      last_name: "Knope", 
      email: "waffles_everyday@pawnee.gov", 
      password: "password"
    ) 
  end

  def create_post
    Post.create(user: leslie, title: "Ode to Anne", body: "Anne Perkins is Amazing")
  end

  def create_comment
    Comment.create(user: leslie, post: Post.first, body: "This is a comment")
  end

  def create_seed_data
    create_user
    create_post
    create_comment
  end

  def login_with_leslie
    create_seed_data
    visit root_path
    fill_in 'email', with: "waffles_everyday@pawnee.gov"
    fill_in 'password', with: 'password'
    click_button 'Log In'
  end
end
