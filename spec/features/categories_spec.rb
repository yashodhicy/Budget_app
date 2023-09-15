require 'rails_helper'

RSpec.describe 'categories page', type: :system do
  include Devise::Test::IntegrationHelpers

  let!(:user1) do
    User.create!(
      name: 'yashodhi',
      email: 'yashodhi@mail.com',
      password: '123456',
      password_confirmation: '123456',
      confirmed_at: Time.now
    )
  end

  let!(:categories) do
    [
      Category.create!(
        user: user1,
        name: 'food',
        icon: 'https://tse2.mm.bing.net/th?id=OIP.H-JJ97qWShgZbn6IzNEkpAHaHa&pid=Api&P=0&h=180'
      ),
      Category.create!(
        user: user1,
        name: 'medicine',
        icon: 'https://tse3.mm.bing.net/th?id=OIP.l_yO7cUEnq6bVgsSMpsv0QHaHa&pid=Api&P=0&h=180'
      )
    ]
  end

  describe 'show correct categories for user' do
    before(:example) do
      sign_in user1
      visit categories_path
    end

    it 'should have new category link' do
      expect(page).to have_link('New category', href: new_category_path, class: 'link_to newcat')
    end

    it 'should have category details' do
      # expect(page).to have_content(category.name)
      categories.each do |category|
        # Verify icon and name
        expect(page).to have_css("img.icon[src='#{category.icon}']")
        expect(page).to have_css('span.cname', text: category.name)

        # Verify created_at date
        expect(page).to have_css('p', text: category.created_at.to_date.to_s)

        # Verify total_amount
        expect(page).to have_css('p.tamount', text: "$#{category.total_amount}")
      end
    end
  end

  describe 'category link' do
    before(:example) do
      sign_in user1
      visit categories_path
    end


    it 'redirects to the category show page when clicking on the link' do
      @category = categories.first

      find("a[href=\"#{category_path(@category)}\"]").click

      expect(page).to have_current_path(category_path(@category))
    end
  end
end
