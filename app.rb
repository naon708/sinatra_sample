require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

get '/' do
  "hello world"
end

get '/html' do
  "<h1>hello world!</h1>"
end

get '/html-completed' do
  "<heml><head></head><body><h1>hello world!</h1></body></html>"
end

get '/html-completed-erb' do
  erb :html_completed
end

get '/learn-link-to' do
  erb :learn_link_to
end

def link_to(text, url)
  "<a href=#{url}>#{text}</a>"
end

get '/learn-layout' do
  erb :learn_layout
end

get '/users' do
  db = SQLite3::Database.new 'sample.db'
  rs = db.execute('select * from users;')
  @users_hash = rs.map do |row|
    { id: row[0], name: row[1] }
  end
  erb :'users/index'
end
