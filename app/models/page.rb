class Page < ActiveRecord::Base
  
  attr_accessible :title, :content, :published_on
  
  # Validations
  validates :title, :presence => true, :uniqueness => true  
  validates :content, :presence => true
  
  # Scopes
  scope :published,  lambda { {:conditions => [ 'published_on <= ? AND published_on IS NOT NULL', Time.now ] } }
  scope :unpublished, lambda { {:conditions => ['published_on > ? OR published_on IS NULL', Time.now ] }}
  
  def published
    published_on.present? and Time.now.utc > published_on
  end

  def publish
    self.published_on = Time.now
    self.save
    self
  end
  
  def as_json(options={})
    super(methods: :published)
  end

  def to_xml(options={})
    super(methods: :published)
  end

  def total_words
    count = title.split(/[^a-z|-]+/i).count
    count += content.split(/[^a-z|-]+/i).count
    count
  end
  
  
end
