require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has and belongs to many expenses' do
      association = described_class.reflect_on_association(:expenses)
      expect(association.macro).to eq(:has_and_belongs_to_many)
    end
  end

  describe 'validations' do
    it 'validates presence of name' do
      category = Category.new(icon: 'icon')
      expect(category).not_to be_valid
      expect(category.errors[:name]).to include("can't be blank")
    end

    it 'validates uniqueness of name' do
      user = User.create(name: 'John Doe')
      existing_category = Category.create(name: 'Category1 Name', icon: 'category-icon', user: user)
      new_category = Category.create(name: 'Category1 Name', icon: 'another-icon', user: user)
      expect(existing_category).to be_valid
      expect(new_category).not_to be_valid
      expect(new_category.errors[:name]).to include('has already been taken')
    end

    it 'validates presence of icon' do
      category = Category.new(name: 'Category2 Name')
      expect(category).not_to be_valid
      expect(category.errors[:icon]).to include("can't be blank")
    end
  end
end

