class CreateEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_table :episodes do |t|
      t.string :title
      t.string :slug
      t.string :audio_url
      t.string :published_date
      t.string :author
      t.string :image
      t.string :guid
      t.belongs_to :podcast, null: false, foreign_key: true
      
      
      t.timestamps
    end
    
    add_index :episodes, :guid, unique: true
  end
end
