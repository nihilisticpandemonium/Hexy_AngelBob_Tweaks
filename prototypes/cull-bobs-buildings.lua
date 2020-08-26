if settings.startup["remove-bobs-valves"].value then
    -- seablock adds an unlock for the valve to one of the sciences
    if mods["SeaBlock"] then
        bobmods.lib.tech.remove_recipe_unlock("sct-automation-science-pack", "bob-valve")
    end
    if mods['MomoTweak'] then
        bobmods.lib.recipe.replace_ingredient('angels-chemical-plant', 'bob-valve', 'pipe')
    end
    bobmods.lib.tech.remove_recipe_unlock("fluid-handling", "bob-overflow-valve")
    bobmods.lib.tech.remove_recipe_unlock("fluid-handling", "bob-topup-valve")
    bobmods.lib.recipe.enabled("bob-valve", false)
    bobmods.lib.recipe.enabled("bob-overflow-valve", false)
    bobmods.lib.recipe.enabled("bob-topup-valve", false)
end

if settings.startup["remove-bobs-water-bores"].value then
    data.raw.technology["water-bore-1"].enabled = false
    data.raw.technology["water-bore-2"].enabled = false
    data.raw.technology["water-bore-3"].enabled = false
    data.raw.technology["water-bore-4"].enabled = false
    bobmods.lib.recipe.enabled("lithia-water", false)
    bobmods.lib.recipe.enabled("pure-water-pump", false)
    bobmods.lib.recipe.enabled("ground-water", false)
    if mods["SeaBlock"] then
        bobmods.lib.tech.remove_recipe_unlock("sct-automation-science-pack", "lithia-water")
        bobmods.lib.tech.remove_recipe_unlock("sct-automation-science-pack", "pure-water-pump")
        bobmods.lib.tech.remove_recipe_unlock("sct-automation-science-pack", "ground-water")
    end
end

if mods["bobmodules"] and settings.startup["remove-bobs-beacons"].value then
    data.raw.technology["effect-transmission-2"].enabled = false
    data.raw.technology["effect-transmission-3"].enabled = false
end

if mods["boblogistics"] and settings.startup["remove-bobs-repair-packs"].value then
    data.raw.technology["bob-repair-pack-2"].enabled = false
    data.raw.technology["bob-repair-pack-3"].enabled = false
    data.raw.technology["bob-repair-pack-4"].enabled = false
    data.raw.technology["bob-repair-pack-5"].enabled = false
end

if settings.startup["remove-bobs-electrolyzers"].value then
    -- disable electrolyzer technologies
    data.raw.technology["electrolysis-1"].enabled = false
    data.raw.technology["electrolysis-2"].enabled = false
    if mods["bobassembly"] and settings.startup["bobmods-assembly-electrolysers"].value then
        data.raw.technology["electrolyser-2"].enabled = false
        data.raw.technology["electrolyser-3"].enabled = false
        data.raw.technology["electrolyser-4"].enabled = false
    end

    -- momo's tweaks adds recipes to the electrolyzer, so we move them
    if mods["MomoTweak"] then
        data.raw.recipe["momo-silicon-plate"].category = "mixing-furnace"
        data.raw.recipe["lithium-ion-battery"].category = "chemistry"
        data.raw.recipe["silver-zinc-battery"].category = "chemistry"
        if mods["angelsbioprocessing"] then
            data.raw.recipe["solid-alginic-acid"].category = "chemistry"
        end
    end

    -- bob's small tanks are attached to electrolysis 1, so move them to fluid
    -- handling if not disabled
    if not settings.startup["remove-bobs-small-tanks"].value then
        bobmods.lib.tech.add_recipe_unlock("fluid-handling", "bob-small-inline-storage-tank")
        bobmods.lib.tech.add_recipe_unlock("fluid-handling", "bob-small-storage-tank")
    end

    -- change recipes that used electrolyzer to different buildings. if new
    -- lithium recipes are enabled, it will disable these recipes.
    data.raw.recipe["lithium"].category = "smelting"
    data.raw.recipe["lithium-water-electrolysis"].category = "chemistry"

    for _, tech in pairs(data.raw.technology) do
        if tech.prerequisites then
            bobmods.lib.tech.remove_prerequisite(tech.name, "electrolysis-1")
            bobmods.lib.tech.remove_prerequisite(tech.name, "electrolysis-2")
        end
    end
end