if mods["angelsbioprocessing"] then
    if settings.startup["remove-angels-fish"].value then
        data.raw.technology["bio-refugium-fish-1"].enabled = false
        data.raw.technology["bio-refugium-fish-2"].enabled = false
    elseif settings.startup["remove-angels-meat"].value then
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-fish-1", "fish-butchery-1")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-fish-1", "fish-butchery-2")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-fish-1", "fish-butchery-3")
    end

    if settings.startup["remove-angels-meat"].value then
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-puffer-1", "puffer-butchery-1")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-puffer-1", "puffer-butchery-2")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-puffer-1", "puffer-butchery-3")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-puffer-1", "puffer-butchery-4")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-puffer-1", "puffer-butchery-5")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-fish-1", "bio-butchery")
    end

    if settings.startup["remove-angels-paste"].value then
        bobmods.lib.tech.remove_recipe_unlock("bio-processing-paste", "paste-silver")
    end

    if settings.startup["remove-angels-alien"].value then
        data.raw.technology["bio-refugium-biter-1"].enabled = false
        data.raw.technology["bio-refugium-biter-2"].enabled = false
        data.raw.technology["bio-refugium-biter-3"].enabled = false
        bobmods.lib.tech.remove_recipe_unlock("bio-processing-alien-1", "crystal-seed")
        bobmods.lib.tech.remove_recipe_unlock("bio-processing-alien-1", "crystal-enhancer")
        bobmods.lib.tech.remove_recipe_unlock("bio-processing-alien-1", "crystal-grindstone")
        bobmods.lib.tech.remove_recipe_unlock("bio-processing-alien-1", "crystal-powder-slurry")

        if not mods["bobenemies"] then
            data.raw.technology["bio-processing-alien-1"].enabled = false
            data.raw.technology["bio-processing-paste"].enabled = false

            -- modify red algae
            bobmods.lib.recipe.remove_result("solid-calcium-carbonate", "solid-calcium-carbonate")
            bobmods.lib.recipe.add_result("solid-calcium-carbonate", {"solid-sodium-perchlorate", 5})
            data.raw.recipe["solid-calcium-carbonate"].icon = nil
            data.raw.recipe["solid-calcium-carbonate"].icon_size = nil

            -- modify mushredtato
            bobmods.lib.recipe.remove_result("sorting-swamp-5", "alien-bacteria")
            bobmods.lib.recipe.add_result("sorting-swamp-5", {"crystal-dust", 4})
        end
    end
end
