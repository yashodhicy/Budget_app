require 'rails_helper'
RSpec.describe 'categories page', type: :system do
  include Devise::Test::IntegrationHelpers
    
    let!(:user1) do
      User.create!(
          name: 'yashodhi',
          email: 'yashodhi@mail.com',
          password: '123456',
          password_confirmation: '123456',
          confirmed_at: Time.now)
    end
  
    let!(:category) do
        Category.create!(
          user: user1,
          name: 'food',
          icon: 'https://tse2.mm.bing.net/th?id=OIP.H-JJ97qWShgZbn6IzNEkpAHaHa&pid=Api&P=0&h=180'
        )
    end

    let!(:expenses) do
        category.expenses.create!([
            { name: 'burger', amount: 12, user: user1 },
            { name: 'chips', amount: 5, user: user1 }
          ])
    end

  
    describe 'show correct expenses for a category' do
      before(:example) do
        sign_in user1
        visit category_path(category)
      end
      it 'has total amount' do
        expect(page).to have_content('Total amount:')
      end
      it 'has back link' do
        expect(page).to have_link('Back to categories', href: categories_path)
      end

      it 'has new expense create link' do
        expect(page).to have_link('New expense', href: new_category_expense_path(category))
      end

      it 'has new destroy category link' do
        expect(page).to have_button('Destroy this category', class: "link_to delete")
      end
      it 'has expenses details' do
        expenses.each do |expense|
            expect(page).to have_content(expense.name)
            expect(page).to have_content(expense.amount)
        end
      end
    end
end