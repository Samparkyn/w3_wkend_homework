require('pg')

class Bookmark

  attr_reader(:title, :url, :genre, :description, :id)

  def initialize(options)
    @id = nil || options['id']
    @title = options['title']
    @url = options['url']
    @genre = options['genre']
    @description = options['description']
  end

  def save()
    sql = "INSERT INTO bookmarks (
    title,
    url,
    genre,
    description) VALUES ('#{@title}', '#{@url}', '#{@genre}', '#{@description}')"
    Bookmark.run_sql(sql)
  end

  def self.all()
    bookmarks = Bookmark.run_sql("SELECT * FROM bookmarks")
    result = bookmarks.map {|bookmark| Bookmark.new(bookmark)}
    return result
  end

  def self.find(id)
    bookmark = Bookmark.run_sql("SELECT * FROM bookmarks WHERE id=#{id}")
    result = Bookmark.new(bookmark[0])
    return result
  end

  def self.update(options)
    sql = "UPDATE bookmarks set
     title = '#{options['title']}',
     url = '#{options['url']}',
     genre = '#{options['genre']}',
     description = '#{options['description']}'
     WHERE id ='#{options['id']}'"
    Bookmark.run_sql(sql)
  end

  def self.destroy(id)
    Bookmark.run_sql("DELETE FROM bookmarks WHERE id=#{id}")
  end

  private

  def self.run_sql(sql)
    begin
      db = PG.connect({dbname: 'bookmark_list', host: 'localhost'})
      result = db.exec(sql)
      return result
    ensure #ensure that this always gets run (so in this case, always connect to the DataBase.)
      db.close
    end
  end

end