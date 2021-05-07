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

# createの!は冪等性がある前提で書いているこのcreateの段階でfalseという結果が返ってきた場合、処理を中止する→中止しないと下の99人のfakeユーザーを作成する処理が失敗することがわかっているのに実行され、長い待ち時間が発生してしまう。
# メソッドに!をつけるのは意図的に例外を発生させたい時に有効
# ※冪等性→同じ操作を何度繰り返しても、同じ結果が得られるという性質。