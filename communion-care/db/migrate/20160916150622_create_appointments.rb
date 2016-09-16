class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.string :location
      t.string :date_time
      t.belongs_to :provider, foreign_key: true
      t.belongs_to :customer, foreign_key: true

      t.timestamps
    end
  end
end
