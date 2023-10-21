require 'rails_helper'

RSpec.describe ExpenseCategory, type: :model do
  describe 'associations' do
    it 'belongs to an expense' do
      association = described_class.reflect_on_association(:expense)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a category' do
      association = described_class.reflect_on_association(:category)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
