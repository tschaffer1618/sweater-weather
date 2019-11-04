class CreateBackgroundImages < ActiveRecord::Migration[5.2]
  def change
    create_table :background_images do |t|
      t.references :location, foreign_key: true
      t.string :description
      t.string :alt_description
      t.string :raw_url
      t.string :full_url
      t.string :city

      t.timestamps
    end
  end
end
