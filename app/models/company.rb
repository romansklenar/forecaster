class Company < ActiveRecord::Base
  include ActionView::Helpers

  has_many :messages,        dependent: :destroy
  has_many :stocks,          dependent: :destroy
  has_many :classifications, dependent: :destroy

  validates :name, :code, :messages_url, :stocks_url, presence: true
  validates :code, uniqueness: true

  after_create :import_stocks
  after_create :import_messages

  def import_stocks
    require 'open-uri'
    require 'csv'

    rows = CSV.parse(open(stocks_url).read).reverse
    header = rows.pop.map { |s| s.parameterize.underscore.to_sym } # [:date, :open, :high, :low, :close]

    transaction do
      rows.each do |i|
        row = Hash[[header, i].transpose]
        stocks.create! do |stock|
          stock.date  = Date.strptime(row[:date]) #, '%m-%d-%Y')
          stock.open  = row[:open]
          stock.high  = row[:high]
          stock.low   = row[:low]
          stock.close = row[:close]
        end
      end
    end
  end

  def import_messages
    require 'open-uri'
    require 'rss'
    require 'htmlentities'

    rss = RSS::Parser.parse(open(messages_url).read, false)

    transaction do
      rss.items.reverse.each do |item|
        message = messages.where(link: item.link).first_or_initialize
        if message.new_record?
          message.title = HTMLEntities.new.decode(item.title).squish.strip
          message.date  = item.date
          message.content_html = item.description
          message.content_text = HTMLEntities.new.decode(sanitize(item.description)).squish.strip
          message.save! unless message.content_html.blank? || message.content_text.blank?
        end
      end
    end
  end

  def classifier
    unless defined?(@classifier)
      require 'classifier'
      
      @classifier = Classifier::Bayes.new('positive', 'negative')
      classifications.positive.pluck(:text).each { |s| @classifier.train(:positive, s) }
      classifications.negative.pluck(:text).each { |s| @classifier.train(:negative, s) }
    end

    @classifier
  end

  def to_param
    code
  end
end
