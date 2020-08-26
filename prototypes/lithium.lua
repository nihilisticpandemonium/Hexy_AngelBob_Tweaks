if settings.startup["new-lithium-recipes"].value then
    -- disable old lithium perchlorate recipe
    data.raw.recipe["lithium-water-electrolysis"].enabled = false
    bobmods.lib.tech.remove_recipe_unlock("lithium-processing", "lithium-water-electrolysis")

    -- disable lithium smelting if momotweak's bob extended electronics option isn't on
    if not mods["MomoTweak"] or not settings.startup["momo-enable-bob-extend-ele"].value then
        data.raw.recipe["lithium"].enabled = false
        bobmods.lib.tech.remove_recipe_unlock("lithium-processing", "lithium")
    end

    -- modify deuterium fuel cell reprocessing to return lithium chloride
    data.raw.recipe["deuterium-fuel-reprocessing"].results[2]["name"] = "lithium-chloride"

    -- change lithium cobalt oxide to use lithium chloride instead of lithium. Momo's Tweaks adds uses to lithium, which is why this isn't more general
    bobmods.lib.recipe.replace_ingredient("lithium-cobalt-oxide", "lithium", "lithium-chloride")

    -- modify lithium perchlorate synthesis to use sodium perchlorate as it does
    -- irl
    data:extend({
        {
            type = "recipe",
            name = "lithium-perchlorate",
            subgroup = "bob-fluid-electrolysis",
            order = "b[fluid-chemistry]-b[lithium-water-electrolysis]",
            category = "chemistry",
            enabled = false,
            energy_required = 2,
            ingredients =
            {
                {type = "item", name = "lithium-chloride", amount = 1},
                {type = "item", name = "solid-sodium-perchlorate", amount = 1}
            },
            results =
            {
                {type = "item", name = "lithium-perchlorate", amount = 1},
                {type = "item", name = "solid-salt", amount = 1},
            },
            main_product = "lithium-perchlorate",
            allow_decomposition = false
        }
    })
    bobmods.lib.tech.add_recipe_unlock("lithium-processing", "lithium-perchlorate")
    bobmods.lib.tech.add_science_pack("lithium-processing", "chemical-science-pack", 1)

    -- make sodium perchlorate easier to make
    bobmods.lib.recipe.replace_ingredient("solid-sodium-perchlorate", "catalyst-metal-blue", "catalyst-metal-green")

    -- modify lithium processing prerequisites
    data.raw.technology["lithium-processing"].prerequisites = {
        "chlorine-processing-3",
        "thermal-water-extraction",
    }
end