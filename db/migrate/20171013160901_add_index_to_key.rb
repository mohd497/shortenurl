class AddIndexToKey < ActiveRecord::Migration[5.1]
  def change
    add_index :shorten_urls, :unique_key, unique: true
  end
end
