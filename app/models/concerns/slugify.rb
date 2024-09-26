#
module Slugify
  extend ActiveSupport::Concern

  included do
    before_validation :generate_or_preserve_slug
    validates :slug, presence: true, uniqueness: true
  end

  class_methods do
    def slugify_attribute(attribute)
      @slugify_attribute = attribute
    end

    def get_slugify_attribute
      @slugify_attribute
    end
  end

  def generate_or_preserve_slug
    attribute = self.class.get_slugify_attribute
    value = send(attribute)

    if slug.blank? || slug_changed?
      self.slug = slugify(value)
      ensure_unique_slug
    end
  end

  def slugify(field_value)
    field_value.downcase.strip.gsub(' ', '-').gsub('&','and').gsub(/[^\w-]/, '')
  end

  def ensure_unique_slug
    base_slug = self.slug
    counter = 2
    while self.class.exists?(slug: self.slug)
      self.slug = "#{base_slug}-#{counter}"
      counter += 1
    end
  end
end