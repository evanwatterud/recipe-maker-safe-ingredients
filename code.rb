require "pry"

class Ingredient
  ALLOWED_INGREDIENTS = [
    "brussels sprouts",
    "spinach",
    "eggs",
    "milk",
    "tofu",
    "seitan",
    "bell peppers",
    "quinoa",
    "kale",
    "chocolate",
    "beer",
    "wine",
    "whiskey"
  ]

  attr_reader :name

  def initialize(quantity, unit, name)
    @quantity = quantity
    @unit = unit
    @name = name
  end

  def self.parse(ingredient_info)
    info = ingredient_info.split(" ")
    ingredient_quantity = info.shift.to_f
    ingredient_units = info.shift
    ingredient_name = info.join(" ")

    Ingredient.new(ingredient_quantity, ingredient_units, ingredient_name)
  end

  def is_valid?
    ALLOWED_INGREDIENTS.include?(@name.downcase)
  end

  def summary
    "#{@quantity} #{@unit} #{@name}"
  end
end

class Recipe
  attr_reader :name

  def initialize(name, instructions, ingredients)
    @name = name
    @instructions = instructions
    @ingredients = ingredients
  end

  def is_safe?
    @ingredients.each do |ingredient|
      return false if !ingredient.is_valid?
    end
    true
  end

  def summary
    summary_string = ""
    summary_string << "Name: #{@name}\n \nIngredients\n"

    @ingredients.each do |ingredient|
      summary_string << "- #{ingredient.summary}\n"
    end

    summary_string << "\nInstructions\n"

    @instructions.each_with_index do |instruction, index|
      summary_string << "#{index + 1}. #{instruction}\n"
    end

    summary_string
  end
end

name = "Roasted Brussels Sprouts"

ingredients = [
  Ingredient.new(1.5, "lb(s)", "Brussels sprouts"),
  Ingredient.new(3.0, "tbspn(s)", "Good olive oil"),
  Ingredient.new(0.75, "tspn(s)", "Kosher salt"),
  Ingredient.new(0.5, "tspn(s)", "Freshly ground black pepper")
]

instructions = [
  "Preheat oven to 400 degrees F.",
  "Cut off the brown ends of the Brussels sprouts.",
  "Pull off any yellow outer leaves.",
  "Mix them in a bowl with the olive oil, salt and pepper.",
  "Pour them on a sheet pan and roast for 35 to 40 minutes.",
  "They should be until crisp on the outside and tender on the inside.",
  "Shake the pan from time to time to brown the sprouts evenly.",
  "Sprinkle with more kosher salt ( I like these salty like French fries).",
  "Serve and enjoy!"
]

recipe = Recipe.new(name, instructions, ingredients)
puts "Is #{recipe.name} safe? #{recipe.is_safe?}"
brussels_sprouts = Ingredient.parse("1.5 lb(s) Brussels Sprouts")
puts brussels_sprouts.summary
puts " "
puts recipe.summary

safe_name = "Chocolate Quinoa"
safe_ingredients = [
        Ingredient.new(1.0, "cup", "Quinoa"),
        Ingredient.new(1.0, "cup", "Chocolate")
      ]
safe_instructions = [
        "Melt chocolate.",
        "Pour over quinoa.",
        "Regret your life."
      ]
safe_recipe = Recipe.new(safe_name, safe_instructions, safe_ingredients)
puts "Is #{safe_recipe.name} safe? #{safe_recipe.is_safe?}"
