class Lease < ApplicationRecord
  belongs_to :apartment
  belongs_to :tenant

  validates :tenant_id, :apartment_id, presence: true
end
