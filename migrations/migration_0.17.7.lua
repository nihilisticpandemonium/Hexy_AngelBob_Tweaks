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
    -- required again for MomoTweak
    if settings.startup["tech-cleanup"].value and not game.technology_prototypes["alloy-processing-1"].enabled then
        disable_techs(force, {"alloy-processing-1"})
    end
end