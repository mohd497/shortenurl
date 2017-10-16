class CreateShortenUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :shorten_urls do |t|
      t.text :url
      t.string :unique_key

      t.timestamps
    end
  end
end
