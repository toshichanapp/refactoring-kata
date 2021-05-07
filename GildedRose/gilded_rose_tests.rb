require_relative 'gilded_rose.rb'
require 'test/unit'

class TestUntitled < Test::Unit::TestCase

  def test_foo
    foo =  Item.new("foo", 1, 1)
    aged_brie = Item.new("Aged Brie", 1, 1)
    sulfuras = Item.new("Sulfuras, Hand of Ragnaros", 1, 80)
    backstage_passes = Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 10)
    backstage_passes_2 = Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10)
    expired_backstage_passes = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)
    items = [foo, aged_brie, sulfuras, backstage_passes, backstage_passes_2, expired_backstage_passes]

    GildedRose.new(items).execute
    assert_equal foo.sell_in, 0
    assert_equal foo.quality, 0
    assert_equal aged_brie.sell_in, 0
    assert_equal aged_brie.quality, 2
    assert_equal sulfuras.sell_in, 1
    assert_equal sulfuras.quality, 80
    assert_equal backstage_passes.sell_in, 0
    assert_equal backstage_passes.quality, 13
    assert_equal backstage_passes_2.sell_in, 10
    assert_equal backstage_passes_2.quality, 12
    assert_equal expired_backstage_passes.sell_in, -1
    assert_equal expired_backstage_passes.quality, 0
  end

end
