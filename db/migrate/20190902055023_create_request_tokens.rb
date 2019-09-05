class CreateRequestTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :request_tokens do |t|
      t.references :user, foreign_key: true, null: false, comment: 'ユーザーID'
      t.string :token,                       null: false, comment: '認証トークン'

      t.timestamps
    end
  end
end
