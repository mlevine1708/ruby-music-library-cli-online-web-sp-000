


class Artist

attr_accessor :name, :song, :genre
extend Concerns::Findable


@@all  = []

def initialize(name)
  @name = name
  @songs = []
end

def self.all
  @@all
end

def save
  @@all << self
end

def self.create(artist)
  artist = self.new(name)
  artist.save
  artist
end

def self.destroy_all
  @@all.clear
end

def add_song(song)
  song.artist = self unless song.artist == self
  @songs << song unless @songs.include?(song)
end

def songs
  @songs
end

def genres
  @new_array = []
  @songs.each do |song|
    if @new_array.include?(song.genre)
      nil
    else
      @new_array << song.genre
    end
  end
  @new_array
end

def self.count
  @@all.size
end

def self.find_by_name(name)
  @@all.detect{|artist| artist.name == name}
  end
end
