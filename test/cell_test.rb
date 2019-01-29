require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_does_it_have_a_ship
    cell = Cell.new("B4")

    assert_nil cell.ship
  end

  def test_is_cell_empty
    cell = Cell.new("B4")

    assert_equal true, cell.empty?
  end

  def test_can_you_place_a_ship
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
    assert_equal false, cell.empty?
  end

  
end
