class CreatePodcasts < ActiveRecord::Migration[7.1]
  def change
    create_table :podcasts do |t|
      t.string :name
      t.string :slug
      t.jsonb :metadata
      t.string :public_feed
      t.string :image
      t.string :image_100
      t.string :guid

      t.timestamps
    end
    add_index :podcasts, :slug, unique: true
    add_index :podcasts, :guid, unique: true
  end
end
