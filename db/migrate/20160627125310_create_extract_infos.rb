class CreateExtractInfos < ActiveRecord::Migration
  def change
    create_table :extract_infos do |t|
      t.string :email
      t.string :artist_name
      t.string :artist_genre

      t.timestamps null: false
    end
  end
end
