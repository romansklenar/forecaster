class Message < ActiveRecord::Base
  belongs_to :company

  def classification
    company.classifier.classify(title)
  end
end
