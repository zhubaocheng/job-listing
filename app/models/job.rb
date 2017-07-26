class Job < ApplicationRecord
  has_many :resumes
  validates_presence_of :title, :description, :company, :city, :experience, :contact_email
  validates_presence_of :wage_upper_bound
  validates_presence_of :wage_lower_bound
  validates :wage_lower_bound, numericality: { greater_than: 0}
  validates :wage_upper_bound, numericality: { greater_than: 0}

  has_many :job_collections
  has_many :collectors, through: :job_collections, source: :user
  belongs_to :user


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
