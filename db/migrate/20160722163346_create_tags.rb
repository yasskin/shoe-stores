class CreateTags < ActiveRecord::Migration
  def change
    create_table(:tags) do |t|
      t.column(:category, :string)

      t.timestamps()
    end
  end
end
