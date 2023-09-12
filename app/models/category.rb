class Category < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :expenses

  validates :name, presence: true, uniqueness: true
  validates :icon, presence: true
end
