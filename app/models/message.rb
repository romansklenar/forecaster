class Message < ActiveRecord::Base
  belongs_to :company

  def classification
    company.classifier.classify(title)
  end

  def as_json(options={})
    {
      :x => date.to_datetime.to_i * 1000,
      :title => classification.upcase[0],
      :text => title
    }
  end

end
