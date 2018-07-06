class GroupEvent < ApplicationRecord
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :only_deleted, -> { where.not(deleted_at: nil) }
  scope :without_deleted, -> { where(deleted_at: nil) }

  before_validation :set_end_and_duration, on: %i[create update]

  validates :start_date,
            date: {
              after_or_equal_to: proc { Date.today },
              message: 'can\'t be in the past'
            },
            if: -> { start_date.present? }

  validates :end_date,
            date: { after: :start_date, message: 'can\'t be lesser than start date' },
            if: -> { start_date.present? && end_date.present? }

  with_options if: :published do
    validates_presence_of :name, :description,
                          :start_date, :end_date,
                          :duration, :location
  end

  def as_json(*)
    super(except: %i[created_at updated_at deleted_at])
  end

  def set_end_and_duration
    return if start_date.blank?
    if duration_changed? && !end_date_changed?
      self.end_date = start_date + duration.day
    elsif !duration_changed? && end_date_changed?
      self.duration = (end_date - start_date).to_i
    end
  end
end
