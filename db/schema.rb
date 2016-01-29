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

ActiveRecord::Schema.define(version: 20160125152709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.decimal  "balance",     precision: 16, scale: 2
    t.integer  "stake"
    t.decimal  "stake_ratio"
    t.integer  "tipster_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "order_id"
  end

  add_index "accounts", ["order_id"], name: "index_accounts_on_order_id", using: :btree
  add_index "accounts", ["tipster_id"], name: "index_accounts_on_tipster_id", using: :btree

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "viewed",         default: false
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "badges_sashes", force: :cascade do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id", using: :btree
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id", using: :btree
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id", using: :btree

  create_table "comfy_blog_comments", force: :cascade do |t|
    t.integer  "post_id",                      null: false
    t.string   "author",                       null: false
    t.string   "email",                        null: false
    t.text     "content"
    t.boolean  "is_published", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_blog_comments", ["post_id", "created_at"], name: "index_comfy_blog_comments_on_post_id_and_created_at", using: :btree
  add_index "comfy_blog_comments", ["post_id", "is_published", "created_at"], name: "index_blog_comments_on_post_published_created", using: :btree

  create_table "comfy_blog_posts", force: :cascade do |t|
    t.integer  "blog_id",                                  null: false
    t.string   "title",                                    null: false
    t.string   "slug",                                     null: false
    t.text     "content"
    t.string   "excerpt",      limit: 1024
    t.string   "author"
    t.integer  "year",                                     null: false
    t.integer  "month",        limit: 2,                   null: false
    t.boolean  "is_published",              default: true, null: false
    t.datetime "published_at",                             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_blog_posts", ["created_at"], name: "index_comfy_blog_posts_on_created_at", using: :btree
  add_index "comfy_blog_posts", ["is_published", "created_at"], name: "index_comfy_blog_posts_on_is_published_and_created_at", using: :btree
  add_index "comfy_blog_posts", ["is_published", "year", "month", "slug"], name: "index_blog_posts_on_published_year_month_slug", using: :btree

  create_table "comfy_blogs", force: :cascade do |t|
    t.integer "site_id",                             null: false
    t.string  "label",                               null: false
    t.string  "identifier",                          null: false
    t.string  "app_layout",  default: "application", null: false
    t.string  "path"
    t.text    "description"
  end

  add_index "comfy_blogs", ["identifier"], name: "index_comfy_blogs_on_identifier", using: :btree
  add_index "comfy_blogs", ["site_id", "path"], name: "index_comfy_blogs_on_site_id_and_path", using: :btree

  create_table "comfy_cms_blocks", force: :cascade do |t|
    t.string   "identifier",     null: false
    t.text     "content"
    t.integer  "blockable_id"
    t.string   "blockable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_blocks", ["blockable_id", "blockable_type"], name: "index_comfy_cms_blocks_on_blockable_id_and_blockable_type", using: :btree
  add_index "comfy_cms_blocks", ["identifier"], name: "index_comfy_cms_blocks_on_identifier", using: :btree

  create_table "comfy_cms_categories", force: :cascade do |t|
    t.integer "site_id",          null: false
    t.string  "label",            null: false
    t.string  "categorized_type", null: false
  end

  add_index "comfy_cms_categories", ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_cat_type_and_label", unique: true, using: :btree

  create_table "comfy_cms_categorizations", force: :cascade do |t|
    t.integer "category_id",      null: false
    t.string  "categorized_type", null: false
    t.integer "categorized_id",   null: false
  end

  add_index "comfy_cms_categorizations", ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true, using: :btree

  create_table "comfy_cms_files", force: :cascade do |t|
    t.integer  "site_id",                                    null: false
    t.integer  "block_id"
    t.string   "label",                                      null: false
    t.string   "file_file_name",                             null: false
    t.string   "file_content_type",                          null: false
    t.integer  "file_file_size",                             null: false
    t.string   "description",       limit: 2048
    t.integer  "position",                       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_files", ["site_id", "block_id"], name: "index_comfy_cms_files_on_site_id_and_block_id", using: :btree
  add_index "comfy_cms_files", ["site_id", "file_file_name"], name: "index_comfy_cms_files_on_site_id_and_file_file_name", using: :btree
  add_index "comfy_cms_files", ["site_id", "label"], name: "index_comfy_cms_files_on_site_id_and_label", using: :btree
  add_index "comfy_cms_files", ["site_id", "position"], name: "index_comfy_cms_files_on_site_id_and_position", using: :btree

  create_table "comfy_cms_layouts", force: :cascade do |t|
    t.integer  "site_id",                    null: false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                      null: false
    t.string   "identifier",                 null: false
    t.text     "content"
    t.text     "css"
    t.text     "js"
    t.integer  "position",   default: 0,     null: false
    t.boolean  "is_shared",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_layouts", ["parent_id", "position"], name: "index_comfy_cms_layouts_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_layouts", ["site_id", "identifier"], name: "index_comfy_cms_layouts_on_site_id_and_identifier", unique: true, using: :btree

  create_table "comfy_cms_pages", force: :cascade do |t|
    t.integer  "site_id",                        null: false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                          null: false
    t.string   "slug"
    t.string   "full_path",                      null: false
    t.text     "content_cache"
    t.integer  "position",       default: 0,     null: false
    t.integer  "children_count", default: 0,     null: false
    t.boolean  "is_published",   default: true,  null: false
    t.boolean  "is_shared",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_pages", ["parent_id", "position"], name: "index_comfy_cms_pages_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_pages", ["site_id", "full_path"], name: "index_comfy_cms_pages_on_site_id_and_full_path", using: :btree

  create_table "comfy_cms_revisions", force: :cascade do |t|
    t.string   "record_type", null: false
    t.integer  "record_id",   null: false
    t.text     "data"
    t.datetime "created_at"
  end

  add_index "comfy_cms_revisions", ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_rtype_and_rid_and_created_at", using: :btree

  create_table "comfy_cms_sites", force: :cascade do |t|
    t.string  "label",                       null: false
    t.string  "identifier",                  null: false
    t.string  "hostname",                    null: false
    t.string  "path"
    t.string  "locale",      default: "en",  null: false
    t.boolean "is_mirrored", default: false, null: false
  end

  add_index "comfy_cms_sites", ["hostname"], name: "index_comfy_cms_sites_on_hostname", using: :btree
  add_index "comfy_cms_sites", ["is_mirrored"], name: "index_comfy_cms_sites_on_is_mirrored", using: :btree

  create_table "comfy_cms_snippets", force: :cascade do |t|
    t.integer  "site_id",                    null: false
    t.string   "label",                      null: false
    t.string   "identifier",                 null: false
    t.text     "content"
    t.integer  "position",   default: 0,     null: false
    t.boolean  "is_shared",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_snippets", ["site_id", "identifier"], name: "index_comfy_cms_snippets_on_site_id_and_identifier", unique: true, using: :btree
  add_index "comfy_cms_snippets", ["site_id", "position"], name: "index_comfy_cms_snippets_on_site_id_and_position", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "followers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "followers", ["email"], name: "index_followers_on_email", unique: true, using: :btree
  add_index "followers", ["reset_password_token"], name: "index_followers_on_reset_password_token", unique: true, using: :btree

  create_table "follows", force: :cascade do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "leagues", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "leagues", ["country_id"], name: "index_leagues_on_country_id", using: :btree

  create_table "matches", force: :cascade do |t|
    t.string   "matchid"
    t.string   "alternate_id"
    t.string   "home_team"
    t.string   "away_team"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "league_id"
    t.string   "static_id"
    t.datetime "date"
  end

  add_index "matches", ["league_id"], name: "index_matches_on_league_id", using: :btree

  create_table "merit_actions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.text     "target_data"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: :cascade do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: :cascade do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: :cascade do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "monologue_posts", force: :cascade do |t|
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.datetime "published_at"
  end

  add_index "monologue_posts", ["url"], name: "index_monologue_posts_on_url", unique: true, using: :btree

  create_table "monologue_taggings", force: :cascade do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  add_index "monologue_taggings", ["post_id"], name: "index_monologue_taggings_on_post_id", using: :btree
  add_index "monologue_taggings", ["tag_id"], name: "index_monologue_taggings_on_tag_id", using: :btree

  create_table "monologue_tags", force: :cascade do |t|
    t.string "name"
  end

  add_index "monologue_tags", ["name"], name: "index_monologue_tags_on_name", using: :btree

  create_table "monologue_users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "odds", force: :cascade do |t|
    t.string   "homevalue"
    t.string   "awayvalue"
    t.decimal  "homewin"
    t.decimal  "awaywin"
    t.decimal  "draw"
    t.string   "total"
    t.decimal  "under"
    t.decimal  "over"
    t.integer  "match_id"
    t.integer  "odds_type_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "odds", ["match_id"], name: "index_odds_on_match_id", using: :btree
  add_index "odds", ["odds_type_id"], name: "index_odds_on_odds_type_id", using: :btree

  create_table "odds_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "stake",             precision: 16, scale: 3
    t.decimal  "winnings",          precision: 16, scale: 3
    t.string   "status"
    t.decimal  "possible_winnings", precision: 16, scale: 3
    t.integer  "tipster_id"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.boolean  "handler",                                    default: false
  end

  add_index "orders", ["tipster_id"], name: "index_orders_on_tipster_id", using: :btree

  create_table "picks", force: :cascade do |t|
    t.string   "matchid"
    t.decimal  "odds",       precision: 12, scale: 3
    t.string   "status"
    t.string   "team"
    t.string   "pickstatus"
    t.string   "bettype"
    t.string   "bet"
    t.integer  "match_id"
    t.integer  "tipster_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "order_id"
    t.integer  "slip_id"
    t.string   "total"
    t.decimal  "realodds"
  end

  add_index "picks", ["match_id"], name: "index_picks_on_match_id", using: :btree
  add_index "picks", ["order_id"], name: "index_picks_on_order_id", using: :btree
  add_index "picks", ["slip_id"], name: "index_picks_on_slip_id", using: :btree
  add_index "picks", ["tipster_id"], name: "index_picks_on_tipster_id", using: :btree

  create_table "rankings", force: :cascade do |t|
    t.decimal  "rr",               precision: 7, scale: 4, default: 0.0
    t.integer  "tipster_id"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.decimal  "growth",           precision: 7, scale: 4, default: 0.0
    t.decimal  "score",            precision: 7, scale: 4, default: 0.0
    t.decimal  "mt_growth",        precision: 6, scale: 4
    t.decimal  "recent_growth",    precision: 6, scale: 4
    t.decimal  "asr",              precision: 6, scale: 4
    t.decimal  "rasr",             precision: 6, scale: 4
    t.decimal  "betslip_points",   precision: 6, scale: 4
    t.decimal  "frequency_points", precision: 6, scale: 4
    t.decimal  "recency",          precision: 6, scale: 4
    t.decimal  "follower_points",  precision: 6, scale: 4
  end

  add_index "rankings", ["tipster_id"], name: "index_rankings_on_tipster_id", using: :btree

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: :cascade do |t|
    t.string   "status"
    t.integer  "ht_home_goal"
    t.integer  "ht_away_goal"
    t.integer  "ft_home_goal"
    t.integer  "ft_away_goal"
    t.integer  "et_home_goal"
    t.integer  "et_away_goal"
    t.integer  "penalty_home"
    t.integer  "penalty_away"
    t.string   "first_goal"
    t.string   "last_goal"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "match_id"
  end

  add_index "scores", ["match_id"], name: "index_scores_on_match_id", using: :btree

  create_table "slips", force: :cascade do |t|
    t.integer  "stake"
    t.decimal  "winnings",          precision: 16, scale: 3
    t.decimal  "possible_winnings", precision: 16, scale: 3
    t.string   "status"
    t.integer  "tipster_id"
    t.integer  "account_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.datetime "expires_at"
  end

  add_index "slips", ["account_id"], name: "index_slips_on_account_id", using: :btree
  add_index "slips", ["tipster_id"], name: "index_slips_on_tipster_id", using: :btree

  create_table "tipsters", force: :cascade do |t|
    t.string   "email",                  default: "",  null: false
    t.string   "encrypted_password",     default: "",  null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "username"
    t.decimal  "score",                  default: 0.0
    t.integer  "sash_id"
    t.integer  "level",                  default: 0
  end

  add_index "tipsters", ["email"], name: "index_tipsters_on_email", unique: true, using: :btree
  add_index "tipsters", ["reset_password_token"], name: "index_tipsters_on_reset_password_token", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "accounts", "orders"
  add_foreign_key "accounts", "tipsters"
  add_foreign_key "leagues", "countries"
  add_foreign_key "matches", "leagues"
  add_foreign_key "odds", "matches"
  add_foreign_key "odds", "odds_types"
  add_foreign_key "orders", "tipsters"
  add_foreign_key "picks", "matches"
  add_foreign_key "picks", "orders"
  add_foreign_key "picks", "slips"
  add_foreign_key "picks", "tipsters"
  add_foreign_key "rankings", "tipsters"
  add_foreign_key "scores", "matches"
  add_foreign_key "slips", "accounts"
  add_foreign_key "slips", "tipsters"
end
