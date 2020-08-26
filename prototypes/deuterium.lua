if settings.startup["new-deuterium-recipe"].value then
    -- change icons
    data.raw["fluid"]["heavy-water"].icon = "__Hexy_AngelBob_Tweaks__/graphics/icons/heavy-water.png"
    data.raw["fluid"]["heavy-water"].icon_size = 32
    data.raw["fluid"]["deuterium"].icon = "__Hexy_AngelBob_Tweaks__/graphics/icons/deuterium.png"
    data.raw["fluid"]["deuterium"].icon_size = 32

    -- change recipes
    data.raw["recipe"]["bob-heavy-water"].category = "advanced-chemistry"
    data.raw["recipe"]["bob-heavy-water"].energy_required = 20
    data.raw["recipe"]["bob-heavy-water"].ingredients =
    {
        {type = "fluid", name = "water-purified", amount = 6000},
        {type = "fluid", name = "gas-hydrogen-sulfide", amount = 100},
    }
    data.raw["recipe"]["bob-heavy-water"].results = {
        {type = "fluid", name = "gas-hydrogen-sulfide", amount = 100},
        {type = "fluid", name = "heavy-water", amount = 1},
        {type = "fluid", name = "water-purified", amount = 5000},
    }
    data.raw["recipe"]["bob-heavy-water"].icon = "__Hexy_AngelBob_Tweaks__/graphics/icons/bob-heavy-water.png"
    data.raw["recipe"]["bob-heavy-water"].icon_size = 32
    data.raw["recipe"]["bob-heavy-water"].crafting_machine_tint = nil

    data.raw["recipe"]["heavy-water-electrolysis"].category = "petrochem-electrolyser"
    data.raw["recipe"]["heavy-water-electrolysis"].energy_required = 1
    data.raw["recipe"]["heavy-water-electrolysis"].ingredients =
    {
        {type = "fluid", name = "heavy-water", amount = 20},
    }
    data.raw["recipe"]["heavy-water-electrolysis"].results =
    {
        {type = "fluid", name = "deuterium", amount = 12},
        {type = "fluid", name = "gas-oxygen", amount = 8},
    }
    data.raw["recipe"]["heavy-water-electrolysis"].icon = "__Hexy_AngelBob_Tweaks__/graphics/icons/heavy-water-electrolysis.png"
    data.raw["recipe"]["heavy-water-electrolysis"].icon_size = 32
end