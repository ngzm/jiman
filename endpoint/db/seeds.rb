# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Categories
Category.create!([
  { name: "ウェブサイト" },
  { name: "プログラム" },
  { name: "イラスト" },
  { name: "マンガ" },
  { name: "ゲーム" },
  { name: "写真" },
  { name: "動画" },
  { name: "小説" },
  { name: "美術" },
  { name: "手芸" },
  { name: "科学" },
  { name: "工作" },
  { name: "服飾デザイン" },
  { name: "工芸デザイン" },
  { name: "建築・大工" },
  { name: "生物・ペット" },
  { name: "その他" },
  { name: "子供の部" }
])

# Jimen
jiman1 = Jiman.create!({
  title: "Longlivenet",
  description: "ロングリブネットのウェブサイトです",
  url: "https://www.longlivenet.com/",
  image: "http://localhost:4000/test/IMG_0301.jpg",
  access: 120,
  star: 4.3
})
jiman2 = Jiman.create!({
  title: "テスト2",
  description: "テストその2です",
  url: "https://www.longlivenet.com/",
  image: "http://localhost:4000/test/IMG_0157.jpg",
  access: 43,
  star: 2.3
})
jiman3 = Jiman.create!({
  title: "タイトルテスト3",
  description: "ジマンのテストその3です",
  url: "https://www.longlivenet.com/",
  image: "http://localhost:4000/test/IMG_0791.jpg",
  access: 10,
  star: 3.1
})
jiman4 = Jiman.create!({
  title: "面白サイト",
  description: "楽しいサイトを作成しました！ぜひ見てください",
  url: "https://www.longlivenet.com/",
  image: "http://localhost:4000/test/IMG_0792.jpg"
})
jiman5 = Jiman.create!({
  title: "キタキタNo5",
  description: "キタキターお待ちかねでした！！",
  url: "https://www.longlivenet.com/",
  image: "http://localhost:4000/test/IMG_0893.jpg"
})

# リレーション設定
cate1 = Category.find_by({ name: 'ウェブサイト' })
cate2 = Category.find_by({ name: 'プログラム' })
jiman1.categories << cate1
jiman1.categories << cate2
jiman1.save!
jiman2.categories << cate1
jiman2.save!
jiman3.categories << cate1
jiman3.save!
jiman4.categories << cate1
jiman4.save!
jiman5.categories << cate1
jiman5.save!
