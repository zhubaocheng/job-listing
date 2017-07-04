class Job < ApplicationRecord
  has_many :resumes
  validates_presence_of :title, :description
  validates_presence_of :wage_upper_bound
  validates_presence_of :wage_lower_bound
  validates :wage_lower_bound, numericality: { greater_than: 0}

  scope :published, -> { where(is_hidden: false)}
  scope :recent, -> { order("created_at DESC")}

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end
end
