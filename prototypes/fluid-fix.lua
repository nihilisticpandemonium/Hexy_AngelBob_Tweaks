data.raw.technology["gas-canisters"].prerequisites = {
    "fluid-handling"
}

if data.raw.technology["gas-canisters"].enabled then
    log("gas canister tech is ON")
else
    log("gas canister tech is OFF")
end

if settings.startup["liquid-fuel-deuterium-barrels"].value then
    log("put everything in barrels is ON")
    if not settings.startup["pcp-gas-bottling"] or not settings.startup["pcp-gas-bottling"].value then
        log("removing gas canisters")
        -- disable gas canister technology
        data.raw.technology["gas-canisters"].enabled = false

        -- move deuterium barreling to fluid handling
        bobmods.lib.tech.add_recipe_unlock("fluid-handling", "fill-deuterium-barrel")
        bobmods.lib.tech.add_recipe_unlock("fluid-handling", "empty-deuterium-barrel")

        -- change deuterium barrel icon
        data.raw.item["deuterium-barrel"].icons = {
            {
                icon = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",
                icon_size = 32,
            },
            {
                icon = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png",
                icon_size = 32,
                tint = {r=0.7, g=0.7, b=0.4},
            },
            {
                icon = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png",
                icon_size = 32,
                tint = {r=1, g=1, b=0.6},
            },
            {
                icon = "__bobplates__/graphics/icons/deuterium.png",
                icon_size = 64,
                shift = {0, 5},
                scale = 0.25
            }
        }
        data.raw.item["deuterium-barrel"].subgroup = "fill-barrel"

        -- change sorting order for deuterium barrel recipes
        data.raw.recipe["fill-deuterium-barrel"].subgroup = "fill-barrel"
        data.raw.recipe["fill-deuterium-barrel"].order = "b[deuterium-barrel]"
        data.raw.recipe["empty-deuterium-barrel"].subgroup = "empty-barrel"
        data.raw.recipe["empty-deuterium-barrel"].order = "c[empty-deuterium-barrel]"

        -- change barreling recipe icons
        data.raw.recipe["fill-deuterium-barrel"].icons =
        {
            {
                icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png",
                icon_size = 32
            },
            {
                icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png",
                icon_size = 32,
                tint = {r=0.7, g=0.7, b=0.4}
            },
            {
                icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png",
                icon_size = 32,
                tint = {r=1, g=1, b=0.6}
            },
            {
                icon = "__bobplates__/graphics/icons/deuterium.png",
                icon_size = 64,
                scale = 0.25,
                shift = {4, -8}
            }
        }
        data.raw.recipe["empty-deuterium-barrel"].icons =
        {
            {
                icon = "__base__/graphics/icons/fluid/barreling/barrel-empty.png",
                icon_size = 32
            },
            {
                icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-side-mask.png",
                icon_size = 32,
                tint = {r=0.7, g=0.7, b=0.4}
            },
            {
                icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-top-mask.png",
                icon_size = 32,
                tint = {r=1, g=1, b=0.6}
            },
            {
                icon = "__bobplates__/graphics/icons/deuterium.png",
                icon_size = 64,
                scale = 0.25,
                shift = {7, 8}
            }
        }

        -- change recipes
        bobmods.lib.recipe.replace_ingredient("fill-deuterium-barrel", "gas-canister", "empty-barrel")
        bobmods.lib.recipe.remove_result("empty-deuterium-barrel", "gas-canister")
        bobmods.lib.recipe.add_result("empty-deuterium-barrel", {"empty-barrel", 1})

        -- change recipe names
        data.raw.item["deuterium-barrel"].localised_name = {"item-name.alt-deuterium-barrel"}
        data.raw.recipe["fill-deuterium-barrel"].localised_name = {"recipe-name.alt-fill-deuterium-barrel"}
        data.raw.recipe["empty-deuterium-barrel"].localised_name = {"recipe-name.alt-empty-deuterium-barrel"}
    else
        log("NOT removing gas canisters")
    end

    -- remove empty canister
    bobmods.lib.tech.remove_recipe_unlock("fluid-handling", "empty-canister")

    -- change barrel icons
    data.raw.item["liquid-fuel-barrel"].icons = {
        {
            icon = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",
            icon_size = 32,
        },
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png",
            icon_size = 32,
            tint = {r=1.0, g=0.9, b=0.5},
        },
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png",
            icon_size = 32,
            tint = {r=0.5, g=0.5, b=0.5},
        },
        {
            icon = "__bobplates__/graphics/icons/liquid-fuel.png",
            icon_size = 32,
            shift = {0, 5},
            scale = 0.5
        }
    }

    -- change recipe ingredients
    bobmods.lib.recipe.replace_ingredient("fill-liquid-fuel-barrel", "empty-canister", "empty-barrel")
    bobmods.lib.recipe.remove_result("empty-liquid-fuel-barrel", "empty-canister")
    bobmods.lib.recipe.add_result("empty-liquid-fuel-barrel", {"empty-barrel", 1})

    -- change recipe icons
    data.raw.recipe["fill-liquid-fuel-barrel"].icons =
    {
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-fill.png",
            icon_size = 32
        },
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-side-mask.png",
            icon_size = 32,
            tint = {r=1.0, g=0.9, b=0.5}
        },
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-fill-top-mask.png",
            icon_size = 32,
            tint = {r=0.5, g=0.5, b=0.5}
        },
        {
            icon = "__bobplates__/graphics/icons/liquid-fuel.png",
            icon_size = 32,
            scale = 0.5,
            shift = {4, -8}
        }
    }
    data.raw.recipe["empty-liquid-fuel-barrel"].icons =
    {
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-empty.png",
            icon_size = 32
        },
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-side-mask.png",
            icon_size = 32,
            tint = {r=1.0, g=0.9, b=0.5}
        },
        {
            icon = "__base__/graphics/icons/fluid/barreling/barrel-empty-top-mask.png",
            icon_size = 32,
            tint = {r=0.5, g=0.5, b=0.5}
        },
        {
            icon = "__bobplates__/graphics/icons/liquid-fuel.png",
            icon_size = 32,
            scale = 0.5,
            shift = {7, 8}
        }
    }

    -- change recipe/item localizations
    data.raw.item["liquid-fuel-barrel"].localised_name = {"item-name.alt-liquid-fuel-barrel"}
    data.raw.recipe["fill-liquid-fuel-barrel"].localised_name = {"recipe-name.alt-fill-liquid-fuel-barrel"}
    data.raw.recipe["empty-liquid-fuel-barrel"].localised_name = {"recipe-name.alt-empty-liquid-fuel-barrel"}
else
    log("put everything in barrels is OFF, doing nothing")
end

if mods["angelsbioprocessing"] and settings.startup["clarify-nutrient-pulp"].value then
    angelsmods.functions.make_void("liquid-nutrient-pulp", "water")
end
