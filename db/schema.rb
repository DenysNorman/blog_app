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

ActiveRecord::Schema.define(version: 20_161_205_125_648) do
  create_table 'comments', force: :cascade do |t|
    t.string   'body'
    t.integer  'user_id'
    t.integer  'post_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string   'ancestry'
    t.index ['ancestry'], name: 'index_comments_on_ancestry'
    t.index ['post_id'], name: 'index_comments_on_post_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'likes', force: :cascade do |t|
    t.boolean  'like'
    t.boolean  'dislike'
    t.integer  'post_id'
    t.integer  'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'posts', force: :cascade do |t|
    t.string   'title'
    t.text     'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer  'user_id'
    t.string   'image'
    t.string   'slug'
    t.index ['slug'], name: 'index_posts_on_slug'
  end

  create_table 'rs_evaluations', force: :cascade do |t|
    t.string   'reputation_name'
    t.string   'source_type'
    t.integer  'source_id'
    t.string   'target_type'
    t.integer  'target_id'
    t.float    'value', default: 0.0
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.text     'data'
    t.index %w(reputation_name source_id source_type target_id target_type), name: 'index_rs_evaluations_on_reputation_name_and_source_and_target', unique: true
    t.index ['reputation_name'], name: 'index_rs_evaluations_on_reputation_name'
    t.index %w(source_id source_type), name: 'index_rs_evaluations_on_source_id_and_source_type'
    t.index %w(target_id target_type), name: 'index_rs_evaluations_on_target_id_and_target_type'
  end

  create_table 'rs_reputation_messages', force: :cascade do |t|
    t.string   'sender_type'
    t.integer  'sender_id'
    t.integer  'receiver_id'
    t.float    'weight', default: 1.0
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index %w(receiver_id sender_id sender_type), name: 'index_rs_reputation_messages_on_receiver_id_and_sender', unique: true
    t.index ['receiver_id'], name: 'index_rs_reputation_messages_on_receiver_id'
    t.index %w(sender_id sender_type), name: 'index_rs_reputation_messages_on_sender_id_and_sender_type'
  end

  create_table 'rs_reputations', force: :cascade do |t|
    t.string   'reputation_name'
    t.float    'value', default: 0.0
    t.string   'aggregated_by'
    t.string   'target_type'
    t.integer  'target_id'
    t.boolean  'active', default: true
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.text     'data'
    t.index %w(reputation_name target_id target_type), name: 'index_rs_reputations_on_reputation_name_and_target', unique: true
    t.index ['reputation_name'], name: 'index_rs_reputations_on_reputation_name'
    t.index %w(target_id target_type), name: 'index_rs_reputations_on_target_id_and_target_type'
  end

  create_table 'users', force: :cascade do |t|
    t.string   'name'
    t.string   'email',                  default: '', null: false
    t.string   'encrypted_password',     default: '', null: false
    t.string   'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer  'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string   'current_sign_in_ip'
    t.string   'last_sign_in_ip'
    t.datetime 'created_at',                          null: false
    t.datetime 'updated_at',                          null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
