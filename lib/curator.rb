class Curator
  attr_reader :artists, :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photo)
    @photographs << Photograph.new(photo)
  end

  def add_artist(artist)
    @artists << Artist.new(artist)
  end

  def find_artist_by_id(id)
    @artists.detect {|artist| artist.id == id}
  end

  def find_photograph_by_id(id)
    @photographs.detect {|photograph| photograph.id == id}
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photograph|
      photograph.artist_id == artist.id
    end
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist|
      find_photographs_by_artist(artist).count > 1
    end
  end

  def photographs_taken_by_artist_from(country)
    @photographs.find_all do |photograph|
      find_artist_by_id(photograph.artist_id).country == country
    end
  end

  def load_photographs(file)
    #Out of time. Can't find the actual CSV files. So this is a guess.
    photo_substrings = IO.readlines(file)
    photo_substrings.each do |n|
      info_substrings = n.split(",")
      photo_data[:id] = info_substrings[0].chomp
      photo_data[:name] = info_substrings[1].chomp
      photo_data[:artist_id] = info_substrings[3].chomp
      photo_data[:year] = info_substrings[4].chomp
      add_photograph(photo_data)
    end
  end

  def load_artists(file)
    #Out of time. Can't find the actual CSV files. So this is a guess.
    artist_substrings = IO.readlines(file)
    artist_substrings.each do |n|
      info_substrings = n.split(",")
      artist_data[:id] = info_substrings[0].chomp
      artist_data[:name] = info_substrings[1].chomp
      artist_data[:born] = info_substrings[3].chomp
      artist_data[:died] = info_substrings[4].chomp
      artist_data[:country] = info_substrings[5].chomp
      add_artist(artist_data)
    end
  end

  def photographs_taken_between(range)
    @photographs.find_all do |photograph|
      range.include?(photograph.year)
    end
  end

  def artists_photographs_by_age(artist)
    photos_by_age = {}
    find_photographs_by_artist(artist).each do |photograph|
      artist_age = photograph.year.to_i - artist.born.to_i
      photos_by_age[artist_age] = photograph.name
    end
    photos_by_age
  end

end
