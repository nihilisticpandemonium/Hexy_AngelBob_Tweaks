if mods["bobwarfare"] and settings.startup["new-nitroglycerin-recipe"].value then
    -- change nitroglycerin icon
    data.raw.fluid["nitroglycerin"].icon = "__Hexy_AngelBob_Tweaks__/graphics/icons/nitroglycerin.png"
    data.raw.fluid["nitroglycerin"].icon_size = 32

    -- modify nitroglycerin tech
    bobmods.lib.tech.remove_recipe_unlock("nitroglycerin-processing", "sulfuric-nitric-acid")

    -- modify nitroglycerin recipe
    data.raw.recipe["nitroglycerin"].ingredients = {
        {type = "fluid", name = "liquid-glycerol", amount = 50},
        {type = "fluid", name = "liquid-nitric-acid", amount = 50},
        {type = "fluid", name = "liquid-sulfuric-acid", amount = 50},
    }
    bobmods.lib.recipe.set_result("nitroglycerin", {"nitroglycerin", 50})
    data.raw.recipe["nitroglycerin"].energy_required = 2
    data.raw.recipe["nitroglycerin"].icon = "__Hexy_AngelBob_Tweaks__/graphics/icons/nitroglycerin-recipe.png"
    data.raw.recipe["nitroglycerin"].icon_size = 32

    -- modify explosives II recipe
    bobmods.lib.recipe.remove_ingredient("solid-nitroglycerin", "liquid-sulfuric-acid")
    bobmods.lib.recipe.remove_ingredient("solid-nitroglycerin", "liquid-nitric-acid")
    bobmods.lib.recipe.remove_ingredient("solid-nitroglycerin", "liquid-glycerol")
    bobmods.lib.recipe.add_ingredient("solid-nitroglycerin", {"nitroglycerin", 50})

    -- modify explosives II tech
    bobmods.lib.tech.add_prerequisite("angels-explosives-1", "nitroglycerin-processing")
    bobmods.lib.tech.remove_prerequisite("angels-explosives-1", "angels-nitrogen-processing-2")
    bobmods.lib.tech.remove_prerequisite("angels-explosives-1", "angels-sulfur-processing-2")
end
