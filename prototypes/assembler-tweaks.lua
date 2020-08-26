if mods["bobassembly"] then
    if settings.startup["bob-assembler-tweaks"].value then
        data.raw["assembling-machine"]["assembling-machine-1"].module_specification =
        {
            module_slots = 1,
            module_info_icon_shift = {0, 0.5},
            module_info_multi_row_initial_height_modifier = -0.3
        }
        data.raw["assembling-machine"]["assembling-machine-1"].allowed_effects = {"consumption", "speed", "productivity", "pollution"}
        data.raw["assembling-machine"]["assembling-machine-3"].module_specification.module_slots = 3
        data.raw["assembling-machine"]["assembling-machine-4"].module_specification.module_slots = 4
    end

    if settings.startup["chem-plant-tweaks"].value then
        -- disable bob's chem plant techs
        data.raw.technology["chemical-plant"].enabled = false
        for _, tech in pairs(data.raw.technology) do
            if tech.prerequisites then
                bobmods.lib.tech.remove_prerequisite(tech.name, "chemical-plant")
            end
        end

        -- disable bob's higher tier chem plants if higher tier chem plants are enabled
        if settings.startup["bobmods-assembly-chemicalplants"].value then
            data.raw.technology["chemical-plant-2"].enabled = false
            data.raw.technology["chemical-plant-3"].enabled = false
            data.raw.technology["chemical-plant-4"].enabled = false
        end

        -- change Angel's chem plant speeds
        data.raw["assembling-machine"]["angels-chemical-plant"].crafting_speed = 1
        data.raw["assembling-machine"]["angels-chemical-plant-2"].crafting_speed = 1.5
        data.raw["assembling-machine"]["angels-chemical-plant-3"].crafting_speed = 2.25
        data.raw["assembling-machine"]["angels-chemical-plant-4"].crafting_speed = 3.5

        -- change angel's chem plant recipe to use the normal chem plant recipe ingredients for
        -- prod science balance
        -- If SeaBlock is in the mods list, it will overwrite the chem plant recipe, and we aren't going to change it.
        if not mods["SeaBlock"] then
            local buildingmulti = angelsmods.marathon.buildingmulti
            data.raw.recipe["angels-chemical-plant"].normal.ingredients = {
                {"pipe", 6},
                {"electronic-circuit", 2},
                {"iron-gear-wheel", 3},
                {"steel-plate", 6}
            }
            data.raw.recipe["angels-chemical-plant"].expensive.ingredients = {
                {"pipe", 6 * buildingmulti},
                {"electronic-circuit", 2 * buildingmulti},
                {"iron-gear-wheel", 3 * buildingmulti},
                {"steel-plate", 6 * buildingmulti}
            }
        end

        -- replace normal chem plant with Angel's chem plant everywhere
        bobmods.lib.recipe.replace_ingredient_in_all("chemical-plant", "angels-chemical-plant")
    end
end

if settings.startup["bobmods-assembly-limits"]
  and not settings.startup["bobmods-assembly-limits"].value
  and settings.startup["remove-ingredient-limits"].value then
        for _, machine in pairs(data.raw["assembling-machine"]) do
        if machine.ingredient_count then
            machine.ingredient_count = nil
        end
    end
end