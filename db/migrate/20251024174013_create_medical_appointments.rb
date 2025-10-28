class CreateMedicalAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :medical_appointments do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.date :appointment_date
      t.time :appointment_time
      t.string :status

      t.timestamps
    end
  end
end
