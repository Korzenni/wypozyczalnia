class BusinessHour < ActiveRecord::Base
  belongs_to :company

  enum day: [ :mon, :tue, :wed, :thu, :fri, :sat, :sun ]
end
