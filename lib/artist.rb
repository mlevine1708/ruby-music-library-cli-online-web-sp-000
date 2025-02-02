


class Artist
  extend Concerns::Findable

attr_accessor :name
attr_reader :song

@@all  = []

def initialize(name)
  @name = name
  @songs = []
end

def self.all
  @@all
end

def save
  self.class.all << self
end

def self.create(name)
  artist = new(name)
  artist.save
  artist
end

def self.destroy_all
  all.clear
end

def add_song(song)
  song.artist = self unless song.artist
  songs << song unless songs.include?(song)
end

def songs
  @songs
end

def genres
  songs.collect{ |s| s.genre }.uniq
end

def self.count
  @@all.size
end

def self.find_by_name(name)
  @@all.detect{|artist| artist.name == name}
  end
end
