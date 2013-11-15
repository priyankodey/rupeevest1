class CreateAnalyses < ActiveRecord::Migration
  def change
    create_table :analyses do |t|
      t.string :type
      t.string :name
      t.float :goalamount
      t.integer :timeperiod
      t.float :initialamount
      t.float :periodicamount
      t.integer :periodicity
      t.string :yield
      t.string :creditrating
      t.integer :generalrisk
      t.integer :tenuregovt
      t.integer :tenurefixed

      t.timestamps
    end
  end
end
