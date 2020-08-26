if settings.startup["remove-phosgene"].value then
    bobmods.lib.tech.remove_recipe_unlock("chlorine-processing-3", "gas-phosgene")
end

if settings.startup["remove-ammonium-chloride"].value then
    bobmods.lib.tech.remove_recipe_unlock("angels-nitrogen-processing-2", "gas-ammonium-chloride")
end

if settings.startup["remove-angels-calcium-chloride"].value then
    bobmods.lib.tech.remove_recipe_unlock("basic-chemistry-2", "solid-calcium-chloride")
    bobmods.lib.tech.remove_recipe_unlock("chemical-processing-2", "calcium-chloride")
    bobmods.lib.tech.add_recipe_unlock("basic-chemistry-2", "calcium-chloride")
end

if settings.startup["remove-coal-liquefaction"].value then
    data.raw.technology["coal-liquefaction"].enabled = false
end