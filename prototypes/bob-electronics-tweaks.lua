if mods["bobelectronics"] then
    if settings.startup["fix-rubber-resin-texture"].value then
        data.raw.recipe["solid-resin"].icon = data.raw.item["resin"].icon
        data.raw.recipe["solid-rubber"].icon = data.raw.item["rubber"].icon
    end


    if settings.startup["rubber-resin-tweaks"].value then
        -- remove productivity from bob's resin recipe, function defined in productivity-fix.lua
        remove_productivity({"bob-resin-wood"})

        -- disable bob's rubber
        bobmods.lib.recipe.enabled("bob-rubber", false)

        -- buff angel's rubber recipe to make it more usable
        bobmods.lib.recipe.set_result("liquid-rubber-1", {"liquid-rubber", 20})

        -- change red/green wire recipe to use tinned copper wire
        bobmods.lib.recipe.replace_ingredient("red-wire", "insulated-cable", "tinned-copper-cable")
        bobmods.lib.recipe.replace_ingredient("green-wire", "insulated-cable", "tinned-copper-cable")

        if mods["PCPRedux"] then
            if data.raw.recipe["bob-resin-wood"].ingredients then
                data.raw.recipe["bob-resin-wood"].ingredients[1][2] = 5
            end
            if data.raw.recipe["bob-resin-wood"].normal then
                data.raw.recipe["bob-resin-wood"].normal.ingredients[1][2] = 5
            end
            if data.raw.recipe["bob-resin-wood"].expensive then
                data.raw.recipe["bob-resin-wood"].expensive.ingredients[1][2] = 5
            end

            data.raw.recipe["solid-rubber"].normal.results = {
                {"rubber", 4}
            }
            data.raw.recipe["solid-rubber"].expensive.results = {
                {"rubber", 4}
            }
        end
    end

    if settings.startup["silicon-wafer-tweaks"].value then
        data.raw.recipe["silicon-wafer"].category = "electronics-machine"
        data.raw.recipe["silicon-wafer"].energy_required = 2
    end

    if settings.startup["solder-tweaks"].value then
        data.raw.recipe["solder"].results = {
            {"solder", 4}
        }
    end

    if settings.startup["remove-glass-fiber"].value then
        bobmods.lib.tech.remove_recipe_unlock("angels-glass-smelting-3", "angels-coil-glass-fiber")
        bobmods.lib.tech.remove_recipe_unlock("angels-glass-smelting-3", "angels-glass-fiber-board")
    end
end