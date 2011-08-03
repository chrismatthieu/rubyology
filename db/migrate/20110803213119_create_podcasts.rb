class CreatePodcasts < ActiveRecord::Migration
  def change
    create_table :podcasts do |t|
      t.string :podname
      t.text :poddesc
      t.string :podurl

      t.timestamps
    end
  end
end
