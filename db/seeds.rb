# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true,
  activated: true,
  activated_at: Time.zone.now)
  
# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
  end

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

# 以下のリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# サンプルユーザーをもう1人（テスト用）
User.create!(name:  "Test User",
  email: "example@testuser.com",
  password: "hogefuga",
  password_confirmation: "hogefuga",
  activated: true,
  activated_at: Time.zone.now)

# createの!は冪等性がある前提で書いているこのcreateの段階でfalseという結果が返ってきた場合、処理を中止する→中止しないと下の99人のfakeユーザーを作成する処理が失敗することがわかっているのに実行され、長い待ち時間が発生してしまう。
# メソッドに!をつけるのは意図的に例外を発生させたい時に有効
# ※冪等性→同じ操作を何度繰り返しても、同じ結果が得られるという性質。