class Doctor < ApplicationRecord
  has_many :medical_appointments, dependent: :destroy
  has_many :patients, through: :medical_appointments

  
  validates :name, :specialization, :email, :phone, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :phone, length: { is: 10 }, numericality: { only_integer: true }

  
  scope :by_specialization, ->(specialization) { where(specialization: specialization) }
  scope :available_today, ->(date = Date.today) {
    left_joins(:medical_appointments).where.not(medical_appointments: { appointment_date: date })
  }

  
  def upcoming_appointments
    medical_appointments.where("appointment_date >= ?", Date.today).order(:appointment_date, :appointment_time)
  end

  def total_patients
    patients.distinct.count
  end

end
