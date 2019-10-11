class Song

attr_accessor :name, :artist, :genre
extend Concerns::Findable

@@all = []

def initialize(name, artist=nil, genre=nil)
  @name = name
  self.artist=(artist) if artist !=nil
  self.genre=(genre) if genre != nil
end


def self.all
  @@all
end

def find_by_name(name)
  @@all.detect do |song|
    song.name == name
  end
end

def find_or_create_by_name(name)
  self.find_by_name || self.create(name)
end

def save
  @@all << self
end

def self.create(song)
  song = self.new(name)
  song.save
  song
end

def self.destroy_all
  @@all.clear
end

def artist
  @artist
end

def genre
  @genre
end

def artist=(artist)
  @artist = artist
  artist.add_song(self)
end

def genre=(genre)
  @genre = genre
  genre.songs << self unless genre.songs.include?(self)
end

def self.new_from_filename(filename)
  array = filename.split(" - ")

  song_name = array[1]
  artist_name = array[0]
  genre_name = array[2].split(".mp3").join

  artist = Artist.find_or_create_by_name(artist_name)
  genre = Genre.find_or_create_by_name(genre_name)
  self.new(song_name, artist, genre)
end

def self.create_from_filename(filename)
  self.new_from_filename(filename).save
  end
end 
