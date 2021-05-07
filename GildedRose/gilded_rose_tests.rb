require_relative 'gilded_rose.rb'
require 'test/unit'

class TestUntitled < Test::Unit::TestCase

  def test_foo
    foo =  Item.new("foo", 1, 1)
    bar =  Item.new("bar", 1, 0)
    aged_brie = Item.new("Aged Brie", 1, 1)
    sulfuras = Item.new("Sulfuras, Hand of Ragnaros", 1, 80)
    backstage_passes = Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 10)
    expired_backstage_passes = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)
    items = [foo, bar, aged_brie, sulfuras, backstage_passes, expired_backstage_passes]

    GildedRose.new(items).execute
    assert_equal foo.sell_in, 0
    assert_equal foo.quality, 0
    assert_equal bar.sell_in, 0
    assert_equal bar.quality, 0
    assert_equal aged_brie.sell_in, 0
    assert_equal aged_brie.quality, 2
    assert_equal sulfuras.sell_in, 1
    assert_equal sulfuras.quality, 80
    assert_equal backstage_passes.sell_in, 0
    assert_equal backstage_passes.quality, 13
    assert_equal expired_backstage_passes.sell_in, -1
    assert_equal expired_backstage_passes.quality, 0
  end

  def test_backstage_sell_in_12
    backstage_passes_2 = Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10)
    items = [backstage_passes_2]
    GildedRose.new(items).execute
    assert_equal backstage_passes_2.sell_in, 10
    assert_equal backstage_passes_2.quality, 12
  end

  def test_conjured
    conjured = Item.new('Conjured Mana Cake', 11, 3)
    conjured2 = Item.new('Conjured Mana Cake', 11, 4)
    items = [conjured, conjured2]
    GildedRose.new(items).execute
    assert_equal conjured.sell_in, 10
    assert_equal conjured.quality, 0
    assert_equal conjured2.sell_in, 10
    assert_equal conjured2.quality, 0
  end
end
