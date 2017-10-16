class ShortenUrl < ApplicationRecord

  validate :check_url_validation

  after_validation :create_unique_key, :add_url_protocol

  # exclude records in which expiration time is greater then 5 days
  scope :unexpired, -> { where('created_at > ?', UrlShort.expiration_time) }


  # we'll check if provided url is valid or not
  def check_url_validation
    errors.add(:url, I18n.t('url_not_proper')) unless UrlShort.is_valid? (url)
  end

  # we'll rely on the DB to make sure the unique key is really unique.
  # if it isn't unique, the unique index will catch this and raise an error
  def create_unique_key
    begin
      self.unique_key = UrlShort.generate_key
    rescue ActiveRecord::RecordNotUnique
      if (count +=1) < 5
        retry
      else
        raise
      end
    end
  end

  # add protocol if not provided
  def add_url_protocol
    unless url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
      self.url = "http://#{self.url}"
    end
  end

  # fetch the complete and shortened url
  def self.fetch_with_key(key, request)
    complete_url = ShortenUrl.unexpired.where(unique_key: key).first
    if complete_url
      short_url = merge_url(complete_url.unique_key, request)
      { url: complete_url.url, shortened_url: short_url }
    else
      nil
    end
  end

  # merge key with base url
  def self.merge_url(key, request)
    request + '/' + key
  end

end
