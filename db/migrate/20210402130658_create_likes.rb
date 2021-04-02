class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shout, null: false, foreign_key: true

      t.timestamps
    end

    # Esto lo añado para asegurar que un like sea unico y no se de like a mas de un shout por vex por user
    add_index :likes, [:user_id, :shout_id], unique: true
  end
end
