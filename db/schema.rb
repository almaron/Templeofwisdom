# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150519150217) do

  create_table "admin_configs", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment"
  end

  add_index "admin_configs", ["name"], name: "index_admin_configs_on_name", unique: true, using: :btree

  create_table "authentications", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", unique: true, using: :btree

  create_table "blog_comments", force: true do |t|
    t.integer  "blog_post_id", null: false
    t.text     "comment"
    t.integer  "user_id"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_posts", force: true do |t|
    t.string   "head"
    t.text     "text"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "char_avatars", force: true do |t|
    t.integer  "char_id",                   null: false
    t.string   "image"
    t.boolean  "default",    default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "char_avatars", ["char_id"], name: "index_char_avatars_on_char_id", using: :btree

  create_table "char_delegations", force: true do |t|
    t.integer  "char_id",                null: false
    t.integer  "user_id",                null: false
    t.date     "ending"
    t.integer  "owner",      default: 0
    t.integer  "default",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "char_delegations", ["user_id"], name: "index_char_delegations_on_user_id", using: :btree

  create_table "char_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "char_profiles", force: true do |t|
    t.integer  "char_id",                null: false
    t.string   "birth_date"
    t.integer  "age"
    t.integer  "season_id"
    t.string   "place"
    t.string   "beast"
    t.text     "phisics"
    t.text     "bio"
    t.text     "look"
    t.text     "character"
    t.text     "items"
    t.string   "person"
    t.text     "comment"
    t.integer  "points",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "other"
  end

  create_table "char_role_skills", force: true do |t|
    t.integer  "char_role_id"
    t.integer  "skill_id"
    t.integer  "done",         default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "char_roles", force: true do |t|
    t.integer  "role_id"
    t.integer  "char_id"
    t.integer  "points",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "char_skills", force: true do |t|
    t.integer  "char_id",                null: false
    t.integer  "skill_id",               null: false
    t.integer  "level_id",   default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "char_skills", ["char_id"], name: "index_char_skills_on_char_id", using: :btree

  create_table "char_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chars", force: true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.string   "status_line"
    t.integer  "status_id",        default: 2
    t.integer  "open_player"
    t.integer  "profile_topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "signature",        default: ""
  end

  create_table "forum_posts", force: true do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "char_id"
    t.integer  "user_id"
    t.string   "ip"
    t.text     "comment"
    t.string   "commenter"
    t.datetime "commented_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "avatar_id"
  end

  create_table "forum_topics", force: true do |t|
    t.integer  "forum_id"
    t.string   "poster_name"
    t.integer  "closed",              default: 0
    t.integer  "hidden",              default: 0
    t.integer  "last_post_id"
    t.datetime "last_post_at"
    t.string   "last_post_char_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "head",                            null: false
    t.integer  "posts_count",         default: 0
    t.integer  "char_id"
    t.integer  "last_post_char_id"
  end

  create_table "forums", force: true do |t|
    t.string   "name",                            null: false
    t.string   "ancestry"
    t.string   "image"
    t.text     "description"
    t.integer  "technical",           default: 0
    t.integer  "hidden",              default: 0
    t.integer  "last_post_id"
    t.integer  "last_post_topic_id"
    t.datetime "last_post_at"
    t.string   "last_post_char_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_order",          default: 0
    t.integer  "topics_count",        default: 0
    t.integer  "posts_count",         default: 0
    t.integer  "is_category",         default: 0
    t.integer  "last_post_char_id"
  end

  create_table "guest_posts", force: true do |t|
    t.string   "head"
    t.text     "content"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user",       null: false
    t.string   "ip",         null: false
  end

  create_table "journal_blocks", force: true do |t|
    t.integer  "page_id"
    t.text     "content"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journal_blocks", ["page_id"], name: "index_journal_blocks_on_page_id", using: :btree

  create_table "journal_images", force: true do |t|
    t.integer  "page_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journal_images", ["page_id"], name: "index_journal_images_on_page_id", using: :btree

  create_table "journal_page_tags", force: true do |t|
    t.integer  "page_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journal_page_tags", ["page_id"], name: "index_journal_page_tags_on_page_id", using: :btree
  add_index "journal_page_tags", ["tag_id"], name: "index_journal_page_tags_on_tag_id", using: :btree

  create_table "journal_pages", force: true do |t|
    t.integer  "journal_id"
    t.string   "head"
    t.string   "page_type",    default: "article"
    t.integer  "sort_index",   default: 0
    t.text     "content_text"
    t.string   "content_line", default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journal_pages", ["journal_id", "sort_index"], name: "index_journal_pages_on_journal_id_and_sort_index", using: :btree

  create_table "journal_tags", force: true do |t|
    t.string "name"
  end

  create_table "journals", force: true do |t|
    t.string   "head"
    t.string   "cover"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",   default: false
    t.string   "description"
  end

  create_table "levels", force: true do |t|
    t.string  "name",                   null: false
    t.integer "phisic_roles"
    t.integer "magic_roles"
    t.integer "phisic_points"
    t.integer "phisic_points_discount"
    t.integer "magic_points"
    t.integer "magic_points_discount"
  end

  create_table "log_types", force: true do |t|
    t.string   "name"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_receivers", force: true do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.integer  "char_id"
    t.integer  "read",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.integer  "char_id"
    t.string   "head"
    t.text     "text"
    t.integer  "deleted",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "receive_list"
  end

  create_table "news", force: true do |t|
    t.string   "author"
    t.string   "head"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.string   "head"
    t.text     "text"
    t.integer  "read",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority",   default: 3
  end

  create_table "pages", force: true do |t|
    t.string   "head"
    t.string   "page_title"
    t.string   "page_alias"
    t.string   "ancestry"
    t.text     "content"
    t.string   "partial"
    t.string   "partial_params"
    t.integer  "published",        default: 0
    t.integer  "hide_menu",        default: 0
    t.integer  "sort_order",       default: 0
    t.string   "meta_title"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["ancestry"], name: "index_pages_on_ancestry", using: :btree
  add_index "pages", ["page_alias"], name: "index_pages_on_page_alias", unique: true, using: :btree

  create_table "role_apps", force: true do |t|
    t.string   "head"
    t.text     "paths"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
  end

  create_table "roles", force: true do |t|
    t.string   "head"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "topic_ids"
  end

  create_table "season_times", force: true do |t|
    t.integer  "season_id"
    t.integer  "begins"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "season_times", ["begins"], name: "index_season_times_on_begins", using: :btree

  create_table "seasons", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "skill_levels", force: true do |t|
    t.integer  "skill_id"
    t.integer  "level_id"
    t.text     "description"
    t.text     "techniques"
    t.text     "advice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skill_levels", ["skill_id"], name: "index_skill_levels_on_skill_id", using: :btree

  create_table "skill_requests", force: true do |t|
    t.integer  "user_id"
    t.integer  "char_id"
    t.integer  "skill_id"
    t.integer  "level_id"
    t.integer  "forum_post_id"
    t.integer  "points"
    t.integer  "roles"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skill_requests", ["char_id"], name: "index_skill_requests_on_char_id", using: :btree

  create_table "skills", force: true do |t|
    t.string   "name",                           null: false
    t.text     "description"
    t.string   "skill_type",  default: "phisic"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "advice"
    t.string   "discount",    default: ""
  end

  add_index "skills", ["skill_type"], name: "index_skills_on_skill_type", using: :btree

  create_table "user_ips", force: true do |t|
    t.integer "user_id"
    t.string  "ip"
  end

  add_index "user_ips", ["ip"], name: "index_user_ips_on_ip", using: :btree
  add_index "user_ips", ["user_id"], name: "index_user_ips_on_user_id", using: :btree

  create_table "user_profiles", force: true do |t|
    t.integer  "user_id",                  null: false
    t.string   "full_name"
    t.date     "birth_date"
    t.string   "icq"
    t.string   "skype"
    t.string   "contacts"
    t.integer  "viewcontacts", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",                                             null: false
    t.string   "email",                                            null: false
    t.string   "group",                           default: "user"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "last_login_from_ip_address"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
  end

  add_index "users", ["activation_token"], name: "index_users_on_activation_token", using: :btree
  add_index "users", ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
