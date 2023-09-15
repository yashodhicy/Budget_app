require 'rails_helper'

RSpec.describe "Expense creation", type: :system do
    include Devise::Test::IntegrationHelpers

    let!(:user) do
        User.create!(
            name: 'yashodhi',
            email: 'yashodhi@mail.com',
            password: '123456',
            password_confirmation: '123456',
            confirmed_at: Time.now)
    end

  let!(:category) do
    Category.create!(
      name: 'Food',
      icon: 'https://example.com/food-icon.png',
      user: user
    )
  end

  describe 'create new expense for user' do
    before(:example) do
        sign_in user
    visit new_category_expense_path(category)
    end

  it "creates a new expense" do
    fill_in "Name", with: "Burger"
    fill_in "Amount", with: 10
    check category.name

    click_button "save"

    expect(page).to have_content("Expenses were successfully created.")
    expect(page).to have_content("Burger")
    expect(page).to have_content("10.0")
  end

  it "displays validation errors when submitting invalid data" do
    click_button "save"

    expect(page).to have_current_path(new_category_expense_path(category))
    
  end
end
end
