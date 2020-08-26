local setting_order_string = "aa"

local function inc_order_string()
    if setting_order_string:sub(2,2) == "z" then
        setting_order_string = string.char(setting_order_string:byte(1) + 1).."a"
    else
        setting_order_string = setting_order_string:sub(1,1)..string.char(setting_order_string:byte(2) + 1)
    end
end

local function add_bool_setting(setting_name, default)
    data:extend({
        {
            type = "bool-setting",
            name = setting_name,
            setting_type = "startup",
            order = setting_order_string,
            default_value = default,
        },
    })
    inc_order_string()
end

add_bool_setting("gather-gemstone-intermediates", true)
add_bool_setting("remove-bobs-fluids-materials", true)
add_bool_setting("add-nuclear-tab", true)
add_bool_setting("move-offshore-pump", true)
add_bool_setting("move-ore-silos-warehouses", true)
add_bool_setting("move-rocket-silo", true)
add_bool_setting("reorganize-military", true)
add_bool_setting("merge-intermediates", true)
add_bool_setting("reorganize-logistics", true)
add_bool_setting("productivity-tweaks", true)
add_bool_setting("remove-bob-warfare-productivity", true)
add_bool_setting("fix-rubber-resin-texture", true)
add_bool_setting("merge-angels-industries", true)
add_bool_setting("angels-sludge-fix", true)
add_bool_setting("clarify-nutrient-pulp", true)
add_bool_setting("remove-ingredient-limits", true)

add_bool_setting("remove-bobs-valves", false)
add_bool_setting("remove-bobs-electrolyzers", false)
add_bool_setting("remove-bobs-water-bores", false)
add_bool_setting("remove-bobs-small-tanks", false)
add_bool_setting("remove-bobs-repair-packs", false)
add_bool_setting("remove-bobs-beacons", false)
add_bool_setting("remove-angels-fish", false)
add_bool_setting("remove-angels-meat", false)
add_bool_setting("remove-angels-alien", false)
add_bool_setting("remove-angels-paste", false)
add_bool_setting("remove-phosgene", false)
add_bool_setting("remove-ammonium-chloride", false)
add_bool_setting("remove-coal-liquefaction", false)
add_bool_setting("remove-angels-calcium-chloride", false)
add_bool_setting("remove-glass-fiber", false)
add_bool_setting("angels-casting-cleanup", false)

add_bool_setting("easier-lead-3-smelting", false)
add_bool_setting("new-nitroglycerin-recipe", false)
add_bool_setting("new-deuterium-recipe", false)
add_bool_setting("new-lithium-recipes", false)
add_bool_setting("liquid-fuel-deuterium-barrels", false)
add_bool_setting("rubber-resin-tweaks", false)
add_bool_setting("silicon-wafer-tweaks", false)
add_bool_setting("solder-tweaks", false)
add_bool_setting("bob-assembler-tweaks", false)
add_bool_setting("chem-plant-tweaks", false)
add_bool_setting("angels-fertilizer-for-bobs-greenhouse", false)
add_bool_setting("tech-cleanup", false)
add_bool_setting("connect-science-pack-techs", false)
add_bool_setting("stone-brick-tweaks", false)
add_bool_setting("cheaper-gem-crystallization", false)
add_bool_setting("fix-ceramic-filtering", false)
add_bool_setting("hybrid-catalyst-in-assembling-machine", false)