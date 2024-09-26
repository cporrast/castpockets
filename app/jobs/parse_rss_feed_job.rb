class ParseRssFeedJob < ApplicationJob
  queue_as :default

  def perform(podcast_id, feed_url)
    xml = HTTParty.get(feed_url).body
    feed = Feedjira.parse(xml)
    
    feed.entries.each do |episode|
      episode_data = extract_episode_data(episode, podcast_id)
      CreateEpisodeFromRssJob.perform_later(podcast_id, episode_data)
    end
  end

  private

  def extract_episode_data(episode, podcast_id)
    image = if episode.respond_to?(:itunes_image) && episode.itunes_image.present?
      episode.itunes_image
    else
      Podcast.find_by(id: podcast_id)&.image
    end
    {
      title: episode.title,
      description: episode.summary || episode.content,
      audio_url: episode.enclosure_url,
      published_date: episode.published,
      guid: episode.entry_id,
      author: episode.respond_to?(:itunes_author) ? episode.itunes_author : nil,
      image: episode.respond_to?(:itunes_image) && episode.itunes_image.present? ? episode.itunes_image : Podcast.find_by(id: podcast_id)&.image
    }
  end
end

# duration: episode.respond_to?(:itunes_duration) ? episode.itunes_duration : nil,