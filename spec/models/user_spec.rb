require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  it "ユーザーを作成できること" do
    expect(@user).to be_valid
  end

  it "nameが空のときはバリデーションされること" do
    @user.name = ""
    expect(@user).not_to be_valid
  end

  it "emailが空のときはバリデーションされること" do
    @user.email = ""
    expect(@user).not_to be_valid
  end

  it "emailの不正なフォーマットはバリデーションされること" do
    @user.email = '"hoge"@example.com'
    expect(@user).not_to be_valid
  end

  it "emailはユニークであること" do
    create(:user, name: "alice1", email: "alice@example.com")
    expect(build(:user, name: "alice2", email: "alice@example.com")).not_to be_valid
  end
end
