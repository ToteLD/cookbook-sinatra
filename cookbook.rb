require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    read_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    write_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    write_csv
  end

  def find(index)
    @recipes[index]
  end

  def mark_as_done!(index)
    recipe = @recipes[index]
    recipe.mark_as_done!
    write_csv
  end

  private

  def read_csv
    CSV.foreach(@csv_file_path) do |recipe|
      new_recipe = Recipe.new(recipe[0], recipe[1], recipe[2], recipe[3])
      new_recipe.mark_as_done! if recipe[4] == 'true'
      @recipes.push(new_recipe)
    end
  end

  def write_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done?]
      end
    end
  end
end
