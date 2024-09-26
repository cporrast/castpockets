class Podcast < ApplicationRecord
  include Slugify
  slugify_attribute :name
  
  has_many :episodes
end
