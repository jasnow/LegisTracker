class WatchedBill < ActiveRecord::Base
  belongs_to :user
  belongs_to :bill
end
