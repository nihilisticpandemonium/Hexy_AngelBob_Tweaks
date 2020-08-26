-- based on https://stackoverflow.com/a/53038524 by Mitch McMabers
function remove_productivity(recipes)
    remove_recipe = {}
    for _, recipe in pairs(recipes) do
        remove_recipe[recipe] = true
    end
    for _, module in pairs(data.raw.module) do
        if module.limitation and module.effect.productivity then
            local j = 1
            for i=1, #module.limitation do
                recipe = module.limitation[i]
                if remove_recipe[recipe] then
                    module.limitation[i] = nil
                else
                    if i ~= j then
                        module.limitation[j] = module.limitation[i]
                        module.limitation[i] = nil
                    end
                    j = j + 1
                end
            end
        end
    end
end

if settings.startup["productivity-tweaks"].value then
    remove_productivity{
        "heavy-water-electrolysis",
        "explosives",
        "calcium-chloride",
        "lithium-cobalt-oxide",
        "solid-rubber",
    }
    bobmods.lib.module.add_productivity_limitation("liquid-rubber-1")
end

if settings.startup["remove-bob-warfare-productivity"].value then
    remove_productivity{
        "nitroglycerin",
        "petroleum-jelly",
        "gun-cotton",
        "cordite",
        "bullet-casing",
        "magazine",
        "bullet-projectile",
        "ap-bullet-projectile",
        "he-bullet-projectile",
        "flame-bullet-projectile",
        "acid-bullet-projectile",
        "poison-bullet-projectile",
        "electric-bullet-projectile",
        "shotgun-shell-casing",
        "shot",
        "laser-rifle-battery-case",
        "rocket-engine",
        "rocket-body",
        "rocket-warhead",
        "piercing-rocket-warhead",
        "explosive-rocket-warhead",
        "acid-rocket-warhead",
        "flame-rocket-warhead",
        "poison-rocket-warhead",
        "electric-rocket-warhead",
    }
end