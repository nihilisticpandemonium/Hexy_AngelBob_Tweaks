if mods["angelsbioprocessing"] then
    if settings.startup["remove-angels-fish"].value then
        data.raw.technology["bio-refugium-fish"].enabled = false
    elseif settings.startup["remove-angels-meat"].value then
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-fish", "fish-butchery-1")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-fish", "fish-butchery-2")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-fish", "fish-butchery-3")
    end

    if settings.startup["remove-angels-meat"].value then
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-puffer", "puffer-butchery-1")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-puffer", "puffer-butchery-2")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-puffer", "puffer-butchery-3")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-puffer", "puffer-butchery-4")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-puffer", "puffer-butchery-5")
        bobmods.lib.tech.remove_recipe_unlock("bio-refugium-puffer", "bio-butchery")
    end

    if settings.startup["remove-angels-paste"].value then
        bobmods.lib.tech.remove_recipe_unlock("bio-processing-paste", "paste-silver")
    end

    if settings.startup["remove-angels-alien"].value then
        data.raw.technology["bio-biter-small"].enabled = false
        data.raw.technology["bio-biter-medium"].enabled = false
        data.raw.technology["bio-biter-big"].enabled = false
        bobmods.lib.tech.remove_recipe_unlock("bio-processing-alien", "crystal-seed")
        bobmods.lib.tech.remove_recipe_unlock("bio-processing-alien", "crystal-enhancer")
        bobmods.lib.tech.remove_recipe_unlock("bio-processing-alien", "crystal-grindstone")
        bobmods.lib.tech.remove_recipe_unlock("bio-processing-alien", "crystal-powder-slurry")

        if not mods["bobenemies"] then
            data.raw.technology["bio-processing-alien"].enabled = false
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