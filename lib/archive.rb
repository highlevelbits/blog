class Month
  attr_accessor :items
  attr_accessor :name

  def initialize month_number
    self.items = []
    self.name = Date::MONTHNAMES[month_number]
  end

  def count
    self.items.size
  end

  def add item
    self.items << item
  end
end

class Year
  attr_accessor :months

  def initialize
    self.months = {}
  end

  def count
    self.months.values.map( &:count ).reduce( :+ )
  end

  def add item
    item_month = item[:created_at].month
    self.months[item_month] ||= Month.new( item_month )
    self.months[item_month].add item
  end

  def self.articles_per_year sorted_articles
    years = {}

    sorted_articles.each do |item|
      item_year = item[:created_at].year
      years[item_year] ||= Year.new
      years[item_year].add item
    end

    years
  end
end
