require 'minitest/autorun'
require 'minitest/pride'
require './lib/apartment'
require './lib/building'
require './lib/renter'

class BuildingTest < Minitest::Test

  def setup
    @building = Building.new
    @unit1 = Apartment.new({number: "A1", monthly_rent: 1200, bathrooms: 1, bedrooms: 1})
    @unit2 = Apartment.new({number: "B2", monthly_rent: 999, bathrooms: 2, bedrooms: 2})
    @unit3 = Apartment.new({number: "C3", monthly_rent: 1150, bathrooms: 2, bedrooms: 2})
    @unit4 = Apartment.new({number: "D4", monthly_rent: 1500, bathrooms: 3, bedrooms: 2})
    @renter1 = Renter.new("Spencer")
    @renter2 = Renter.new("Jessie")
    @renter3 = Renter.new("Max")
  end

  def test_it_exists
    assert_instance_of Building, @building
  end

  def test_it_starts_with_no_units
    assert_equal [], @building.units
  end

  def test_it_can_add_units
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)

    assert_equal [@unit1, @unit2], @building.units
  end

  def test_it_can_determine_average_rent
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)

    assert_equal 1099.5, @building.average_rent
  end

  def test_it_can_find_occupied_units
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)

    assert_equal [], @building.get_occupied_units

    @unit2.add_renter(@renter1)

    assert_equal [@unit2], @building.get_occupied_units

    @unit1.add_renter(@renter2)

    assert_equal [@unit1, @unit2], @building.get_occupied_units

    @unit3.add_renter(@renter3)

    assert_equal [@unit1, @unit2, @unit3], @building.get_occupied_units
  end

  def test_renter_with_highest_rent
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @unit2.add_renter(@renter1)

    assert_equal @renter1, @building.renter_with_highest_rent

    @unit1.add_renter(@renter2)

    assert_equal @renter2, @building.renter_with_highest_rent

    @unit3.add_renter(@renter3)

    assert_equal @renter2, @building.renter_with_highest_rent
  end

  def test_annual_breakdown
    skip
    @building.add_unit(@unit1)
    @building.add_unit(@unit2)
    @building.add_unit(@unit3)
    @unit2.add_renter(@renter1)
    expected = {"Spencer" => 11988}

    assert_equal expected, @building.annual_breakdown

    @unit1.add_renter(@renter2)
    expected = {"Jessie" => 14400, "Spencer" => 11988}
    assert_equal expected, @building.annual_breakdown
  end

end
