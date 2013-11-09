class Event < ActiveRecord::Base
  include SocialStream::Models::Object

  scheduler

  belongs_to :room
  belongs_to  :course
  has_many  :payments
  has_one :bigbluebutton_room, :as => :owner, :dependent => :destroy
  after_update :update_bbb_room
  after_create :create_bbb_room

  validates_presence_of :course_id

  validate :room_belongs_to_receiver

  define_index do
    activity_object_index
  end

  def to_json(options = {})
    if recurrence
      st = options[:start].try(:to_date)
      en = (options[:end] || end_at.end_of_month + 7.days).to_date

      recurrence.events(:starts => st, :until  => en).map do |d|

        start_diff = d - start_at.to_date
        end_diff   = d - end_at.to_date

        build_json start_at.advance(:days => start_diff),
                   end_at.advance(:days => end_diff)
      end
    else
      build_json 
    end
  end

  def poster
    @poster ||=
      main_document ||
      build_poster
  end

  protected

  def build_json(start_time = start_at, end_time = end_at)
      {
        :id => id,
        :title => title,
        :start => start_time,
        :end => end_time,
        :allDay => all_day?,
        :roomId => room_id
      }

  end

  def build_poster
    Document.new(add_holder_event_id: id,
                 owner_id: owner_id)
  end


  private

  def room_belongs_to_receiver
    return if room_id.blank?

    unless owner.room_ids.include?(room_id)
      errors.add(:room_id, :invalid)
    end
  end

  def update_bbb_room
    bigbluebutton_room.update_attributes(:param => self.permalink,
                                         :name => self.permalink,
                                         :private => !self.public)
  end

  def create_bbb_room
    create_bigbluebutton_room(:owner => self,
                              :server => BigbluebuttonServer.first,
                              :param => self.permalink,
                              :name => self.permalink,
                              :private => !self.public,
                              :moderator_password => self._moderator_password || SecureRandom.hex(4),
                              :attendee_password => self._attendee_password || SecureRandom.hex(4),
                              :logout_url => "/feedback/webconf/")
  end

end
