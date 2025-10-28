class Patient < ApplicationRecord
  has_many :medical_appointments, dependent: :destroy
  has_many :doctors, through: :medical_appointments

  
  validates :name, :email, :phone, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :phone, length: { is: 10 }, numericality: { only_integer: true }
  validates :age, numericality: { greater_than_or_equal_to: 0 }

  
  scope :by_gender, ->(gender) { where(gender: gender.capitalize) }
  scope :recently_registered, -> { order(created_at: :desc).limit(10) }

  
  def upcoming_appointments
    medical_appointments.where("appointment_date >= ?", Date.today).order(:appointment_date, :appointment_time)
  end

  def booked_with?(doctor)
    medical_appointments.exists?(doctor_id: doctor.id)
  end
end
