class CreateResidents < ActiveRecord::Migration[7.0]
  def change
    create_table :residents do |t|
      t.string :full_name
      t.string :cpf
      t.string :cns
      t.string :email
      t.date :birth_date
      t.string :phone
      t.string :photo
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
