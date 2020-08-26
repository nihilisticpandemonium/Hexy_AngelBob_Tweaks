-- if a recipe doesn't have an order/subgroup defined, it either must be a part
-- of the only result of the recipe or a part of the main product of the recipe.
-- in either case, we want to explicitly set the order and subgroup of the
-- recipe to make life easier.
local function resolve_order_subgroup(recipe)
    if not recipe.order or not recipe.subgroup then
        -- local vars
        local result_item_type, result_name
        if recipe.main_product then
            -- if main product, then it has order info
            result_name = recipe.main_product
        else
            -- otherwise, we need to figure out where "results" is depending on difficulty defined
            local recipe_data
            if recipe.normal then
                recipe_data = recipe.normal
            elseif recipe.expensive then
                recipe_data = recipe.expensive
            else
                recipe_data = recipe
            end

            -- results could either be result or results[1][1] if item, or also results[1]["name"] for items and fluids
            if recipe_data.result then
                result_name = recipe_data.result
            elseif recipe_data.results[1][1] then
                result_name = recipe_data.results[1][1]
            else
                result_name = recipe_data.results[1]["name"]
            end
        end

        -- we also need the item type to access item
        result_item_type = bobmods.lib.item.get_type(result_name)

        -- reassign order
        if not recipe.order then
            recipe.order = data.raw[result_item_type][result_name].order
        end

        -- reassign subgroup
        if not recipe.subgroup then
            recipe.subgroup = data.raw[result_item_type][result_name].subgroup
        end
    end
end

local function sort_between(recipe_name, before_name, after_name)
    local recipe, before, after
    if recipe_name then
        recipe = data.raw.recipe[recipe_name]
        if not recipe then
            log("\n!!!!!!! sort_between recipe: "..recipe_name.." doesn't exist !!!!!!!!\n")
            return
        end
    end
    if before_name then
        before = data.raw.recipe[before_name]
        if not before then
            log("\n!!!!!!! sort_between before: "..before_name.." doesn't exist !!!!!!!!\n")
            return
        end
        resolve_order_subgroup(before)
    end
    if after_name then
        after = data.raw.recipe[after_name]
        if not after then
            log("\n!!!!!!! sort_between after:  "..after_name.." doesn't exist !!!!!!!!\n")
            return
        end
        resolve_order_subgroup(after)
    end

    -- missing first arg, this is invalid
    if not recipe then
        log("\n!!!!!!! sort_between called without recipe !!!!!!!!\n")
    -- missing both args, this is invalid
    elseif not after and not before then
        log("\n!!!!!!! sort_between called on "..recipe.name.." with no before or after !!!!!!!!\n")
    -- just before
    elseif not after then
        recipe.subgroup = before.subgroup
        local last_letter_ascii = before.order:byte(-1)
        -- already at last ascii printable character? add a character
        if last_letter_ascii == 126 then
            recipe.order = before.." "
        else
            recipe.order = before.order:sub(1, -2)..string.char(last_letter_ascii + 1)
        end
    -- just after
    elseif not before then
        recipe.subgroup = after.subgroup
        local last_letter_ascii = after.order:byte(-1)
        -- already at first ascii printable character? lose a character
        if last_letter_ascii == 33 then
            recipe.order = after.order:sub(1, -3).."~"
        else
            recipe.order = after.order:sub(1, -2)..string.char(last_letter_ascii - 1)
        end
    -- have both, but subgroups don't match, this is invalid
    elseif before.subgroup ~= after.subgroup then
        log("\n!!!!!!! sort_between called on "..recipe.name..", "..before.name..", "..after.name.." but before and after are in different subgroups !!!!!!!\n")
    -- have both
    else
        recipe.subgroup = before.subgroup
        local last_letter_ascii = before.order:byte(-1)
        -- order strings are same or 1 char apart, so no guarantee of sort between
        if before.order:len() == after.order:len() and last_letter_ascii + 1 >= after.order:byte(-1) then
            log("\n!!!!!!! sort_between called on "..recipe.name..", "..before.name..", "..after.name.." order strings are too close to guarantee between, defaulting to after's order string !!!!!!!\n")
            recipe.order = after.order
        -- otherwise, we are good
        else
            -- already at last ascii printable character? add a character
            if last_letter_ascii == 126 then
                recipe.order = before.." "
            else
                recipe.order = before.order:sub(1, -2)..string.char(last_letter_ascii + 1)
            end
        end
    end
end

local function sort_after(recipe_name, before_name)
    sort_between(recipe_name, before_name, nil)
end

local function sort_before(recipe_name, after_name)
    sort_between(recipe_name, nil, after_name)
end

local function sort_chain(array)
    for i = 2, #array do
        sort_after(array[i], array[i-1])
    end
end

local function sort_chain_reverse(array)
    for i = #array, 2, -1 do
        sort_before(array[i-1], array[i])
    end
end

local function set_subgroup(subgroup, array)
    local first_recipe = data.raw.recipe[array[1]]
    if first_recipe then
        resolve_order_subgroup(first_recipe)
        first_recipe.subgroup = subgroup
        first_recipe.order = "a"
        if #array > 1 then
            sort_chain(array)
        end
    else
        log("\n!!!!!!! set_subgroup first recipe: "..array[1].." doesn't exist !!!!!!!!\n")
    end
end

local function move_subgroup(subgroup_name, new_group, new_order)
    subgroup = data.raw["item-subgroup"][subgroup_name]
    if subgroup then
        if data.raw["item-group"][new_group] then
            subgroup.group = new_group
            subgroup.order = new_order
        else
            log("\n!!!!!!! move_subgroup new_group: "..new_group.." doesn't exist !!!!!!!!\n")
        end
    else
        log("\n!!!!!!! move_subgroup subgroup: "..subgroup_name.." doesn't exist !!!!!!!!\n")
    end
end

if settings.startup["gather-gemstone-intermediates"].value then
    sort_chain{
        "sort-gem-ore",
        "silicon-carbide",
        "grinding-wheel",
        "polishing-compound",
        "polishing-wheel"
    }
    sort_after("sort-gem-ore", "geode-red-processing")
end

if settings.startup["remove-bobs-fluids-materials"].value then
    sort_chain{
        "water-gas-shift-2",
        "bob-heavy-water",
        "heavy-water-electrolysis"
    }
    sort_chain{
        "mineral-oil-lubricant",
        "liquid-fuel",
        "enriched-fuel-from-liquid-fuel"
    }

    if settings.startup["new-nitroglycerin-recipe"].value then
        sort_after("nitroglycerin", "gas-glycerol")
    else
        sort_chain{
            "gas-glycerol",
            "sulfuric-nitric-acid",
            "nitroglycerin"
        }
    end

    sort_chain{
        "angels-quartz-crucible",
        "silicon-powder",
        "silicon-nitride"
    }
    sort_chain{
        "angels-plate-tungsten",
        "copper-tungsten-alloy",
        "tungsten-carbide",
        "tungsten-carbide-2"
    }
    sort_after("solder-alloy-lead", "angels-roll-solder-converting")

    sort_between("synthetic-wood", "catalyst-steam-cracking-naphtha", "steam-cracking-naphtha")

    sort_between("calcium-chloride", "carbon-separation-2", "water-gas-shift-1")

    sort_after("thorium-processing", "uranium-processing")

    if mods["bobelectronics"] then
        sort_chain_reverse{
            "bob-resin-wood",
            "bob-rubber",
            "silicon-wafer",
            "tinned-copper-cable"
        }
    else
        sort_chain_reverse{
            "bob-resin-wood",
            "bob-rubber",
            "silicon-wafer",
            "electronic-circuit"
        }
    end
    sort_chain_reverse{
        "gun-cotton",
        "petroleum-jelly",
        "cordite"
    }

    sort_between("bob-fertiliser", "bob-basic-greenhouse-cycle", "bob-advanced-greenhouse-cycle")

    local perchlorate_recipe, lithium_enabled
    if settings.startup["new-lithium-recipes"].value then
        perchlorate_recipe = "lithium-perchlorate"
        lithium_enabled = false
    else
        perchlorate_recipe = "lithium-water-electrolysis"
        lithium_enabled = true
    end
    sort_chain_reverse{
        "lithium-chloride",
        perchlorate_recipe,
        "lithium-cobalt-oxide",
        "lithium-ion-battery",
        "silver-nitrate",
        "silver-oxide",
        "silver-zinc-battery"
    }
    if lithium_enabled then
        sort_between("lithium", perchlorate_recipe, "lithium-cobalt-oxide")
    end

    if mods["bobenemies"] then
        data:extend{
            {
                type = "item-subgroup",
                name = "alien-artifacts-from-small",
                group = "intermediate-products",
                order = "c-a",
            },
            {
                type = "item-subgroup",
                name = "alien-artifacts-from-basic",
                group = "intermediate-products",
                order = "c-b",
            },
        }

        set_subgroup("alien-artifacts-from-small", {
            "alien-artifact-red-from-small",
            "alien-artifact-orange-from-small",
            "alien-artifact-yellow-from-small",
            "alien-artifact-green-from-small",
            "alien-artifact-blue-from-small",
            "alien-artifact-purple-from-small",
            "alien-artifact-from-small",
        })

        set_subgroup("alien-artifacts-from-basic", {
            "alien-artifact-red-from-basic",
            "alien-artifact-orange-from-basic",
            "alien-artifact-yellow-from-basic",
            "alien-artifact-green-from-basic",
            "alien-artifact-blue-from-basic",
            "alien-artifact-purple-from-basic",
        })

        if mods["angelsbioprocessing"] then
            sort_after("paste-cellulose", "petri-dish")
            sort_chain{
                "paste-tungsten",
                "paste-zinc",
                "paste-cobalt",
                "paste-titanium"
            }
            sort_chain{
                "alien-pre-artifact-orange",
                "alien-pre-artifact-green",
                "alien-pre-artifact-blue",
                "alien-pre-artifact-purple",
            }
            sort_chain{
                "small-alien-artifact-orange",
                "small-alien-artifact-green",
                "small-alien-artifact-blue",
                "small-alien-artifact-purple",
            }
            move_subgroup("alien-artifacts-from-small", "bio-processing-alien", "j")
            move_subgroup("alien-artifacts-from-basic", "bio-processing-alien", "k")
        end

        if settings.startup["reorganize-military"].value then
            move_subgroup("bob-alien-resource", "combat", "a-c")
            if not mods["angelsbioprocessing"] then
                move_subgroup("alien-artifacts-from-small", "combat", "a-a")
                move_subgroup("alien-artifacts-from-basic", "combat", "a-b")
            end
        else
            move_subgroup("bob-alien-resource", "intermediate-products", "c-c")
        end
        set_subgroup("bob-alien-resource", {
            "alien-fire",
            "alien-orange-alloy",
            "alien-explosive",
            "alien-poison",
            "alien-blue-alloy",
            "alien-acid"
        })
    end

    move_subgroup("bob-fluid-pump", "water-treatment", "Z")

    move_subgroup("bob-gas-bottle", "angels-fluid-control", "f")
    move_subgroup("bob-empty-gas-bottle", "angels-fluid-control", "g")
end

if settings.startup["add-nuclear-tab"].value then
    data:extend{
        {
            type = "item-group",
            name = "nuclear",
            order = "b-a",
            inventory_order = "b-a",
            icon = "__Hexy_AngelBob_Tweaks__/graphics/item-group/nuclear.png",
            icon_size = 128,
        },
        {
            type = "item-subgroup",
            name = "centrifuges",
            group = "nuclear",
            order = "a",
        },
        {
            type = "item-subgroup",
            name = "nuclear-reactors",
            group = "nuclear",
            order = "b",
        },
        {
            type = "item-subgroup",
            name = "heat-pipes",
            group = "nuclear",
            order = "c",
        },
        {
            type = "item-subgroup",
            name = "heat-exchangers",
            group = "nuclear",
            order = "d",
        },
        {
            type = "item-subgroup",
            name = "steam-turbines",
            group = "nuclear",
            order = "e",
        },
        {
            type = "item-subgroup",
            name = "uranium-processing",
            group = "nuclear",
            order = "f",
        },
        {
            type = "item-subgroup",
            name = "thorium-processing",
            group = "nuclear",
            order = "g",
        },
        {
            type = "item-subgroup",
            name = "deuterium-processing",
            group = "nuclear",
            order = "h",
        },
    }

    set_subgroup("centrifuges", {"centrifuge"})

    set_subgroup("nuclear-reactors", {
        "nuclear-reactor",
        "nuclear-reactor-2",
        "nuclear-reactor-3"
    })

    set_subgroup("heat-pipes", {
        "heat-pipe",
        "heat-pipe-2",
        "heat-pipe-3"
    })

    set_subgroup("heat-exchangers", {
        "heat-exchanger",
        "heat-exchanger-2",
        "heat-exchanger-3"
    })

    set_subgroup("steam-turbines", {
        "steam-turbine",
        "steam-turbine-2",
        "steam-turbine-3"
    })

    set_subgroup("uranium-processing", {
        "uranium-processing",
        "uranium-fuel-cell",
        "nuclear-fuel-reprocessing",
        "kovarex-enrichment-process",
        "nuclear-fuel"
    })

    set_subgroup("thorium-processing", {
        "thorium-processing",
        "thorium-fuel-cell",
        "thorium-plutonium-fuel-cell",
        "thorium-fuel-reprocessing",
        "bobingabout-enrichment-process"
    })

    set_subgroup("deuterium-processing", {
        "deuterium-fuel-cell",
        "deuterium-fuel-reprocessing"
    })

    -- nuclear fuel mod added by seablock
    if mods["Nuclear Fuel"] then
        data:extend{
            {
                type = "item-subgroup",
                name = "plutonium-processing",
                group = "nuclear",
                order = "f-a",
            },
        }

        sort_after("mox-fuel-cell", "uranium-fuel-cell")
        set_subgroup("plutonium-processing", {
            "breeder-fuel-cell",
            "breeder-fuel-reprocessing",
            "nuclear-fuel-pu"
        })
    end
end

if settings.startup["move-offshore-pump"].value then
    sort_before("offshore-pump", "hydro-plant")
end

if settings.startup["move-rocket-silo"].value then
    if mods["bobmodules"] then
        sort_after("rocket-silo", "lab-module")
    else
        sort_after("rocket-silo", "lab-2")
    end
end

local function gen_tiers_include_1(pattern, limit)
    local tiers = {}
    for i = 1, limit do
        tiers[i] = pattern:gsub("*", i)
    end
    return tiers
end

local function gen_tiers(base_pattern, tier_pattern, limit)
    local tiers = {}
    for i = 1, limit do
        if i == 1 then
            tiers[i] = base_pattern:gsub("*", "")
        else
            tiers[i] = base_pattern:gsub("*", tier_pattern):gsub("*", i)
        end
    end
    return tiers
end

if settings.startup["reorganize-military"].value then
    -- military tab subgroups/sort orders
    -- gun, a
    -- ammo, b
    -- bob-ammo, b-a
    -- capsule, c
    -- bob-combat-robots, c-b
    -- armor, d
    -- equipment, e
    -- vehicle-equipment, e-v
    -- defensive-structure, f
    data:extend{
        {
            type = "item-subgroup",
            name = "ammo-basic-intermediates",
            group = "combat",
            order = "a",
        },
        {
            type = "item-subgroup",
            name = "bullet-guns",
            group = "combat",
            order = "b-a",
        },
        {
            type = "item-subgroup",
            name = "bob-bullet-projectiles",
            group = "combat",
            order = "b-b",
        },
        {
            type = "item-subgroup",
            name = "bob-bullets",
            group = "combat",
            order = "b-c",
        },
        {
            type = "item-subgroup",
            name = "bob-bullet-magazines",
            group = "combat",
            order = "b-c-a",
        },
        {
            type = "item-subgroup",
            name = "shotguns",
            group = "combat",
            order = "b-d",
        },
        {
            type = "item-subgroup",
            name = "bob-shotgun-shells",
            group = "combat",
            order = "b-e",
        },
        {
            type = "item-subgroup",
            name = "rocket-launchers",
            group = "combat",
            order = "b-f",
        },
        {
            type = "item-subgroup",
            name = "bob-rocket-warheads",
            group = "combat",
            order = "b-g",
        },
        {
            type = "item-subgroup",
            name = "bob-rockets",
            group = "combat",
            order = "b-h",
        },
        {
            type = "item-subgroup",
            name = "laser-rifle",
            group = "combat",
            order = "b-i",
        },
        {
            type = "item-subgroup",
            name = "flamethrower",
            group = "combat",
            order = "b-j",
        },
        {
            type = "item-subgroup",
            name = "capsules",
            group = "combat",
            order = "c-a",
        },
        {
            type = "item-subgroup",
            name = "combat-robots",
            group = "combat",
            order = "c-b",
        },
        {
            type = "item-subgroup",
            name = "combat-robot-capsules",
            group = "combat",
            order = "c-c",
        },
        {
            type = "item-subgroup",
            name = "robot-attack-drones",
            group = "combat",
            order = "c-d",
        },
        {
            type = "item-subgroup",
            name = "mines",
            group = "combat",
            order = "c-e",
        },
        {
            type = "item-subgroup",
            name = "arty-shells",
            group = "combat",
            order = "c-f",
        },
        {
            type = "item-subgroup",
            name = "tank-shells",
            group = "combat",
            order = "c-g",
        },
    }

    set_subgroup("ammo-basic-intermediates", {
        "gun-cotton",
        "petroleum-jelly",
        "cordite",
        "bullet-casing",
        "magazine",
        "shotgun-shell-casing",
        "shot",
        "rocket-engine",
        "rocket-body",
    })

    if mods["bobwarfare"] then
        set_subgroup("bullet-guns", {
            "pistol",
            "submachine-gun",
            "rifle", -- bob's warfare only
            "sniper-rifle", -- bob's warfare only
            "firearm-magazine",
            "piercing-rounds-magazine"
        })
    else
        -- no bob's warfare? need to redo the subgroup
        set_subgroup("bullet-guns", {
            "pistol",
            "submachine-gun",
            "firearm-magazine",
            "piercing-rounds-magazine",
            "uranium-rounds-magazine"
        })
    end

    if mods["bobwarfare"] then
        -- subgroups for all the bob's ammo/ammo intermediates
        local function gen_ammo_variations(pattern)
            array = {}
            for _, type in pairs({"", "ap-", "electric-", "flame-", "acid-", "explosive-", "poison-", "plasma-", "uranium-"}) do
                array[#array+1] = pattern:gsub("*", type)
            end
            return array
        end

        local bullet_projectiles = gen_ammo_variations("*bullet-projectile")
        bullet_projectiles[6] = "he-bullet-projectile"
        set_subgroup("bob-bullet-projectiles", bullet_projectiles)

        local bullets = gen_ammo_variations("*bullet")
        bullets[6] = "he-bullet"
        set_subgroup("bob-bullets", bullets)

        local bullet_magazines = gen_ammo_variations("*bullet-magazine")
        bullet_magazines[6] = "he-bullet-magazine"
        bullet_magazines[9] = "uranium-rounds-magazine"
        set_subgroup("bob-bullet-magazines", bullet_magazines)

        local shotgun_shells = gen_ammo_variations("shotgun-*shell")
        shotgun_shells[1] = "better-shotgun-shell"
        set_subgroup("bob-shotgun-shells", shotgun_shells)

        local rocket_warheads = gen_ammo_variations("*rocket-warhead")
        rocket_warheads[2] = "piercing-rocket-warhead"
        rocket_warheads[9] = nil
        set_subgroup("bob-rocket-warheads", rocket_warheads)

        local rockets = gen_ammo_variations("bob-*rocket")
        rockets[2] = "bob-piercing-rocket"
        rockets[9] = nil
        set_subgroup("bob-rockets", rockets)

        set_subgroup("laser-rifle", {
            "laser-rifle",
            "laser-rifle-battery-case",
            "laser-rifle-battery",
            "laser-rifle-battery-ruby",
            "laser-rifle-battery-sapphire",
            "laser-rifle-battery-emerald",
            "laser-rifle-battery-amethyst",
            "laser-rifle-battery-topaz",
            "laser-rifle-battery-diamond",
        })
    end

    set_subgroup("shotguns", {
        "shotgun",
        "combat-shotgun",
        "shotgun-shell",
        "piercing-shotgun-shell"
    })

    set_subgroup("rocket-launchers", {
        "rocket-launcher",
        "rocket",
        "explosive-rocket",
        "atomic-bomb"
    })

    set_subgroup("flamethrower", {
        "flamethrower",
        "flamethrower-ammo"
    })

    set_subgroup("capsules", {
        "grenade",
        "cluster-grenade",
        "poison-capsule",
        "slowdown-capsule",
        "fire-capsule"
    })

    set_subgroup("combat-robots", {
        "defender-robot",
        "distractor-robot",
        "destroyer-robot",
        "bob-laser-robot"
    })

    set_subgroup("combat-robot-capsules", {
        "defender-capsule",
        "distractor-capsule",
        "destroyer-capsule",
        "bob-laser-robot-capsule"
    })

    set_subgroup("robot-attack-drones", {
        "robot-drone-frame",
        "bob-robot-gun-drone",
        "bob-robot-laser-drone",
        "bob-robot-flamethrower-drone",
        "robot-drone-frame-large",
        "bob-robot-plasma-drone"
    })

    set_subgroup("mines", {
        "land-mine",
        "distractor-mine",
        "poison-mine",
        "slowdown-mine"
    })

    set_subgroup("arty-shells", {
        "artillery-shell",
        "distractor-artillery-shell",
        "explosive-artillery-shell",
        "fire-artillery-shell",
        "poison-artillery-shell"
    })

    if mods["bobwarfare"] then
        set_subgroup("tank-shells", {
            "cannon-shell",
            "explosive-cannon-shell",
            "scatter-cannon-shell", -- bob's warfare only
            "uranium-cannon-shell",
            "explosive-uranium-cannon-shell",
        })
    else
        -- no bob's warfare? need to exclude scatter cannon shells
        set_subgroup("tank-shells", {
            "cannon-shell",
            "explosive-cannon-shell",
            "uranium-cannon-shell",
            "explosive-uranium-cannon-shell",
        })
    end

    -- armor tab
    data:extend({
        {
            type = "item-group",
            name = "armor",
            order = "d-a",
            inventory_order = "d-a",
            icon = "__Hexy_AngelBob_Tweaks__/graphics/item-group/armor.png",
            icon_size = 128,
        },
        {
            type = "item-subgroup",
            name = "personal-solar-panels",
            group = "armor",
            order = "b",
        },
        {
            type = "item-subgroup",
            name = "personal-fusion-reactors",
            group = "armor",
            order = "c",
        },
        {
            type = "item-subgroup",
            name = "personal-batteries",
            group = "armor",
            order = "d",
        },
        {
            type = "item-subgroup",
            name = "exoskeletons",
            group = "armor",
            order = "e",
        },
        {
            type = "item-subgroup",
            name = "personal-roboports",
            group = "armor",
            order = "f",
        },
        {
            type = "item-subgroup",
            name = "personal-area-expanders",
            group = "armor",
            order = "g",
        },
        {
            type = "item-subgroup",
            name = "personal-chargepads",
            group = "armor",
            order = "h",
        },
        {
            type = "item-subgroup",
            name = "personal-robot-controls",
            group = "armor",
            order = "i",
        },
        {
            type = "item-subgroup",
            name = "personal-energy-shields",
            group = "armor",
            order = "e-a",
        },
        {
            type = "item-subgroup",
            name = "personal-laser-defenses",
            group = "armor",
            order = "e-b",
        },
        {
            type = "item-subgroup",
            name = "night-visions",
            group = "armor",
            order = "k",
        },
        {
            type = "item-subgroup",
            name = "armor-misc",
            group = "armor",
            order = "l",
        },
    })
    move_subgroup("armor", "armor", "a")

    set_subgroup("personal-solar-panels", gen_tiers("solar-panel-equipment*", "-*", 4))
    set_subgroup("personal-fusion-reactors", gen_tiers("fusion-reactor-equipment*", "-*", 4))
    set_subgroup("personal-batteries", gen_tiers("battery*-equipment", "-mk*", 6))
    set_subgroup("exoskeletons", gen_tiers("exoskeleton-equipment*", "-*", 3))
    set_subgroup("personal-energy-shields", gen_tiers("energy-shield*-equipment", "-mk*", 6))
    set_subgroup("personal-laser-defenses", gen_tiers("personal-laser-defense-equipment*", "-*", 6))
    set_subgroup("personal-roboports", gen_tiers("personal-roboport*-equipment", "-mk*", 4))
    set_subgroup("personal-area-expanders", gen_tiers("personal-roboport-antenna-equipment*", "-*", 4))
    set_subgroup("personal-chargepads", gen_tiers("personal-roboport-chargepad-equipment*", "-*", 4))
    set_subgroup("personal-robot-controls", gen_tiers("personal-roboport-robot-equipment*", "-*", 4))
    set_subgroup("night-visions", gen_tiers("night-vision-equipment*", "-*", 3))

    set_subgroup("armor-misc", {
        "discharge-defense-equipment",
        "discharge-defense-remote",
        "belt-immunity-equipment",
        "perfect-night-glasses" -- if afraid of the dark is present, put this in: else does nothing
    })

    -- vehicles tab
    data:extend({
        {
            type = "item-group",
            name = "vehicles",
            order = "d-b",
            inventory_order = "d-b",
            icon = "__Hexy_AngelBob_Tweaks__/graphics/item-group/vehicles.png",
            icon_size = 128,
        },
        {
            type = "item-subgroup",
            name = "personal-vehicles",
            group = "vehicles",
            order = "a",
        },
        {
            type = "item-subgroup",
            name = "vehicle-solar-panels",
            group = "vehicles",
            order = "b",
        },
        {
            type = "item-subgroup",
            name = "vehicle-fusion-reactors",
            group = "vehicles",
            order = "c",
        },
        {
            type = "item-subgroup",
            name = "vehicle-fusion-cells",
            group = "vehicles",
            order = "c-a",
        },
        {
            type = "item-subgroup",
            name = "vehicle-batteries",
            group = "vehicles",
            order = "d",
        },
        {
            type = "item-subgroup",
            name = "vehicle-motors",
            group = "vehicles",
            order = "e",
        },
        {
            type = "item-subgroup",
            name = "vehicle-roboports",
            group = "vehicles",
            order = "f",
        },
        {
            type = "item-subgroup",
            name = "vehicle-area-expanders",
            group = "vehicles",
            order = "g",
        },
        {
            type = "item-subgroup",
            name = "vehicle-chargepads",
            group = "vehicles",
            order = "h",
        },
        {
            type = "item-subgroup",
            name = "vehicle-robot-controls",
            group = "vehicles",
            order = "i",
        },
        {
            type = "item-subgroup",
            name = "vehicle-energy-shields",
            group = "vehicles",
            order = "e-a",
        },
        {
            type = "item-subgroup",
            name = "vehicle-laser-defenses",
            group = "vehicles",
            order = "j-a",
        },
        {
            type = "item-subgroup",
            name = "vehicle-plasma-cannons",
            group = "vehicles",
            order = "j-b",
        },
    })

    set_subgroup("personal-vehicles", {
        "car",
        "tank",
        "bob-tank-2",
        "bob-tank-3"
    })
    set_subgroup("vehicle-solar-panels", gen_tiers_include_1("vehicle-solar-panel-*", 6))
    set_subgroup("vehicle-fusion-reactors", gen_tiers_include_1("vehicle-fusion-reactor-*", 6))
    set_subgroup("vehicle-fusion-cells", gen_tiers_include_1("vehicle-fusion-cell-*", 6))
    set_subgroup("vehicle-batteries", gen_tiers_include_1("vehicle-battery-*", 6))

    set_subgroup("vehicle-motors", {
        "vehicle-motor",
        "vehicle-engine"
    })

    set_subgroup("vehicle-energy-shields", gen_tiers_include_1("vehicle-shield-*", 6))
    set_subgroup("vehicle-laser-defenses", gen_tiers_include_1("vehicle-laser-defense-*", 6))
    set_subgroup("vehicle-plasma-cannons", gen_tiers_include_1("vehicle-big-turret-*", 6))
    set_subgroup("vehicle-roboports", gen_tiers("vehicle-roboport*", "-*", 4))
    set_subgroup("vehicle-area-expanders", gen_tiers("vehicle-roboport-antenna-equipment*", "-*", 4))
    set_subgroup("vehicle-chargepads", gen_tiers("vehicle-roboport-chargepad-equipment*", "-*", 4))
    set_subgroup("vehicle-robot-controls", gen_tiers("vehicle-roboport-robot-equipment*", "-*", 4))

    -- fortifications tab
    data:extend{
        {
            type = "item-group",
            name = "fortifications",
            order = "d-c",
            inventory_order = "d-c",
            icon = "__Hexy_AngelBob_Tweaks__/graphics/item-group/fortifications.png",
            icon_size = 128,
        },
        {
            type = "item-subgroup",
            name = "walls",
            group = "fortifications",
            order = "a",
        },
        {
            type = "item-subgroup",
            name = "gun-turrets",
            group = "fortifications",
            order = "b",
        },
        {
            type = "item-subgroup",
            name = "sniper-turrets",
            group = "fortifications",
            order = "b-a",
        },
        {
            type = "item-subgroup",
            name = "flame-turrets",
            group = "fortifications",
            order = "c",
        },
        {
            type = "item-subgroup",
            name = "laser-turrets",
            group = "fortifications",
            order = "d",
        },
        {
            type = "item-subgroup",
            name = "plasma-turrets",
            group = "fortifications",
            order = "d-a",
        },
        {
            type = "item-subgroup",
            name = "artillery-turrets",
            group = "fortifications",
            order = "e",
        },
        {
            type = "item-subgroup",
            name = "radars",
            group = "fortifications",
            order = "f",
        },
    }

    set_subgroup("walls", {
        "stone-wall",
        "gate",
        "reinforced-wall",
        "reinforced-gate"
    })

    gun_turrets = gen_tiers("bob-gun-turret*", "-*", 5)
    gun_turrets[1] = "gun-turret"
    set_subgroup("gun-turrets", gun_turrets)

    set_subgroup("sniper-turrets", gen_tiers_include_1("bob-sniper-turret-*", 3))

    set_subgroup("flame-turrets", {"flamethrower-turret"})

    laser_turrets = gen_tiers("bob-laser-turret*", "-*", 5)
    laser_turrets[1] = "laser-turret"
    set_subgroup("laser-turrets", laser_turrets)

    set_subgroup("plasma-turrets", gen_tiers_include_1("bob-plasma-turret-*", 5))

    if mods["bobwarfare"] then
        set_subgroup("artillery-turrets", {
            "artillery-turret",
            "bob-artillery-turret-2",
            "bob-artillery-turret-3",
            "artillery-targeting-remote",
            "artillery-bombardment-remote", -- artillery bombardment remote support
            "smart-artillery-bombardment-remote",
            "smart-artillery-exploration-remote",
        })
    else
        set_subgroup("artillery-turrets", {
            "artillery-turret",
            "artillery-targeting-remote"
        })
    end

    set_subgroup("radars", gen_tiers("radar*", "-*", 5))
end

if settings.startup["merge-intermediates"].value then
    -- merge bob's intermediates into normal intermediates
    for _, subgroup in pairs(data.raw["item-subgroup"]) do
        if subgroup.group == "bob-intermediate-products" then
            subgroup.group = "intermediate-products"
        end
    end

    sort_after("coal-liquefaction", "coal-cracking-3")

    if settings.startup["remove-bobs-fluids-materials"].value then
        sort_before("battery", "lithium-chloride")
    else
        sort_before("battery", "lithium-ion-battery")
    end

    sort_chain_reverse{
        "iron-stick",
        "iron-gear-wheel",
        "steel-gear-wheel"
    }

    if mods["CircuitProcessing"] then
        sort_chain{
            "cp-advanced-processing-board",
            "electronic-circuit",
            "advanced-circuit",
            "processing-unit",
            "advanced-processing-unit"
        }
    end

    sort_after("empty-barrel", "barreling-pump")

    sort_chain_reverse{
        "engine-unit",
        "electric-engine-unit",
        "flying-robot-frame"
    }

    -- rocket parts, supports SpaceX
    move_subgroup("intermediate-product", "intermediate-products", "e-c-a")
    sort_chain{
        "rocket-fuel",
        "satellite",
        "assembly-robot" -- SpaceX
    }

    -- science packs
    if not mods['ScienceCostTweakerM'] then
        move_subgroup("science-pack", "intermediate-products", "e-c-b")
    end
end

if settings.startup["reorganize-logistics"].value then
    -- move belt/inserters to logistics tab
    move_subgroup("bob-logistic-tier-0", "logistics", "b-a")
    move_subgroup("bob-logistic-tier-1", "logistics", "b-b")
    move_subgroup("bob-logistic-tier-2", "logistics", "b-c")
    move_subgroup("bob-logistic-tier-3", "logistics", "b-d")
    move_subgroup("bob-logistic-tier-4", "logistics", "b-e")
    move_subgroup("bob-logistic-tier-5", "logistics", "b-f")

    -- move artillery wagons to after fluid wagons
    data:extend{
        {
            type = "item-subgroup",
            name = "artillery-wagons",
            group = "logistics",
            order = "e-a4",
        },
    }
    set_subgroup("artillery-wagons", {
        "artillery-wagon",
        "bob-artillery-wagon-2",
        "bob-artillery-wagon-3",
    })

    -- reorganize barreling & fluid control
    data.raw["item-group"]["angels-fluid-control"].order = "aaaa"

    sort_chain_reverse{
        "bob-small-inline-storage-tank",
        "bob-small-storage-tank",
        "storage-tank",
        "storage-tank-2",
        "storage-tank-3",
        "storage-tank-4",
        "angels-storage-tank-1"
    }

    move_subgroup("pipe", "angels-fluid-control", "Z-a")
    move_subgroup("pipe-to-ground", "angels-fluid-control", "Z-b")

    -- bob's flow control adds extra pipes
    if mods["bobsflowcontrol-updated"] then
        move_subgroup("flow-control-1", "angels-fluid-control", "Z-b-a")
        move_subgroup("flow-control-2", "angels-fluid-control", "Z-b-b")
        move_subgroup("flow-control-3", "angels-fluid-control", "Z-b-c")
    end

    data.raw["item-subgroup"]["angels-fluid-control"].order = "c-a"

    -- move pumps to fluid control
    data:extend{
        {
            type = "item-subgroup",
            name = "pumps",
            group = "angels-fluid-control",
            order = "Z-c"
        },
        {
            type = "item-subgroup",
            name = "valves",
            group = "angels-fluid-control",
            order = "c"
        }
    }
    local pumps = gen_tiers("bob-pump*", "-*", 4)
    pumps[1] = "pump"
    set_subgroup("pumps", pumps)
    set_subgroup("valves", {
        "valve-check",
        "valve-return",
        "valve-overflow",
        "valve-converter",
        "valve-underflow",
        "bob-valve",
        "bob-overflow-valve",
        "bob-topup-valve",
        "check-valve", --flow control
        "overflow-valve",
        "underflow-valve"
    })

    sort_chain{
        "empty-barrel",
        "empty-canister",
        "gas-canister"
    }

    -- robots tab
    data:extend{
        {
            type = "item-group",
            name = "robots",
            order = "ab",
            inventory_order = "ab",
            icon = "__Hexy_AngelBob_Tweaks__/graphics/item-group/robots.png",
            icon_size = 128,
        },
        {
            type = "item-subgroup",
            name = "flying-robot-frames",
            group = "robots",
            order = "b",
        },
        {
            type = "item-subgroup",
            name = "construction-brains",
            group = "robots",
            order = "c-a",
        },
        {
            type = "item-subgroup",
            name = "construction-tools",
            group = "robots",
            order = "c-b",
        },
        {
            type = "item-subgroup",
            name = "logistic-brains",
            group = "robots",
            order = "d-a",
        },
        {
            type = "item-subgroup",
            name = "logistic-tools",
            group = "robots",
            order = "d-b",
        },
        {
            type = "item-subgroup",
            name = "combat-brains",
            group = "robots",
            order = "e-a",
        },
        {
            type = "item-subgroup",
            name = "combat-tools",
            group = "robots",
            order = "e-b",
        },
        {
            type = "item-subgroup",
            name = "bob-logistics-roboport-charge-large",
            group = "robots",
            order = "g-e",
        },
    }

    if not settings.startup["reorganize-military"].value then
        data:extend{
            {
                type = "item-subgroup",
                name = "combat-robots",
                group = "robots",
                order = "e-c",
            },
        }
        set_subgroup("combat-robots", {
            "defender-robot",
            "distractor-robot",
            "destroyer-robot",
            "bob-laser-robot"
        })
    else
        move_subgroup("combat-robots", "robots", "e-c")
    end

    move_subgroup("logistic-network", "robots", "a-a")
    move_subgroup("logistic-chests-2", "robots", "a-b")
    move_subgroup("logistic-chests-3", "robots", "a-c")

    move_subgroup("bob-construction-robots", "robots", "c-c")
    move_subgroup("bob-logistic-robots", "robots", "d-c")

    move_subgroup("bob-roboport-parts-antenna", "robots", "f-a")
    move_subgroup("bob-roboport-parts-door", "robots", "f-b")
    move_subgroup("bob-roboport-parts-charge", "robots", "f-c")

    move_subgroup("bob-logistic-roboport", "robots", "g-a")
    move_subgroup("bob-logistic-roboport-zone", "robots", "g-b")
    move_subgroup("bob-logistic-roboport-chest", "robots", "g-c")
    move_subgroup("bob-logistic-roboport-charge", "robots", "g-d")

    set_subgroup("flying-robot-frames", gen_tiers("flying-robot-frame*", "-*", 4))
    set_subgroup("construction-brains", gen_tiers("robot-brain-construction*", "-*", 4))
    set_subgroup("construction-tools", gen_tiers("robot-tool-construction*", "-*", 4))
    set_subgroup("logistic-brains", gen_tiers("robot-brain-logistic*", "-*", 4))
    set_subgroup("logistic-tools", gen_tiers("robot-tool-logistic*", "-*", 4))
    set_subgroup("combat-brains", gen_tiers("robot-brain-combat*", "-*", 4))
    set_subgroup("combat-tools", gen_tiers("robot-tool-combat*", "-*", 4))
    set_subgroup("bob-logistics-roboport-charge-large", gen_tiers("bob-robo-charge-port-large*", "-*", 4))
end

if settings.startup["move-ore-silos-warehouses"].value then
    data:extend{
        {
            type = "item-subgroup",
            name = "angels-silos-warehouses",
            group = "logistics",
            order = "a-1",
        },
        {
            type = "item-subgroup",
            name = "angels-logistic-silos",
            group = "logistics",
            order = "f-b",
        },
        {
            type = "item-subgroup",
            name = "angels-logistic-warehouses",
            group = "logistics",
            order = "f-c",
        },
    }

    set_subgroup("angels-logistic-silos", {
        "silo-active-provider",
        "silo-buffer",
        "silo-passive-provider",
        "silo-requester",
        "silo-storage"
    })

    set_subgroup("angels-logistic-warehouses", {
        "angels-warehouse-active-provider",
        "angels-warehouse-buffer",
        "angels-warehouse-passive-provider",
        "angels-warehouse-requester",
        "angels-warehouse-storage"
    })

    if mods["angelsaddons-oresilos"] or mods["angelsaddons-storage"] then
        set_subgroup("angels-silos-warehouses", {
            "silo",
            "silo-ore1",
            "silo-ore2",
            "silo-ore3",
            "silo-ore4",
            "silo-ore5",
            "silo-ore6",
            "silo-coal",
            "angels-warehouse"
        })
    elseif mods["angelsaddons-warehouses"] then
        set_subgroup("angels-silos-warehouses", {"angels-warehouse"})
    end

    if (mods["angelsaddons-warehouses"] or mods["angelsaddons-storage"]) and mods["extendedangels"] then
        sort_chain{
            "angels-warehouse",
            "warehouse-mk2",
            "warehouse-mk3",
            "warehouse-mk4"
        }
        move_subgroup("angels-warehouses-2", "logistics", "f-d")
        set_subgroup("angels-warehouses-2", {
            "warehouse-active-provider-mk2",
            "warehouse-buffer-mk2",
            "warehouse-passive-provider-mk2",
            "warehouse-requester-mk2",
            "warehouse-storage-mk2"
        })
        move_subgroup("angels-warehouses-3", "logistics", "f-e")
        set_subgroup("angels-warehouses-3", {
            "warehouse-active-provider-mk3",
            "warehouse-buffer-mk3",
            "warehouse-passive-provider-mk3",
            "warehouse-requester-mk3",
            "warehouse-storage-mk3"
        })
        move_subgroup("angels-warehouses-4", "logistics", "f-f")
        set_subgroup("angels-warehouses-4", {
            "warehouse-active-provider-mk4",
            "warehouse-buffer-mk4",
            "warehouse-passive-provider-mk4",
            "warehouse-requester-mk4",
            "warehouse-storage-mk4"
        })
    end

    if settings.startup["reorganize-logistics"].value then
        move_subgroup("angels-logistic-silos", "robots", "a-e")
        move_subgroup("angels-logistic-warehouses", "robots", "a-f")
        move_subgroup("angels-warehouses-2", "robots", "a-g")
        move_subgroup("angels-warehouses-3", "robots", "a-h")
        move_subgroup("angels-warehouses-4", "robots", "a-i")
    end
end

if settings.startup["merge-angels-industries"].value then
    if mods["angelsindustries"] then
	    if mods["angelsaddons-crawlertrain"] or mods["angelsaddons-mobility"] then
        	move_subgroup("angels-crawler-train", "logistics", "e-a5")
		end

        data:extend{
            {
                type = "item-subgroup",
                name = "angels-logistic-chests-big",
                group = "logistics",
                order = "f-a"
            }
        }
        set_subgroup("angels-logistic-chests-big", {
            "angels-logistic-chest-active-provider",
            "angels-logistic-chest-buffer",
            "angels-logistic-chest-passive-provider",
            "angels-logistic-chest-requester",
            "angels-logistic-chest-storage",
        })
        if settings.startup["move-ore-silos-warehouses"].value then
            data.raw.recipe["angels-big-chest"].subgroup = "angels-silos-warehouses"
            data.raw.recipe["angels-big-chest"].order = "Z"
        end

        if settings.startup["reorganize-logistics"].value then
            move_subgroup("angels-logistic-chests-big", "robots", "a-d")
            move_subgroup("angels-cargo-bots", "robots", "h-a")
            move_subgroup("angels-cargo-ports", "robots", "h-b")
            move_subgroup("angels-cargo-expander", "robots", "h-c")
        else
            move_subgroup("angels-cargo-bots", "bob-logistics", "g-a")
            move_subgroup("angels-cargo-ports", "bob-logistics", "g-b")
            move_subgroup("angels-cargo-expander", "bob-logistics", "g-c")
        end


        data:extend{
            {
                type = "item-subgroup",
                name = "angels-crawler",
                group = "logistics",
                order = "e-1"
            },
            {
                type = "item-subgroup",
                name = "angels-cab",
                group = "logistics",
                order = "e-2"
            },
            {
                type = "item-subgroup",
                name = "angels-vehicle-equipment",
                group = "logistics",
                order = "e-3"
            },
        }

        set_subgroup("angels-crawler", {
            "angels-crawler",
            "angels-construction-roboport-vequip",
            "angels-repair-roboport-vequip",
        })

        set_subgroup("angels-cab", {
            "angels-cab",
            "angels-cab-deploy-charge",
            "angels-cab-undeploy-charge",
            "angels-cab-energy-interface-mk1"
        })

        set_subgroup("angels-vehicle-equipment", {
            "angels-burner-generator-vequip",
            "angels-fusion-reactor-vequip",
            "angels-heavy-energy-shield-vequip",
        })

        if settings.startup["reorganize-military"].value then
            move_subgroup("angels-crawler", "vehicles", "k-a")
            move_subgroup("angels-cab", "vehicles", "k-b")
            move_subgroup("angels-vehicle-equipment", "vehicles", "k-c")
        end
    end

    if mods["angelsaddons-petrotrain"] or mods["angelsaddons-mobility"] then
        move_subgroup("angels-petrotrain", "logistics", "e-a6")
    end

    if mods["angelsaddons-smeltingtrain"] or mods["angelsaddons-mobility"] then
        move_subgroup("angels-smeltingtrain", "logistics", "e-a7")
    end
end

-- fix momo's sorting errors, re-sort some things
if mods["MomoTweak"] then
    sort_between("momo-mud-sand", "water-viscous-mud", "solid-mud-landfill")
    sort_after("momo-limestone-sand", "solid-limestone")
    sort_chain{
        "solder",
        "momo-silicon-plate",
        "lithium"
    }
end

-- move bob's chem plants to angel's petrochem section
sort_chain_reverse{
    "chemical-plant-2",
    "chemical-plant-3",
    "chemical-plant-4",
    "angels-chemical-plant"
}
