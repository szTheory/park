class Cage < ApplicationRecord
  has_many :dinosaurs

  enum power_status: %i[ACTIVE DOWN]

  validates :power_status, presence: true, inclusion: { in: power_statuses.keys }

  class CagesCannotBePoweredOffIfTheyContainDinosaursValidator < ActiveModel::Validator
    def validate(record)
      return unless record.power_status == 'DOWN' && record.dinosaurs_count.positive?

      record.errors.add(:power_status, 'cannot be powered off if they contain dinosaurs')
    end
  end
  validates_with CagesCannotBePoweredOffIfTheyContainDinosaursValidator

  def dinosaurs_count
    dinosaurs.count
  end

  def dinosaurs_in_cage
    dinosaurs
  end
end
