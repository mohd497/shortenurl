module UrlShort

  HTTP_REGEX = /https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9]\.[^\s]{2,}/i

  CHARSETS = {
      alphanum: ('a'..'z').to_a + (0..9).to_a,
      alphanumcase: ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
  }

  mattr_accessor :charset
  self.charset = :alphanum

  def self.key_chars
    CHARSETS[charset]
  end

  def self.generate_key
    (0...5).map{ key_chars[rand(key_chars.size)] }.join
  end

  def self.expiration_time
    Date.today - 5.days
  end

  def self.is_valid? (url)
    url =~ HTTP_REGEX
  end

end