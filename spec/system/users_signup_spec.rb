require 'rails_helper'

RSpec.describe "Users", type: :system do
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

  it "should validation error" do
    visit signup_path
    fill_in("Name", with: "alice")
    fill_in("Email", with: "")
    fill_in("Password", with: "")
    click_button("SUBMIT")

    expect(page).to have_selector("span.helper-text")
  end
end