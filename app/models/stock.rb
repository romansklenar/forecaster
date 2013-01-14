class Stock < ActiveRecord::Base
  belongs_to :company

  def as_json(options={})
    [ date.to_datetime.to_i * 1000, open.to_f, high.to_f, low.to_f, close.to_f ]
  end
end
