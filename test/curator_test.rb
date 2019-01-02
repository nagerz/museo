require './lib/curator'
require './lib/photograph'
require './lib/artist'
require 'pry'
require 'minitest/autorun'
require 'minitest/pride'

class CuratorTest < Minitest::Test
  def setup
    @curator = Curator.new
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_has_initial_attributes
    assert_equal [], @curator.artists
    assert_equal [], @curator.photographs
  end

  def test_it_can_add_photos
    photo_1 = {
    id: "1",
    name: "Rue Mouffetard, Paris (Boy with Bottles)",
    artist_id: "1",
    year: "1954"
    }

    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }

    @curator.add_photograph(photo_1)
    @curator.add_photograph(photo_2)

    assert_instance_of Photograph, @curator.photographs.first
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)", @curator.photographs.first.name
  end

  def test_it_can_add_artists
    artist_1 = {
    id: "1",
    name: "Henri Cartier-Bresson",
    born: "1908",
    died: "2004",
    country: "France"
    }

    artist_2 = {
    id: "2",
    name: "Ansel Adams",
    born: "1902",
    died: "1984",
    country: "United States"
    }

    @curator.add_artist(artist_1)
    @curator.add_artist(artist_2)

    assert_instance_of Artist, @curator.artists.first
    assert_equal "Henri Cartier-Bresson", @curator.artists.first.name
  end

  def test_it_can_find_artist_by_id
    artist_1 = {
    id: "1",
    name: "Henri Cartier-Bresson",
    born: "1908",
    died: "2004",
    country: "France"
    }
    artist_2 = {
    id: "2",
    name: "Ansel Adams",
    born: "1902",
    died: "1984",
    country: "United States"
    }
    @curator.add_artist(artist_1)
    @curator.add_artist(artist_2)
    photo_1 = {
    id: "1",
    name: "Rue Mouffetard, Paris (Boy with Bottles)",
    artist_id: "1",
    year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    @curator.add_photograph(photo_1)
    @curator.add_photograph(photo_2)

    assert_instance_of Artist, @curator.find_artist_by_id("1")
    assert_equal "Henri Cartier-Bresson", @curator.find_artist_by_id("1").name
  end

  def test_it_can_find_photograph_by_id
    artist_1 = {
    id: "1",
    name: "Henri Cartier-Bresson",
    born: "1908",
    died: "2004",
    country: "France"
    }
    artist_2 = {
    id: "2",
    name: "Ansel Adams",
    born: "1902",
    died: "1984",
    country: "United States"
    }
    @curator.add_artist(artist_1)
    @curator.add_artist(artist_2)
    photo_1 = {
    id: "1",
    name: "Rue Mouffetard, Paris (Boy with Bottles)",
    artist_id: "1",
    year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    @curator.add_photograph(photo_1)
    @curator.add_photograph(photo_2)

    assert_instance_of Photograph, @curator.find_photograph_by_id("2")
    assert_equal "Moonrise, Hernandez", @curator.find_photograph_by_id("2").name
  end

  def test_it_can_find_photographs_by_artist
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }
    @curator.add_artist(artist_1)
    @curator.add_artist(artist_2)
    @curator.add_artist(artist_3)

    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    @curator.add_photograph(photo_1)
    @curator.add_photograph(photo_2)
    @curator.add_photograph(photo_3)
    @curator.add_photograph(photo_4)

    diane_arbus = @curator.find_artist_by_id("3")

    assert_equal 2, @curator.find_photographs_by_artist(diane_arbus).count
    assert_equal "Identical Twins, Roselle, New Jersey", @curator.find_photographs_by_artist(diane_arbus)[0].name
    assert_equal "Child with Toy Hand Grenade in Central Park", @curator.find_photographs_by_artist(diane_arbus)[1].name
  end

  def test_it_can_find_artists_with_mulitple_photgraphs
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }
    @curator.add_artist(artist_1)
    @curator.add_artist(artist_2)
    @curator.add_artist(artist_3)

    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    @curator.add_photograph(photo_1)
    @curator.add_photograph(photo_2)
    @curator.add_photograph(photo_3)
    @curator.add_photograph(photo_4)

    assert_equal 1, @curator.artists_with_multiple_photographs.length
    assert_equal "Diane Arbus", @curator.artists_with_multiple_photographs[0].name
  end

  def test_it_can_find_photographs_taken_by_artist_from_country
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }
    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }
    @curator.add_artist(artist_1)
    @curator.add_artist(artist_2)
    @curator.add_artist(artist_3)

    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }
    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }
    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }
    @curator.add_photograph(photo_1)
    @curator.add_photograph(photo_2)
    @curator.add_photograph(photo_3)
    @curator.add_photograph(photo_4)

    assert_equal 3, @curator.photographs_taken_by_artist_from("United States").length
    assert_equal "Moonrise, Hernandez", @curator.photographs_taken_by_artist_from("United States")[0].name
    assert_equal "Identical Twins, Roselle, New Jersey", @curator.photographs_taken_by_artist_from("United States")[1].name
    assert_equal "Child with Toy Hand Grenade in Central Park", @curator.photographs_taken_by_artist_from("United States")[2].name
    assert_equal [], @curator.photographs_taken_by_artist_from("Argentina")
  end

  def test_it_finds_photos_in_range
    @curator.load_photographs('./data/photographs.csv')
    @curator.load_artists('./data/photographs.csv')

    assert_equal 2, @curator.photographs_taken_between(1950..1965).count
    assert_equal "", @curator.photographs_taken_between(1950..1965)[0].name
    assert_equal "", @curator.photographs_taken_between(1950..1965)[1].name
  end

  def test_it_finds_artist_photgraphs_by_age
    @curator.load_photographs('./data/photographs.csv')
    @curator.load_artists('./data/photographs.csv')

    diane_arbus = curator.find_artist_by_id("3")
    expected = {44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park"}

    assert_equal expected, curator.artists_photographs_by_age(diane_arbus)
  end
end
