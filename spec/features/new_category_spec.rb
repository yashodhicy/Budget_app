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

  describe 'create new categories for user' do
    before(:example) do
      sign_in user1
      visit new_category_path
    end

    it 'has back link' do
        expect(page).to have_link('< Back', href: categories_path, class: 'link_to back')
    end

    it 'has form elements' do
        within('section.new_cat') do
            expect(page).to have_selector('form')
            expect(page).to have_field('category[name]')
            expect(page).to have_field('category[icon]')
            expect(page).to have_button('save')
        end
    end

    it 'should save and go to category page' do
        # Create a category with errors
        category = Category.new(user: user1, name: 'medicine', icon: 'https://tse3.mm.bing.net/th?id=OIP.l_yO7cUEnq6bVgsSMpsv0QHaHa&pid=Api&P=0&h=180')
    
        within('section.new_cat') do
          # Submit the form with invalid data
          fill_in 'category[name]', with: category.name
          fill_in 'category[icon]', with: category.icon
          click_button 'save'
        end

        expect(page).to have_current_path(categories_path)
    end

    it 'displays error messages when form submission fails' do
        # Create a category with errors
        category = Category.new(user: user1, name: nil, icon: nil)
        
        visit new_category_path
    
        within('section.new_cat') do
          # Submit the form with invalid data
          fill_in 'category[name]', with: category.name
          fill_in 'category[icon]', with: category.icon
          click_button 'save'
        end

        expect(page).to have_css('div', text: /prohibited this category from being saved:/)
    end
  end
end