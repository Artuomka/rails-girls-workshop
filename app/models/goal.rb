class Goal < ApplicationRecord
    
    scope :completed, -> { where(complete: true) }
    scope :incomplete, -> { where(complete: false) }
    
    validates :title,
              presence: true,
              length: { maximum: 80 }
  
    validates :description,
              presence: true,
              length: { maximum: 500 }
     
    validates :due_date,
              presence: true
  
    validate :due_date_cannot_be_in_the_past, :due_date_year_cannot_be_more_than_allowable, if: :due_date_changed?
  
    enum priority: { low: 0, medium: 1, high: 2 }

    private
  
    def due_date_cannot_be_in_the_past
      if due_date.present? && due_date < Time.zone.today
        errors.add(:due_date, 'cannot be earlier than today')
      end
    end
  
    def due_date_year_cannot_be_more_than_allowable
      if due_date.present? && due_date.to_date.year > 2100
        errors.add(:due_date, "a year cannot be more than 2100")
      end
    end
  end