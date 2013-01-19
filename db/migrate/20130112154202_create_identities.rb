class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string     :provider
      t.string     :uid
      t.string     :image
      t.references :user, index: true
      t.index      [:uid, :provider], unique: true
      t.timestamps
    end
  end
end
