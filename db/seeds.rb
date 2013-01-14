# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# RSS channels taken from http://finance.yahoo.com/rssindex

# import companies
apple = Company.create! do |company|
  company.name = "Apple Inc."
  company.code = "AAPL"
  company.messages_url = "http://www.apple.com/pr/feeds/pr.rss"
  company.stocks_url = "http://ichart.finance.yahoo.com/table.csv?s=#{company.code}"
end


google = Company.create! do |company|
  company.name = "Google"
  company.code = "GOOG"
  company.messages_url = "http://finance.yahoo.com/rss/headline?s=GOOG"
  company.stocks_url = "http://ichart.finance.yahoo.com/table.csv?s=GOOG"
end


# import classifications
YAML::load_file("#{Rails.root}/db/seeds/classifications.AAPL.positive.yml").each { |text| apple.classifications.create!(text: text, category: :positive) }
YAML::load_file("#{Rails.root}/db/seeds/classifications.AAPL.negative.yml").each { |text| apple.classifications.create!(text: text, category: :negative) }

YAML::load_file("#{Rails.root}/db/seeds/classifications.GOOG.positive.yml").each { |text| google.classifications.create!(text: text, category: :positive) }
YAML::load_file("#{Rails.root}/db/seeds/classifications.GOOG.negative.yml").each { |text| google.classifications.create!(text: text, category: :negative) }


# # import Apple press releases
# require 'open-uri'
# require 'nokogiri'
# require 'htmlentities'
#
# crawler = lambda { |url, path| Nokogiri::HTML(open(url)).css(path) }
# apple.messages.destroy_all
# Message.transaction do
#   (2000..2013).each do |year|
#     url  = "http://www.apple.com/pr/library/#{year}/"
#     path = "div#content ul.releases li dl dd a"
#
#     elements = crawler.call(url, path).to_a.delete_if { |el| el['href'].include?("/pdf/") || el['href'].starts_with?("/") }
#     elements.reverse.each do |el|
#       message = Message.new
#       message.company = apple
#       message.title = HTMLEntities.new.decode(el.text).squish.strip
#       message.link  = url + el['href']
#       message.date  = Date.strptime(message.link.gsub(url[0..-6], "")[0,10], '%Y/%m/%d')
#
#       begin
#         content = crawler.call(message.link, "div#content").first
#         message.content_html = content.to_s
#         message.content_text = HTMLEntities.new.decode(content.text).squish.strip
#       rescue OpenURI::HTTPError => e
#         message.content_html = message.content_text = e.message
#       end
#       message.save! unless message.content_html.blank? || message.content_text.blank?
#     end
#
#   end
# end
