class Dinosaur < ApplicationRecord
  CARNIVORES = %w[tyrannosaurus velociraptor spinosaurus megalosaurus].freeze
  HERBIVORES = %w[brachiosaurus stegosaurus ankylosaurus triceratops].freeze
  SPECIES = CARNIVORES + HERBIVORES

  belongs_to :cage

  scope :carnivores, -> { where(species: CARNIVORES) }
  scope :herbivores, -> { where(species: HERBIVORES) }

  def carnivore?
    CARNIVORES.include?(species)
  end

  def herbivore?
    HERBIVORES.include?(species)
  end

  class CarnivoresCanOnlyBeInCageWithSameSpeciesValidator < ActiveModel::Validator
    def validate(record)
      return unless record.carnivore?
      return unless record.cage
      return unless record.cage.dinosaurs
                          .where.not(species: record.species)
                          .where.not(id: record.id).exists?

      record.errors.add(:cage, 'carnivores can only be in cage with same species')
    end
  end
  validates_with CarnivoresCanOnlyBeInCageWithSameSpeciesValidator

  class DinosaursCannotBeMovedIntoAPoweredDownCageValidator < ActiveModel::Validator
    def validate(record)
      return unless record.cage && record.cage.power_status == 'DOWN'

      record.errors.add(:cage, 'cannot be powered down if they contain dinosaurs')
    end
  end
  validates_with DinosaursCannotBeMovedIntoAPoweredDownCageValidator

  # TODO: add tests
  class CarnivoresCantBeInSameCageAsHerbivoresValidator < ActiveModel::Validator
    def validate(record)
      return unless record.cage

      return unless record.carnivore? && record.cage.dinosaurs.herbivores.any?

      record.errors.add(:cage, :invalid, message: 'carnivores cannot be in same cage as herbivores')
    end
  end
  validates_with CarnivoresCantBeInSameCageAsHerbivoresValidator

  enum species: SPECIES

  validates :name, presence: true
  validates :species, inclusion: { in: species.keys }, presence: true
end
