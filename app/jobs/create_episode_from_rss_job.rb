class CreateEpisodeFromRssJob < ApplicationJob
  queue_as :default

  def perform(podcast_id, episode_data)
    Episode.find_or_create_by(guid: episode_data[:guid]) do |e|
      e.title = episode_data[:title]
      e.description = episode_data[:description]
      e.audio_url = episode_data[:audio_url]
      e.published_date = episode_data[:published_date]
      e.author = episode_data[:author]
      e.image = episode_data[:image]
      e.podcast_id = podcast_id
    end
  end
end
