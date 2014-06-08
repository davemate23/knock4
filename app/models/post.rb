class Post < ActiveRecord::Base
  before_create :set_latlong
  belongs_to :postable, polymorphic: true
  belongs_to :knocker

  has_many :interests
  validates :content, presence: true
  validates :postable_id, presence: true
  validates :postable_type, presence: true

  def set_latlong
	self.latitude = knocker.latitude
	self.longitude = knocker.longitude
  end

end
