if settings.startup["tech-cleanup"].value then
    -- remove unnecessary dependencies on chemical processing and alloy processing
    for _, tech in pairs(data.raw.technology) do
        if tech.prerequisites then
            bobmods.lib.tech.remove_prerequisite(tech.name, "chemical-processing-1")
            bobmods.lib.tech.remove_prerequisite(tech.name, "chemical-processing-2")
            bobmods.lib.tech.remove_prerequisite(tech.name, "alloy-processing-1")
        end
    end

    -- add back necessary dependencies between the different techs
    bobmods.lib.tech.add_prerequisite("chemical-processing-2", "chemical-processing-1")
    bobmods.lib.tech.add_prerequisite("chemical-processing-3", "chemical-processing-2")
    bobmods.lib.tech.add_prerequisite("oil-chemical-steel-furnace", "chemical-processing-2")
    bobmods.lib.tech.add_prerequisite("alloy-processing-2", "alloy-processing-1")

    if mods["Bob_Furnaces_Multipurpose"] or mods["MomoTweak"] then
        data.raw.technology["alloy-processing-1"].enabled = false
    else
        -- these recipes actually require metal mixing furnace, don't remove
        bobmods.lib.tech.add_prerequisite("electronics", "alloy-processing-1")

        -- these recipes actually require chemical furnace, don't remove
        bobmods.lib.tech.add_prerequisite("lithium-processing", "chemical-processing-1")
        bobmods.lib.tech.add_prerequisite("grinding", "chemical-processing-1")

        -- this mod removes these requirements
        if not mods["Better_Angels_Smelting"] then
            bobmods.lib.tech.add_prerequisite("tungsten-alloy-processing", "alloy-processing-1")
            bobmods.lib.tech.add_prerequisite("ceramics", "chemical-processing-1")
        end

        -- make steel mixing furnace tech alloy processing 2 and electric
        -- mixing furnace tech alloy processing 3
        data.raw.technology["mixing-steel-furnace"].enabled = false
        bobmods.lib.tech.replace_prerequisite("oil-mixing-steel-furnace", "mixing-steel-furnace", "alloy-processing-2")
        bobmods.lib.tech.replace_prerequisite("alloy-processing-2", "advanced-material-processing-2", "advanced-material-processing")
        data.raw.technology["alloy-processing-2"].unit = data.raw.technology["mixing-steel-furnace"].unit
        data.raw.technology["alloy-processing-2"].effects = data.raw.technology["mixing-steel-furnace"].effects

        data:extend{
            {
                type = "technology",
                name = "alloy-processing-3",
                icon = "__bobplates__/graphics/icons/technology/alloy-processing.png",
                icon_size = 128,
                prerequisites =
                {
                    "alloy-processing-2",
                    "advanced-material-processing-2"
                },
                effects =
                {
                    {
                        type = "unlock-recipe",
                        recipe = "electric-mixing-furnace"
                    },
                },
                unit =
                {
                    count = 75,
                    ingredients =
                    {
                        {"automation-science-pack", 1},
                        {"logistic-science-pack", 1},
                        {"chemical-science-pack", 1},
                    },
                    time = 30
                },
                order = "c-c-a-c"
            }
        }
        bobmods.lib.tech.replace_prerequisite("multi-purpose-furnace-1", "alloy-processing-2", "alloy-processing-3")
    end

    if mods["boblogistics"] then
        -- move bronze pipes from alloy processing to bronze processing tech
        bobmods.lib.tech.remove_recipe_unlock("alloy-processing-1", "bronze-pipe")
        bobmods.lib.tech.remove_recipe_unlock("alloy-processing-1", "bronze-pipe-to-ground")
        data:extend{
            {
                type = "technology",
                name = "bronze-processing",
                icon = "__bobplates__/graphics/icons/technology/alloy-processing.png",
                icon_size = 128,
                prerequisites =
                {
                    "angels-bronze-smelting-1"
                },
                effects =
                {
                    {
                        type = "unlock-recipe",
                        recipe = "bronze-pipe"
                    },
                    {
                        type = "unlock-recipe",
                        recipe = "bronze-pipe-to-ground"
                    },
                },
                unit =
                {
                    count = 25,
                    ingredients =
                    {
                        {"automation-science-pack", 1},
                    },
                    time = 30
                },
                order = "d"
            }
        }
        if mods["bobsflowcontrol-updated"] then
            bobmods.lib.tech.add_recipe_unlock("bronze-processing", "pipe-bronze-straight")
            bobmods.lib.tech.add_recipe_unlock("bronze-processing", "pipe-bronze-junction")
            bobmods.lib.tech.add_recipe_unlock("bronze-processing", "pipe-bronze-elbow")
        end

        if settings.startup["bobmods-logistics-beltoverhaul"].value then
            bobmods.lib.tech.add_prerequisite("logistics-2", "bronze-processing")
        elseif settings.startup["bobmods-logistics-inserteroverhaul"].value then
            bobmods.lib.tech.add_prerequisite("fast-inserter", "bronze-processing")
        end
    end

    -- move lubricant unlock to vanilla lubricant tech
    bobmods.lib.tech.remove_recipe_unlock("angels-oil-processing", "mineral-oil-lubricant")
    bobmods.lib.tech.add_recipe_unlock("lubricant", "mineral-oil-lubricant")
    bobmods.lib.tech.replace_prerequisite("ore-powderizer", "angels-oil-processing", "lubricant")

    -- add advanced fuel refining tech for liquid fuel
    bobmods.lib.tech.remove_recipe_unlock("angels-oil-processing", "liquid-fuel")
    bobmods.lib.tech.remove_recipe_unlock("chemical-processing-3", "enriched-fuel-from-liquid-fuel")
    bobmods.lib.tech.remove_recipe_unlock("advanced-material-processing-2", "enriched-fuel-from-liquid-fuel")
    data:extend{
        {
            type = "technology",
            name = "advanced-fuel-refining",
            icon = "__Hexy_AngelBob_Tweaks__/graphics/technology/advanced-fuel-refining.png",
            icon_size = 128,
            prerequisites =
            {
                "flammables"
            },
            effects =
            {
                {
                    type = "unlock-recipe",
                    recipe = "liquid-fuel"
                },
                {
                    type = "unlock-recipe",
                    recipe = "enriched-fuel-from-liquid-fuel"
                },
            },
            unit =
            {
                count = 75,
                ingredients =
                {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                },
                time = 30
            },
            order = "e-d"
        }
    }
    -- if bobwarfare isn't present, this does nothing
    bobmods.lib.tech.add_prerequisite("military-3", "advanced-fuel-refining")
    bobmods.lib.tech.add_prerequisite("bob-rocket", "advanced-fuel-refining")

    -- make plastic pipes depend on angel's plastic I tech
    bobmods.lib.tech.replace_prerequisite("plastics", "angels-oil-processing", "plastic-1")

    -- rename zinc processing to brass processing
    data.raw.technology["zinc-processing"].localised_name = {"technology-name.brass-processing"}
    -- remove unnecessary prereq
    bobmods.lib.tech.remove_prerequisite("zinc-processing", "angels-sulfur-processing-1")

    -- rename cobalt processing to cobalt steel processing
    data.raw.technology["cobalt-processing"].localised_name = {"technology-name.cobalt-steel-processing"}

    -- tweak nitinol processing tech
    bobmods.lib.tech.remove_prerequisite("nitinol-processing", "titanium-processing")
    bobmods.lib.tech.remove_prerequisite("nitinol-processing", "angels-nickel-smelting-1")

    if mods["bobwarfare"] then
        -- disable bob's higher tier armor techs, as they are useless
        data.raw.technology["bob-armor-making-3"].enabled = false
        data.raw.technology["bob-armor-making-4"].enabled = false

        -- move rocket engine to bob's rocket tech
        bobmods.lib.tech.remove_recipe_unlock("rocketry", "rocket-engine")
        bobmods.lib.tech.add_recipe_unlock("bob-rocket", "rocket-engine")

        -- tweak nitroglycerin tech
        bobmods.lib.tech.add_prerequisite("nitroglycerin-processing", "military-3")
        bobmods.lib.tech.add_science_pack("nitroglycerin-processing", "chemical-science-pack", 1)

        -- add chem science pack to descendants of nitroglycerin tech
        bobmods.lib.tech.add_science_pack("angels-explosives-1", "chemical-science-pack", 1)
        bobmods.lib.tech.add_science_pack("cordite-processing", "chemical-science-pack", 1)
        bobmods.lib.tech.add_science_pack("bob-bullets", "chemical-science-pack", 1)
        bobmods.lib.tech.add_science_pack("bob-shotgun-shells", "chemical-science-pack", 1)
        bobmods.lib.tech.add_science_pack("bob-rocket", "chemical-science-pack", 1)

        -- split uranium ammo tech
        data.raw.technology["uranium-ammo"].enabled = false
        data:extend{
            {
                type = "technology",
                name = "uranium-bullets",
                icon = "__Hexy_AngelBob_Tweaks__/graphics/technology/uranium-bullets.png",
                icon_size = 128,
                prerequisites =
                {
                    "bob-bullets",
                    "uranium-processing",
                    "military-4"
                },
                effects =
                {
                    {
                        type = "unlock-recipe",
                        recipe = "uranium-bullet-projectile"
                    },
                    {
                        type = "unlock-recipe",
                        recipe = "uranium-bullet"
                    },
                    {
                        type = "unlock-recipe",
                        recipe = "uranium-rounds-magazine"
                    },
                },
                unit =
                {
                    count = 500,
                    ingredients =
                    {
                        {"automation-science-pack", 1},
                        {"logistic-science-pack", 1},
                        {"military-science-pack", 1},
                        {"chemical-science-pack", 1},
                        {"utility-science-pack", 1},
                    },
                    time = 30
                },
                order = "d"
            },
            {
                type = "technology",
                name = "bob-shotgun-uranium-shells",
                icon = "__Hexy_AngelBob_Tweaks__/graphics/technology/bob-shotgun-uranium-shells.png",
                icon_size = 128,
                prerequisites =
                {
                    "bob-shotgun-shells",
                    "uranium-processing",
                    "military-4"
                },
                effects =
                {
                    {
                        type = "unlock-recipe",
                        recipe = "shotgun-uranium-shell"
                    },
                },
                unit =
                {
                    count = 500,
                    ingredients =
                    {
                        {"automation-science-pack", 1},
                        {"logistic-science-pack", 1},
                        {"military-science-pack", 1},
                        {"chemical-science-pack", 1},
                        {"utility-science-pack", 1},
                    },
                    time = 30
                },
                order = "d"
            },
            {
                type = "technology",
                name = "uranium-cannon-shells",
                icon = "__Hexy_AngelBob_Tweaks__/graphics/technology/uranium-cannon-shells.png",
                icon_size = 128,
                prerequisites =
                {
                    "tanks",
                    "uranium-processing",
                    "military-4"
                },
                effects =
                {
                    {
                        type = "unlock-recipe",
                        recipe = "uranium-cannon-shell"
                    },
                    {
                        type = "unlock-recipe",
                        recipe = "explosive-uranium-cannon-shell"
                    },
                },
                unit =
                {
                    count = 500,
                    ingredients =
                    {
                        {"automation-science-pack", 1},
                        {"logistic-science-pack", 1},
                        {"military-science-pack", 1},
                        {"chemical-science-pack", 1},
                        {"utility-science-pack", 1},
                    },
                    time = 30
                },
                order = "d"
            }
        }
    end

    if mods["bobequipment"] then
        -- make personal roboport equipment require modular roboport techs
        for i, personal_roboport_tech in pairs({
            "personal-roboport-equipment",
            "personal-roboport-mk2-equipment",
            "personal-roboport-mk3-equipment",
            "personal-roboport-mk4-equipment"
        }) do
            bobmods.lib.tech.add_prerequisite(personal_roboport_tech, "bob-robo-modular-"..i)
            bobmods.lib.tech.remove_recipe_unlock(personal_roboport_tech, "roboport-antenna-"..i)
            bobmods.lib.tech.remove_recipe_unlock(personal_roboport_tech, "roboport-chargepad-"..i)
            bobmods.lib.tech.remove_recipe_unlock(personal_roboport_tech, "roboport-door-"..i)
        end

        -- tweak bob's equipment techs
        bobmods.lib.tech.remove_prerequisite("personal-laser-defense-equipment", "low-density-structure")
        bobmods.lib.tech.add_science_pack("fusion-reactor-equipment-2", "military-science-pack", 1)
    end

    if mods["bobvehicleequipment"] then
        -- make personal/vehicle roboport equipment require modular roboport techs
        for i, vehicle_roboport_tech in pairs({
            "vehicle-roboport-equipment",
            "vehicle-roboport-equipment-2",
            "vehicle-roboport-equipment-3",
            "vehicle-roboport-equipment-4"
        }) do
            bobmods.lib.tech.add_prerequisite(vehicle_roboport_tech, "bob-robo-modular-"..i)
            bobmods.lib.tech.remove_recipe_unlock(vehicle_roboport_tech, "roboport-antenna-"..i)
            bobmods.lib.tech.remove_recipe_unlock(vehicle_roboport_tech, "roboport-chargepad-"..i)
            bobmods.lib.tech.remove_recipe_unlock(vehicle_roboport_tech, "roboport-door-"..i)
        end

        -- tweak bob's vehicle equipment techs
        bobmods.lib.tech.add_prerequisite("vehicle-solar-panel-equipment-1", "solar-energy")
        bobmods.lib.tech.add_prerequisite("vehicle-solar-panel-equipment-1", "automobilism")
        bobmods.lib.tech.add_prerequisite("vehicle-laser-defense-equipment-1", "military-3")
        bobmods.lib.tech.add_science_pack("vehicle-laser-defense-equipment-4", "utility-science-pack", 1)
        bobmods.lib.tech.add_science_pack("vehicle-laser-defense-equipment-5", "utility-science-pack", 1)
        bobmods.lib.tech.replace_prerequisite("vehicle-big-turret-equipment-1", "laser-turrets", "bob-plasma-turrets-1")
        for i = 1, 6 do
            if i ~= 1 then
                data.raw.technology["vehicle-fusion-reactor-equipment-"..i].unit = data.raw.technology["fusion-reactor-equipment-2"].unit
                data.raw.technology["vehicle-fusion-cell-equipment-"..i].unit = data.raw.technology["fusion-reactor-equipment-2"].unit
            else
                data.raw.technology["vehicle-fusion-reactor-equipment-"..i].unit = data.raw.technology["fusion-reactor-equipment"].unit
                data.raw.technology["vehicle-fusion-cell-equipment-"..i].unit = data.raw.technology["fusion-reactor-equipment"].unit
            end
        end
    end

    if mods["angelsindustries"] then
        -- tweak Angel's industries techs
        bobmods.lib.tech.add_prerequisite("angels-vequipment-1", "electronics")
        bobmods.lib.tech.add_prerequisite("angels-crawler", "cargo-robots")
        bobmods.lib.tech.add_prerequisite("cargo-robots", "electronics")
        bobmods.lib.tech.add_prerequisite("cargo-robots-2", "advanced-electronics")
    end

    -- remove arty shells from tank techs?
end

if settings.startup["connect-science-pack-techs"].value then
    local pack_priorities = {
        ["automation-science-pack"] = 1,
        ["logistic-science-pack"] = 2,
        ["military-science-pack"] = 3,
        ["chemical-science-pack"] = 4,
        ["production-science-pack"] = 5,
        ["advanced-logistic-science-pack"] = 6,
        ["utility-science-pack"] = 7,
    }
    local lowest_pack, second_lowest_pack
    if settings.startup["bobmods-burnerphase"].value then
        pack_priorities["steam-science-pack"] = 0
        lowest_pack = "steam-science-pack"
        second_lowest_pack = "automation-science-pack"
    else
        lowest_pack = "automation-science-pack"
        second_lowest_pack = "logistic-science-pack"
    end
    -- return the highest science pack the tech uses
    -- red science tech returns automation-science-pack
    -- green science tech returns logistic-science-pack
    -- ...
    local function tech_get_highest_pack(tech)
        local pack_pairs = tech["unit"]["ingredients"]
        local highest_pack = lowest_pack
        for _, pack_pair in pairs(pack_pairs) do
            if not pack_priorities[pack_pair[1]] then
                return nil
            elseif pack_priorities[pack_pair[1]] >= pack_priorities[highest_pack] then
                highest_pack = pack_pair[1]
            end
        end
        return highest_pack
    end

    -- return the level of the science pack minus the level of the tech.
    -- Ex. science_pack is green science
    -- red science tech returns -1
    -- green science tech returns 0
    -- gray science tech returns 1
    -- blue science tech returns 2
    -- ...
    local function tech_compare_science_pack(tech, science_pack)
        return pack_priorities[science_pack] - pack_priorities[tech_get_highest_pack(tech)]
    end

    local function is_tech_science_pack_tech(tech, science_pack)
        return pack_priorities[tech.name] == pack_priorities[science_pack]
    end

    -- if tech level of prerequisites is <= tech level of tech for every prereq
    -- and doesn't already have science pack tech, add requirement
    for _, tech in pairs(data.raw.technology) do
        -- exclude chains of research where this isn't the first in the chain
        if not string.match(tech.name, "-[02-9]") then
            -- exclude space science, modules, bio tech tokens
            tech_highest_pack = tech_get_highest_pack(tech)
            -- exclude lowest science techs
            if tech_highest_pack and tech_highest_pack ~= lowest_pack then
                if tech.prerequisites then
                    -- if prereqs, find highest pack in prereqs
                    prereqs_highest_pack = lowest_pack
                    for _, prereq_name in pairs(tech.prerequisites) do
                        prereq = data.raw.technology[prereq_name]
                        if is_tech_science_pack_tech(prereq, tech_highest_pack) then
                            -- break if correct science pack tech is already present
                            break
                        elseif tech_get_highest_pack(prereq) and pack_priorities[tech_get_highest_pack(prereq)] > pack_priorities[prereqs_highest_pack] then
                            -- increase highest pack if prereq has higher pack
                            prereqs_highest_pack = tech_get_highest_pack(prereq)
                        end
                    end
                    -- are prereqs highest pack lower priority than the tech
                    -- highest pack?
                    if tech_compare_science_pack(tech, prereqs_highest_pack) < 0 then
                        bobmods.lib.tech.add_prerequisite(tech.name, tech_highest_pack)
                    end
                    -- if not, no need to do anything
                elseif tech_compare_science_pack(tech, second_lowest_pack) >= 0 then
                    -- if no prereqs, then if pack is logistic or higher,
                    -- needs to be attached to pack tech
                    bobmods.lib.tech.add_prerequisite(tech.name, tech_highest_pack)
                end
            end
        end
    end
end