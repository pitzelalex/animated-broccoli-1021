class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :doctor_patients
  has_many :patients, through: :doctor_patients
  scope :patients_order, -> { left_outer_joins(:patients).group(:id).order('count(distinct patients) desc') }
  def patient_count
    self.patients.count
  end
end
