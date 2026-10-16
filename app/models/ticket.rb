class Ticket < ApplicationRecord
  validates :title, presence: true
  validates :status, inclusion: { in: %w[open in_progress closed] }

  before_validation :set_defaults

  private

  def set_defaults
    self.status ||= "open"
    self.customer_name = "Misafir Müşteri" if customer_name.blank?
    self.customer_email = "musteri@ornek.com" if customer_email.blank?
  end
end
