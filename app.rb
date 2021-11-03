require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'sinatra/activerecord' # 追加
require './models/user.rb' # 追加

# 2. 簡単なレスポンスを返してください
get '/' do
  "hello world"
end

# 3. ちょっと装飾したレスポンスを返してください
get '/html' do
  "<h1>hello world!</h1>"
end

# 4. ちゃんとHTMLの形式でレスポンスを返してください
get '/html-completed' do
  "<heml><head></head><body><h1>hello world!</h1></body></html>"
end

# 5. erbファイルを使ってレスポンスを返してください
get '/html-completed-erb' do
  erb :html_completed
end

# 6. link_toメソッドを自前で作ってみてください
get '/learn-link-to' do
  erb :learn_link_to
end

def link_to(text, url)
  "<a href=#{url}>#{text}</a>"
end

# 7. レイアウトファイルを作ってください
get '/learn-layout' do
  erb :learn_layout
end

# 8. データベースを導入してください
get '/users' do
  db = SQLite3::Database.new 'sample.db'
  rs = db.execute('select * from users;')
  @users_hash = rs.map do |row|
    { id: row[0], name: row[1] }
  end
  erb :'users/index'
end

# 9. ユーザーの新規作成機能を作ってください
get '/users/new' do
  erb :'users/new'
end

post '/users' do
  db = SQLite3::Database.new 'sample.db'
  sql = 'insert into users(name) values(?);'
  stmt = db.prepare(sql)
  stmt.bind_params(params[:name])
  stmt.execute

  redirect to('/users')
end

# 10. ActiveRecordを導入してユーザー一覧画面を表示してください
get '/ar/users' do
  @users = User.all
  erb :'ar/users/index'
end

# 11. ActiveRecordを使ってユーザー登録機能を作ってください
get '/ar/users/new' do
  @user = User.new
  erb :'ar/users/new'
end

post '/ar/users' do
  User.create(name: params[:name])
  redirect to('/ar/users')
end