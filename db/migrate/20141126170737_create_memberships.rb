class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :user, null: false
      t.belongs_to :project, null: false
      t.string :role, null: false
      t.timestamps
      t.index [:user_id, :project_id], unique: true
    end
  end
end
