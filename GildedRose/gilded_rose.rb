class AgedBrie
  def initialize(item)
    @item = item
  end

  def execute
    update_sell_in(@item)
    update_quality(@item)
  end

  private

  def update_sell_in(item)
    item.sell_in -= 1
  end

  def update_quality(item)
    if item.quality < 50
      item.quality += 1
    end

    if item.sell_in.negative? && item.quality < 50
      item.quality += 1
    end
  end
end

class BackstagePasses
  def initialize(item)
    @item = item
  end

  def execute
    update_sell_in(@item)
    update_quality(@item)
  end

  private

  def update_sell_in(item)
    item.sell_in -= 1
  end

  def update_quality(item)
    if item.quality < 50
      item.quality += 1
    end

    if item.sell_in < 11 && item.quality < 50
      item.quality += 1
    end

    if item.sell_in < 6 && item.quality < 50
      item.quality += 1
    end

    if item.sell_in.negative?
      item.quality -= item.quality
    end
  end
end

class Conjured
  def initialize(item)
    @item = item
  end

  def execute
    update_sell_in(@item)
    update_quality(@item)
  end

  private

  def update_sell_in(item)
    item.sell_in -= 1
  end

  def update_quality(item)
    if item.quality < 4
      item.quality -= item.quality
    else
      item.quality -= 4
    end
  end
end

class GildedRose

  def initialize(items)
    @items = items
  end

  def execute
    @items.each do |item|
      next if item.name == 'Sulfuras, Hand of Ragnaros'

      case item.name
      when 'Aged Brie'
        AgedBrie.new(item).execute
      when 'Backstage passes to a TAFKAL80ETC concert'
        BackstagePasses.new(item).execute
      when 'Conjured Mana Cake'
        Conjured.new(item).execute
      else
        update_sell_in(item)
        update_quality(item)
      end
    end
  end

  private

  def update_sell_in(item)
    item.sell_in -= 1
  end

  def update_quality(item)
    if item.quality.positive?
      item.quality -= 1
    end

    if item.sell_in.negative?
      item.quality -= item.quality
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

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
