class Classification < ActiveRecord::Base
  belongs_to :company

  scope :positive, lambda { where(category: 'positive') }
  scope :negative, lambda { where(category: 'negative') }
end
