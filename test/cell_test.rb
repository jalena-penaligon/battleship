require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require 'pry'

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

  def test_has_a_cell_been_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    assert_equal false, cell.fired_upon?
  end

  def test_firing_upon_a_cell_with_ship_hits_health
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon
    assert_equal 2, cell.ship.health
  end

  def test_cell_returns_true_once_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.fire_upon
    assert_equal true, cell.fired_upon?

    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon
    assert_equal true, cell.fired_upon?
  end

  def test_how_will_it_render_when_not_fired_upon
    cell_1 = Cell.new("B4")

    assert_equal ".", cell_1.render
    assert_equal ".", cell_1.render(true)
  end

  def test_render_when_ship_is_placed
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    assert_equal ".", cell_2.render
  end

  def test_render_when_fired_but_missed
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.fire_upon
    assert_equal "M", cell_2.render
    assert_equal "M", cell_2.render(true)
  end

  def test_render_when_ship_is_placed_and_input_is_true
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)

    assert_equal "S", cell_2.render(true)
  end

  def test_render_when_a_ship_is_hit
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    assert_equal "H", cell_2.render
    assert_equal "H", cell_2.render(true)
    assert_equal false, cruiser.sunk?
  end

  def test_render_when_a_ship_is_sunk
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    cell_2.fire_upon
    cell_2.fire_upon
    assert_equal true, cruiser.sunk?
    assert_equal "X", cell_2.render
    assert_equal "X", cell_2.render(true)
  end
end
