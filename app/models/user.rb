class User < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  has_many :requests

  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
  :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
 
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  
  def completed_requests_count
    requests.where(completion_status: true).count
  end
end
