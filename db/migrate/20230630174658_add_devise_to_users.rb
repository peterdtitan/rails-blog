class AddDeviseToUsers < ActiveRecord::Migration[7.0]
  def change
    ## Database authenticatable
    add_column :users, :email, :string, null: false, default: ''
    add_column :users, :encrypted_password, :string, null: false, default: ''

    ## Recoverable
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime

    ## Rememberable
    add_column :users, :remember_created_at, :datetime

    ## Confirmable
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string

    # Set a default value for email column
    User.where(email: '').find_each do |user|
      user.update(email: "user-#{user.id}@example.com")
    end

    # Add unique index on email column
    add_index :users, :email, unique: true

    add_index :users, :reset_password_token, unique: true
  end
end
