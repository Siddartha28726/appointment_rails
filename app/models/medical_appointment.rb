class MedicalAppointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  validates :appointment_date, :appointment_time, :status, presence: true
  validates :status, inclusion: { in: %w[pending confirmed cancelled completed] }
  validate :appointment_date_cannot_be_in_the_past

  
  scope :pending, -> { where(status: 'pending') }
  scope :confirmed, -> { where(status: 'confirmed') }
  scope :for_today, -> { where(appointment_date: Date.today) }
  scope :upcoming, -> { where("appointment_date >= ?", Date.today).order(:appointment_date, :appointment_time) }

  
  def confirm!
    update(status: 'confirmed') if status == 'pending'
  end

  def cancel!
    update(status: 'cancelled') unless status == 'completed'
  end

  def completed!
    update(status: 'completed')
  end

  private

  def appointment_date_cannot_be_in_the_past
    if appointment_date.present? && appointment_date < Date.today
      errors.add(:appointment_date, "can't be in the past")
    end
  end
end
