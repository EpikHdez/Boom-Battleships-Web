class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, index: true, unique: true, null: false
      t.string :password_digest, null: false
      t.string :picture, default: 'https://res.cloudinary.com/epikhdez/image/upload/v1523240311/no_image.png'
      t.integer :money, default: 500
      t.belongs_to :user_type, default: 2

      t.timestamps
    end
  end
end
