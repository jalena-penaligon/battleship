require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

require 'pry'

class ShipTest < Minitest::Test

def test_it_exists
  cruiser = Ship.new("Cruiser", 3)
  assert_instance_of Ship, cruiser
end

def test_it_has_a_name
  cruiser = Ship.new("Cruiser", 3)
  assert_equal "Cruiser", cruiser.name
end

def test_it_has_a_length
  cruiser = Ship.new("Cruiser", 3)
  assert_equal 3, cruiser.length
end

def test_you_can_count_health
  cruiser = Ship.new("Cruiser", 3)
  assert_equal 3, cruiser.health
end

def test_is_it_sunk
  cruiser = Ship.new("Cruiser", 3)
  assert_equal false, cruiser.sunk?
end

def test_it_takes_a_hit_but_not_sunk_yet
  cruiser = Ship.new("Cruiser", 3)
  cruiser.hit
  assert_equal 2, cruiser.health
  assert_equal false, cruiser.sunk?
end

def test_it_takes_hits_till_it_sinks
  cruiser = Ship.new("Cruiser", 3)
  cruiser.hit
  cruiser.hit
  assert_equal 1, cruiser.health
  cruiser.hit
  assert_equal 0, cruiser.health
  assert_equal true, cruiser.sunk?
end

end
