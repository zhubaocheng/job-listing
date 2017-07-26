class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :jobs
  has_many :resumes
  has_many :job_collections
  has_many :collected_jobs, :through => :job_collections, :source => :job

  def has_collected?(job)
    collected_jobs.include?(job)
  end

  def collect!(job)
    collected_jobs << job
  end

  def quit_collect!(job)
    collected_jobs.delete(job)
  end

  def admin?
    is_admin
  end

  def display_name
    if self.username.present?
      self.username
    else
      self.email.split("@").first
    end
  end
end
