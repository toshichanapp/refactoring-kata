class GildedRose

  def initialize(items)
    @items = items
  end

  def execute
    @items.each do |item|
      case item.name
      when 'Aged Brie'
        update_sell_in(item)
        update_aged_brie_quality(item)
      when 'Backstage passes to a TAFKAL80ETC concert'
        update_sell_in(item)
        update_backstage_quality(item)
      when 'Sulfuras, Hand of Ragnaros'
      else
        update_sell_in(item)
        update_quality(item)
      end
    end
  end

  private

  def update_sell_in(item)
    item.sell_in = item.sell_in - 1
  end

  def update_aged_brie_quality(item)
    if item.quality < 50
      item.quality = item.quality + 1
    end

    if item.sell_in < 0
      if item.quality < 50
        item.quality = item.quality + 1
      end
    end
  end

  def update_backstage_quality(item)
    if item.quality < 50
      item.quality = item.quality + 1
      if item.sell_in < 11
        if item.quality < 50
          item.quality = item.quality + 1
        end
      end
      if item.sell_in < 6
        if item.quality < 50
          item.quality = item.quality + 1
        end
      end
    end

    if item.sell_in < 0
      item.quality = item.quality - item.quality
    end
  end

  def update_quality(item)
    if item.quality > 0
      item.quality = item.quality - 1
    end

    if item.sell_in < 0
      item.quality = item.quality - item.quality
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
