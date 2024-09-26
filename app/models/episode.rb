class Episode < ApplicationRecord
  include Slugify
  slugify_attribute :title

  belongs_to :podcast
  has_rich_text :description
end
