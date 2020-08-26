local function remove_plate_casting(metal)
    bobmods.lib.tech.remove_recipe_unlock("angels-"..metal.."-smelting-1", "molten-"..metal.."-smelting")
    bobmods.lib.tech.remove_recipe_unlock("angels-"..metal.."-smelting-1", "angels-plate-"..metal)
end

local function remove_powder(metal)
    bobmods.lib.tech.remove_recipe_unlock("angels-"..metal.."-smelting-2", "powder-"..metal)
end

if settings.startup["angels-casting-cleanup"].value then
    if not mods["CircuitProcessing"] then
        remove_plate_casting("chrome")
    end
    if not mods["MomoTweak"] then
        remove_plate_casting("cobalt")
        bobmods.lib.tech.remove_recipe_unlock("angels-silver-smelting-2", "angels-wire-coil-silver-casting")
        bobmods.lib.tech.remove_recipe_unlock("angels-silver-smelting-2", "angels-wire-coil-silver-converting")
        bobmods.lib.tech.remove_recipe_unlock("angels-silver-smelting-3", "angels-wire-coil-silver-casting-fast")
    end
    remove_powder("chrome")
    remove_powder("iron")
    remove_powder("copper")
    remove_plate_casting("manganese")
    remove_powder("steel")

    data.raw.recipe["powder-cobalt"].subgroup = "angels-tungsten-casting"
    data.raw.recipe["powder-cobalt"].order = "i"
    data.raw.recipe["casting-powder-tungsten-1"].order = "i-a"
    data.raw.recipe["powder-nickel"].subgroup = "angels-tungsten-casting"
    data.raw.recipe["powder-nickel"].order = "j"
    data.raw.recipe["casting-powder-tungsten-2"].order = "j-a"

    if mods["extendedangels"] then
        data.raw.recipe["powder-zinc"].subgroup = "angels-tungsten-casting"
        data.raw.recipe["powder-zinc"].order = "k"
        data.raw.recipe["casting-powder-tungsten-3"].order = "k-a"
        data.raw.recipe["angels-plate-tungsten"].order = "l"
    end
end