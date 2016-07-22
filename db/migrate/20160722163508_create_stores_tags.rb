class CreateStoresTags < ActiveRecord::Migration
  def change
    create_table(:stores_tags) do |t|
      t.column(:store_id, :integer)
      t.column(:tag_id, :integer)
    end
  end
end
