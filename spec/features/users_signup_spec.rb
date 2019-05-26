require 'rails_helper'

feature "Sign up" do
  before do
    visit signup_path
  end

  subject { page }

  it { should have_selector("h1", text: "Sign up") }
  it { should have_field("Name") }
  it { should have_field("Email") }
  it { should have_field("Password") }
  it { should have_field("Password Confirmation") }
  it { should have_button("SUBMIT") }

  scenario "Email can't be blank" do
    visit signup_path
    fill_in("Name", with: "alice")
    fill_in("Email", with: "")
    fill_in("Password", with: "test1234")
    click_button("SUBMIT")

    expect(page).to have_selector("li", text: "Email can't be blank")
  end
end