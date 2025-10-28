class MedicalAppointmentsController < ApplicationController
  before_action :set_medical_appointment, only: [:show, :update, :destroy]

  
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { status: 404, error: "Not Found", message: e.message }, status: :not_found
  end

  
  def index
    @appointments = MedicalAppointment.includes(:doctor, :patient).all
    render json: @appointments.to_json(include: [:doctor, :patient])
  end

  
  def show
    render json: @medical_appointment.to_json(include: [:doctor, :patient])
  end

  
  def create
    @medical_appointment = MedicalAppointment.new(medical_appointment_params)
    if @medical_appointment.save
      render json: @medical_appointment, status: :created
    else
      render json: { status: 422, errors: @medical_appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  
  def update
    if @medical_appointment.update(medical_appointment_params)
      render json: @medical_appointment
    else
      render json: { status: 422, errors: @medical_appointment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  
  def destroy
    @medical_appointment.destroy
    render json: { status: 204, message: "Appointment deleted successfully" }, status: :no_content
  end

  private

  def set_medical_appointment
    @medical_appointment = MedicalAppointment.find(params[:id])
  end

  def medical_appointment_params
    params.require(:medical_appointment).permit(:doctor_id, :patient_id, :appointment_date, :appointment_time, :status)
  end
end
end
