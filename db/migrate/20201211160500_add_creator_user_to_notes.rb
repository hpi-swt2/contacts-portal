class AddCreatorUserToNotes < ActiveRecord::Migration[6.0]
  def change
    Note.connection.execute('DELETE FROM notes')
    add_reference :notes, :creator_user, null: false, foreign_key: { to_table: :users }
  end
end
