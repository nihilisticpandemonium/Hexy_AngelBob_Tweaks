function disable_techs(force, tech_list)
    for _, tech_name in pairs(tech_list) do
        if force.technologies[tech_name] then
            force.technologies[tech_name].researched = false
            force.technologies[tech_name].enabled = false
        else
            log("disable_techs: technology '"..tech_name.."' does not exist.")
        end
    end
end

function disable_techs_if_option(force, option, tech_list)
    if not settings.startup[option] then
        log("disable_techs_if_option: option '"..option.."' does not exist.")
    elseif settings.startup[option].value then
        for _, tech_name in pairs(tech_list) do
            if force.technologies[tech_name] then
                log("disable_techs_if_option: disabling "..tech_name)
                force.technologies[tech_name].researched = false
                force.technologies[tech_name].enabled = false
            else
                log("disable_techs_if_option for option '"..option.."': technology '"..tech_name.."' does not exist.")
            end
        end
    end
end

for _, force in pairs(game.forces) do
    disable_techs_if_option(force, "chem-plant-tweaks", {
        "chemical-plant",
        "chemical-plant-2",
        "chemical-plant-3",
        "chemical-plant-4",
    })

    disable_techs_if_option(force, "liquid-fuel-deuterium-barrels", {
        "gas-canisters"
    })

    if settings.startup["remove-angels-alien"].value then
        disable_techs(force, {
            "bio-biter-small",
            "bio-biter-medium",
            "bio-biter-big",
        })
        if not game.item_prototypes["alien-artifact"] then
            disable_techs(force, {
                "bio-processing-alien",
                "bio-processing-paste"
            })
        end
    end

    disable_techs_if_option(force, "remove-coal-liquefaction", {
        "coal-liquefaction"
    })

    disable_techs_if_option(force, "remove-bobs-water-bores", {
        "water-bore-1",
        "water-bore-2",
        "water-bore-3",
        "water-bore-4"
    })

    disable_techs_if_option(force, "remove-bobs-beacons", {
        "effect-transmission-2",
        "effect-transmission-3",
    })

    disable_techs_if_option(force, "remove-bobs-repair-packs", {
        "bob-repair-pack-2",
        "bob-repair-pack-3",
        "bob-repair-pack-4",
        "bob-repair-pack-5"
    })

    disable_techs_if_option(force, "remove-bobs-electrolyzers", {
        "electrolysis-1",
        "electrolysis-2",
        "electrolyser-2",
        "electrolyser-3",
        "electrolyser-4",
    })

    -- alloy processing 1 is conditional on my multipurpose furnace mod
    -- uranium ammo is conditional on bobwarfare
    if settings.startup["tech-cleanup"].value then
        disable_techs(force, {
            "mixing-steel-furnace",
            "bob-armor-making-3",
            "bob-armor-making-4",
        })
        if force.technologies["uranium-bullets"] then
            disable_techs(force, {"uranium-ammo"})
        end
        if not game.technology_prototypes["alloy-processing-1"].enabled then
            disable_techs(force, {"alloy-processing-1"})
        end
    end
end