class User < Sequel::Model
  one_to_many :posts
end
class Image < Sequel::Model

end
class Video < Sequel::Model

end
class Post < Sequel::Model
  many_to_one :users
end
