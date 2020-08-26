if settings.startup["easier-lead-3-smelting"].value then
    data.raw.recipe["pellet-lead-smelting"].results = {
        {type = "item", name = "ingot-lead", amount = 24},
        {type = "fluid", name = "gas-sulfur-dioxide", amount = 60},
    }
    data.raw.recipe["pellet-lead-smelting"].main_product = "ingot-lead"
    bobmods.lib.tech.remove_recipe_unlock("angels-lead-smelting-3", "liquid-hexafluorosilicic-acid")
    bobmods.lib.tech.remove_recipe_unlock("angels-lead-smelting-3", "anode-lead-smelting")
end