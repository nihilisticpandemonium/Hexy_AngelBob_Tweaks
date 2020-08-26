if mods["bobgreenhouse"] and settings.startup["angels-fertilizer-for-bobs-greenhouse"].value then
    -- replace fertilizer in recipe
    bobmods.lib.recipe.replace_ingredient("bob-advanced-greenhouse-cycle", "fertiliser", "solid-fertilizer")

    -- remove bob's fertilizer
    bobmods.lib.tech.remove_recipe_unlock("bob-fertiliser", "bob-fertiliser")

    -- modify tech name/prereqs to be more appropriate
    data.raw.technology["bob-fertiliser"].localised_name = {"technology-name.advanced-greenhouse"}
    data.raw.technology["bob-fertiliser"].icon = "__bobgreenhouse__/graphics/icons/technology/greenhouse.png"
    bobmods.lib.tech.replace_prerequisite("bob-fertiliser", "angels-nitrogen-processing-2", "bio-farm")
end