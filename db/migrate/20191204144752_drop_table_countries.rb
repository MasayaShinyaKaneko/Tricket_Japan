class DropTableCountries < ActiveRecord::Migration[5.2]
  def change
  	drop_table :countries
  end
end
