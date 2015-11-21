class Meeting < ActiveRecord::Base
  
  attr_accessor :ignore_non_accepted
  attr_accessor :num_alleys
  attr_accessor :playtime
  
  has_and_belongs_to_many :alleys
  
  scope :future, -> { where(["(meetings.start_time > ? OR meetings.end_time > ?)", Time.now-1.hour, Time.now]).order(:start_time) }
  
  validates :name, presence: true
  validates :phone, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  
  validate :check_availeble_alleys
  
  def check_availeble_alleys
    #conflicting_meetings = Meeting.where("meetings.start_time < ? and meetings.end_time < ?", self.end_time, self.start_time)
    #errors.add :time, 'kein freier Termin' unless conflicting_meetings.blank? #conflicting_meetings.map {|j| "Termine conflicts"}
    
    errors.add :end_time, "Die Reservierung muss mindestens 1 Stunde betragen." if ((self.end_time - self.start_time) / 1.hour) < 1
    
    conds = [[
      "meetings.start_time BETWEEN :start_time AND :end_time",
      "meetings.end_time BETWEEN :start_time AND :end_time",
      ":start_time BETWEEN meetings.start_time AND meetings.end_time",
      ":end_time BETWEEN meetings.start_time AND meetings.end_time"
    ].join(" OR "), {
      :start_time => self.start_time+1.second,
      :end_time => self.end_time-1.second
    }]
    
    # eigenes Meeting von Validierung ausschließen
    cond_meeting = self.new_record? ? nil : ["meetings.id != ?", self.id]
    
    # nur bestätigte Reservierungen überprüfen
    cond_accepted = self.ignore_non_accepted.to_i == 1 ? ["meetings.accepted = ?", true] : nil
    
    alleys = Meeting.select('alleys.id, alleys.name').joins(:alleys).where(conds).where(cond_meeting).where(cond_accepted)
    alley_ids = alleys.map(&:id)
    self.alleys.each do |alley|
      errors.add :time, "#{alley.name} ist belegt" if alley_ids.include? alley.id
    end
  end
  
  def foo start_time, hours, number_alleys
    end_time = start_time + hours.to_i.hours
    
    availeble_alleys = self.availeble_alleys(start_time, end_time)
    
    if availeble_alleys.count >= number_alleys
      availeble_alleys
    else
      false
    end
  end
  
  def availeble_alleys start_time, end_time
    conds = [[
      "meetings.start_time BETWEEN :start_time AND :end_time",
      "meetings.end_time BETWEEN :start_time AND :end_time",
      ":start_time BETWEEN meetings.start_time AND meetings.end_time",
      ":end_time BETWEEN meetings.start_time AND meetings.end_time"
    ].join(" OR "), {
      :start_time => start_time+1.second,
      :end_time => end_time-1.second
    }]
    
    # eigenes Meeting von Validierung ausschließen
    cond_2 = self.new_record? ? nil : ["meetings.id != ?", self.id]
    
    alley_ids = Meeting.select('alleys.id').joins(:alleys).where(conds).where(cond_2).map(&:id)
    Alley.where(alley_ids.blank? ? nil : ["alleys.id NOT IN (?)", alley_ids])
  end
end