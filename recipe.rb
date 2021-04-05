class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(name, description, rating, prep_time = nil)
    @rating = rating
    @name = name
    @description = description
    @prep_time = prep_time
    @done = false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
