class DoctorPatientsController < ApplicationController
  def destroy
    # require 'pry'; binding.pry
    dp = DoctorPatient.find(params[:id])
    doctor_id = dp.doctor_id
    dp.destroy
    redirect_to doctor_path(doctor_id)
  end
end
