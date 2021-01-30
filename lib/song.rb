class Song
    # extend Memorable::ClassMethods
    extend Concerns::Findable

attr_accessor :name
attr_reader :artist, :genre

@@all = []

    def initialize(name, artist = nil, genre= nil)
       @name = name
        self.artist = artist if artist
        self.genre = genre if genre
        save
    end

    def artist=(artist)
      @artist = artist
      artist.add_song(self)
    end

    def genre=(genre)
      @genre = genre
      genre.songs << self unless genre.songs.include?(self)
    end

    def save 
        self.class.all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all 
        self.all.clear
    end

    def self.create(name)
        song = new(name)
        song.save
        song
    end

   def self.new_from_filename(filename)
    # binding.pry
    parts = filename.split(" - ")
    song_name = parts[1]
    artist_name = parts[0]
    genre_name = parts[2].chomp(".mp3")
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    new(song_name, artist, genre)
   
   end  

   def self.create_from_filename(filename)
    new_from_filename(filename).tap {|s| s.save}
   end
    
  
end