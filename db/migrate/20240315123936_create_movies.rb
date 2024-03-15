class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :genre
      t.date :releaseDate
      t.string :language
      t.integer :rating

      t.timestamps
    end
  end
end
