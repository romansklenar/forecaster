class Company < ActiveRecord::Base
  has_many :messages,        dependent: :destroy
  has_many :stocks,          dependent: :destroy
  has_many :classifications, dependent: :destroy

  validates :name, :code, :messages_url, :stocks_url, presence: true
  validates :code, uniqueness: true

  after_create :import_stocks
  after_create :import_messages

  def import_stocks
  end

  def import_messages
  end
end
