class Ticket < ApplicationRecord
  validates :title, presence: true
  validates :status, inclusion: { in: %w[open in_progress closed] }
end
