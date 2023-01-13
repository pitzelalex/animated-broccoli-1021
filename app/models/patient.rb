class Patient < ApplicationRecord
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients
  has_many :hospitals, through: :doctors
  scope :alphabetical_adults, -> { where('age > 18').order(:name)}

  def doctor_patient_by_doctor_id(doctor_id)
    self.doctor_patients.where(doctor_id: doctor_id).first
  end
end
