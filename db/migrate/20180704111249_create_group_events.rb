class CreateGroupEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :group_events do |t|
      t.string :name
      t.string :description
      t.string :location
      t.date :start_date
      t.date :end_date
      t.integer :duration
      t.datetime :deleted_at
      t.boolean :published, default: false
      t.timestamps
    end
  end
end
