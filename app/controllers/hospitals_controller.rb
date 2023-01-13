class HospitalsController < ApplicationController
  def show
    @hospital = Hospital.find(params[:id])
    @doctors = @hospital.doctors.patients_order
  end
end
