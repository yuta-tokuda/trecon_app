# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_16_012521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorite_notes", id: :serial, force: :cascade do |t|
    t.integer "note_id", null: false, comment: "ノートID"
    t.integer "user_id", null: false, comment: "ユーザーID"
    t.index ["note_id"], name: "index_favorite_notes_on_note_id"
    t.index ["user_id"], name: "index_favorite_notes_on_user_id"
  end

  create_table "notes", id: :serial, force: :cascade do |t|
    t.string "title", null: false, comment: "タイトル"
    t.string "content", null: false, comment: "内容"
    t.integer "created_by_user_id", comment: "登録者"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public_flag", default: true, null: false, comment: "公開フラグ"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "active_user_id", null: false, comment: "通知を送るユーザー"
    t.bigint "passive_user_id", comment: "通知を受けるユーザー"
    t.bigint "note_id", comment: "ノートID"
    t.bigint "comment_id", comment: "コメントID"
    t.string "kind", null: false, comment: "noteもしくはcomment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_user_id"], name: "index_notifications_on_active_user_id"
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["note_id"], name: "index_notifications_on_note_id"
    t.index ["passive_user_id"], name: "index_notifications_on_passive_user_id"
  end

  create_table "user_note_comments", force: :cascade do |t|
    t.bigint "editor_id", null: false, comment: "noteを投稿したユーザーID"
    t.bigint "reply_user_id", null: false, comment: "コメントしたユーザーID"
    t.bigint "note_id", null: false, comment: "ノートID"
    t.string "content", null: false, comment: "ノートに対してのコメント内容"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["editor_id"], name: "index_user_note_comments_on_editor_id"
    t.index ["note_id"], name: "index_user_note_comments_on_note_id"
    t.index ["reply_user_id"], name: "index_user_note_comments_on_reply_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_first", comment: "姓"
    t.string "name_last", comment: "名"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
