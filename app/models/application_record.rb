class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :default_order, -> { order(created_at: :desc) }
end
