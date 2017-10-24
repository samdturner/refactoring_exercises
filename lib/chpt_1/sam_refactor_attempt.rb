class Movie
  attr_reader :title
  attr_accessor :price_code

  def initialize(title, price_code)
    @title, @price_code = title, price_code
  end

  def bonus_freq_renter_points_eligible
    false
  end
end

class RegularMovie < Movie
  def base_price
    2
  end

  def price_multiplier
    1.5
  end

  def max_days_base_price
    2
  end
end

class NewRelease < Movie
  def base_price
    0
  end

  def price_multiplier
    3
  end

  def max_days_base_price
    0
  end

  def bonus_freq_renter_points_eligible
    true
  end
end

class Childrens < Movie
  def base_price
    1.5
  end

  def price_multiplier
    1.5
  end

  def max_days_base_price
    3
  end
end

class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie, @days_rented = movie, days_rented
  end

  def amount_owed
    movie.base_price + late_fee
  end

  def freq_renter_points
    if movie.bonus_freq_renter_points_eligible && days_rented > 1
      return 2
    else
      return 1
    end
  end

  private

  def late_fee
    if days_rented > movie.max_days_base_price
      return days_late * movie.price_multiplier
    else
      return 0
    end
  end

  def days_late
    days_rented - movie.max_days_base_price
  end
end

class Customer
  attr_reader :name, :rentals

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    rentals << arg
  end

  def statement
    "Rental Record for #{name}\n"\
    "Amount owed is #{total_owed}\n"\
    "You earned #{total_freq_renter_points} frequent renter points"\
  end

  def total_freq_renter_points
    rentals.inject {|total, rental| total + rental.freq_renter_points }
  end

  def total_owed
    rentals.inject {|total, rental| total + rental.amount_owed }
  end
end