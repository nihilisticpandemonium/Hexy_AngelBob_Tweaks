if settings.startup["cheaper-gem-crystallization"].value then
    for i = 1, 6 do
        bobmods.lib.recipe.set_ingredient("angelsore7-crystallization-"..i, {"crystal-seedling", 10})
    end
end

if settings.startup["fix-ceramic-filtering"].value then
    bobmods.lib.recipe.set_result("slag-processing-filtering-2", {"water-yellow-waste", 30})
    bobmods.lib.recipe.set_result("crystal-slurry-filtering-2", {"water-yellow-waste", 30})
    bobmods.lib.recipe.set_result("crystal-slurry-filtering-conversion-2", {"water-yellow-waste", 30})
end

if settings.startup["hybrid-catalyst-in-assembling-machine"].value then
    data.raw.recipe["catalysator-orange"].category = "crafting"
end

if settings.startup["stone-brick-tweaks"].value then
    data.raw.item["stone-brick"].stack_size = 1000
    data.raw.recipe["stone-brick"].subgroup = "angels-stone-casting"
    data.raw.recipe["stone-brick"].order = "e-d"
end

if settings.startup["angels-sludge-fix"].value then
    -- ferrous sludge
    data.raw.recipe["angelsore8-sludge"].results = {
        {type = "fluid", name = "angels-ore8-sludge", amount = 60}
    }
    bobmods.lib.recipe.set_ingredient("angelsore8-dust", {"angels-ore8-sludge", 40})

    -- cupric sludge
    data.raw.recipe["angelsore9-sludge"].results = {
        {type = "fluid", name = "angels-ore9-sludge", amount = 60}
    }
    bobmods.lib.recipe.set_ingredient("angelsore9-dust", {"angels-ore9-sludge", 40})
end
