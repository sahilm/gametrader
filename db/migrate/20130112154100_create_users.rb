class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.index  :email, unique: true
      t.timestamps
    end
  end
end
