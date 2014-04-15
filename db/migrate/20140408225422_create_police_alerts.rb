class CreatePoliceAlerts < ActiveRecord::Migration
  def change
    create_table :police_alerts do |t|
      t.string :hundred_block_location
      t.string :event_clearance_description
      t.string :event_clearance_date
      t.string :general_offense_number
      t.string :census_tract
      t.string :latitude
      t.string :longitude
      t.string :incident_location

      t.timestamps
    end
  end
end
