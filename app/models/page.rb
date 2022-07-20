class Page < ActiveResource::Base
  include MainFormatApiResponse
  include MainActiveResourceConfig

  has_many :images
  belongs_to :page_collection

  def self.new_with_project_defaults(attributes={})
    page = Page.new({
      project_id: nil,
      page_collection_id: nil,
      published_at: nil,
      featured_at: nil,
      featured: false,
      name: "",
      slug: "",
    }.merge(attributes))
    page
  end

  def self.new_with_scholar_defaults(attributes={})
    page_collection_id = PageCollection.where(slug: 'scholars').first.id
    page = Page.new({
      person_uid: nil,
      send_invitation: false,
      page_collection_id: page_collection_id,
      send_reminder: false,
      featured: false,
      featured_at: nil,
      blacklisted: false,
      invited_at: nil,
      invitable: false,
      reminded_at: nil,
      accepted_at: nil,
      slug: ""
    }.merge(attributes))
    page
  end

  def save
    self.prefix_options[:page] = self.attributes
    super
  end

  def images
    Image.find(:all, params: {page_id: self.id})
  end

  def published?
    published_at.present?
  end

  def published_date
    DateTime.parse(published_at).in_time_zone(Rails.application.config.time_zone) if published_at.present?
  end

  def featured?
    featured_at.present?
  end

  def featured_date
    DateTime.parse(featured_at).in_time_zone(Rails.application.config.time_zone) if featured_at.present?
  end

  def self.for_person(person_uid)
    person_uid = person_uid.uid if person_uid.respond_to?(:uid)
    where(person_uid: person_uid).first
  end

  def new_record?
    id.nil?
  end

  def awarded?
    awarded_at.present?
  end

  def created_date
    DateTime.parse(created_at) if created_at.present?
  end

  def updated_date
    DateTime.parse(updated_at) if updated_at.present?
  end

  def invite!
    self.class.post("#{self.id}/invite")
  end

  def invited?
    invited_at.present?
  end

  def invitable?
    awarded?
  end

  def inviting?
    awarded? && !invited?
  end

  def invited_date
    DateTime.parse(invited_at) if invited_at.present?
  end


  def remind!
    self.class.post("#{self.id}/remind")
  end

  def reminded?
    reminded_at.present?
  end

  def reminded_date
    DateTime.parse(reminded_at) if reminded_at.present?
  end


  def accepted?
    accepted_at.present?
  end

  def accepted_date
    DateTime.parse(accepted_at).in_time_zone(Rails.application.config.time_zone) if accepted_at.present?
  end


  # Reinvitations are sent when an existing scholar receives a new award.
  #
  def reinvited?
    invited? && accepted? && invited_at > accepted_at
  end

  def reinviting?
    accepted? && awarded? && awarded_at > accepted_at
  end

  def published_since_invitation?
    published? && invited? && published_at > invited_at
  end

  def out_of_date?
    published? && invited? && published_at < awarded_at
  end

  def publication_status
    if published_at.present?
      if !awarded_at.present? || DateTime.parse(published_at) > DateTime.parse(awarded_at)
        "published"
      else
        "outofdate"
      end
    elsif accepted_at.present?
      "accepted"
    elsif reminded_at.present?
      "reminded"
    elsif invited_at.present?
      "invited"
    elsif !invitable?
      "uninvitable"
    else
      "uninvited"
    end
  end

    # Other reminders

    def remind_to_update!
      self.class.post("#{self.id}/rtu")
    end
  
    def reminded_to_update?
      rtu_at.present?
    end
  
    def rtu_date
      DateTime.parse(rtu_at).in_time_zone(Rails.application.config.time_zone) if rtu_at.present?
    end
  
    def remind_to_publish!
      self.class.post("#{self.id}/rtp")
    end
  
    def reminded_to_publish?
      rtp_at.present?
    end
  
    def rtp_date
      DateTime.parse(rtp_at).in_time_zone(Rails.application.config.time_zone) if rtp_at.present?
    end

end
