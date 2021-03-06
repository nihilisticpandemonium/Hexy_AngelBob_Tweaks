# used to print all the options in a markdown list to put on the mod portal

option_names = {
    "new-deuterium-recipe": "Enable new deuterium recipes",
    "remove-bobs-valves": "Remove Bob's valves",
    "remove-bobs-water-bores": "Remove Bob's water bores",
    "remove-bobs-electrolyzers": "Remove Bob's electrolyzers",
    "remove-bobs-small-tanks": "Remove Bob's small tanks",
    "remove-bobs-repair-packs": "Remove Bob's repair packs",
    "remove-bobs-beacons": "Remove Bob's beacons",
    "remove-angels-fish": "Remove Angel's fish recipes",
    "remove-angels-meat": "Remove Angel's meat recipes",
    "remove-angels-alien": "Remove Angel's alien bioprocessing recipes",
    "remove-angels-paste": "Remove Angel's metal paste recipes",
    "remove-phosgene": "Remove phosgene",
    "remove-ammonium-chloride": "Remove ammonium chloride",
    "remove-angels-calcium-chloride": "Remove Angel's calcium chloride recipe",
    "remove-coal-liquefaction": "Remove coal liquefaction",
    "new-nitroglycerin-recipe": "Enable new nitroglycerin recipe",
    "liquid-fuel-deuterium-barrels": "Liquid fuel and deuterium use normal barrels",
    "productivity-tweaks": "Fix productivity inconsistencies",
    "remove-bob-warfare-productivity": "Remove productivity on Bob's warfare intermediates",
    "fix-rubber-resin-texture": "Angel's resin and rubber recipe use Bob's icons",
    "rubber-resin-tweaks": "Rubber and resin tweaks",
    "silicon-wafer-tweaks": "Silicon wafer tweaks",
    "remove-glass-fiber": "Remove Angel's glass fiber",
    "bob-assembler-tweaks": "Bob's assembling machines module slots tweak",
    "chem-plant-tweaks": "Chem plant tweaks",
    "tech-cleanup": "Technology cleanup",
    "connect-science-pack-techs": "Make technologies require respective science pack techs",
    "angels-casting-cleanup": "Clean up Angel's casting recipes",
    "easier-lead-3-smelting": "Easier lead III smelting",
    "cheaper-gem-crystallization": "Cheaper gemstone crystallization",
    "fix-ceramic-filtering": "Ceramic filtering tweaks",
    "hybrid-catalyst-in-assembling-machine": "Hybrid catalysts crafted in assembling machine",
    "gather-gemstone-intermediates": "Move gemstone intermediates to gemstones tab",
    "remove-bobs-fluids-materials": "Remove Bob's fluids and Bob's materials tabs",
    "add-nuclear-tab": "Add nuclear tab",
    "move-offshore-pump": "Move offshore pump to water processing",
    "move-rocket-silo": "Move rocket silo to production tab",
    "move-ore-silos-warehouses": "Move ore silos/warehouses/large chests to logistics tab",
    "reorganize-military": "Reorganize military tab",
    "merge-intermediates": "Merge intermediates tabs",
    "reorganize-logistics": "Reorganize logistics tabs",
    "new-lithium-recipes": "Enable new lithium processing recipes",
    "stone-brick-tweaks": "Stone brick tweaks",
    "merge-angels-industries": "Remove Angel's industries tabs",
    "angels-fertilizer-for-bobs-greenhouse": "Use Angel's fertilizer for Bob's greenhouse recipes"
}

option_descriptions = {
    "new-deuterium-recipe": "Adds new textures and recipes for deuterium processing in the Angel's style.",
    "remove-bobs-valves": "Remove Bob's valve, overflow valve, and topup valve.",
    "remove-bobs-water-bores": "Remove Bob's water bores, as they have no recipes.",
    "remove-bobs-electrolyzers": "Remove Bob's electrolyzers, and move the recipes the machines originally had to other machines.",
    "remove-bobs-small-tanks": "Remove Bob's small tank and small inline tank.",
    "remove-bobs-repair-packs": "Remove Bob's new repair packs.",
    "remove-bobs-beacons": "Remove Bob's new beacons, as they are overpowered.",
    "remove-angels-fish": "Remove Angel's bioprocessing fish recipes, as they currently have no use.",
    "remove-angels-meat": "Remove Angel's meat recipes and butchery, as they currently have no use.",
    "remove-angels-alien": "Remove Angel's alien bioprocessing recipes, as they currently have no use. This changes Mushredtato's processing to give crystal dust instead of alien bacteria, as well as change red algae to give sodium perchlorate.",
    "remove-angels-paste": "Remove Angel's metal paste recipes, as they currently have no use.",
    "remove-phosgene": "Remove the phosgene gas recipe, as it currently has no use.",
    "remove-ammonium-chloride": "Remove the ammonium chloride recipe, as it currently has no use.",
    "remove-angels-calcium-chloride": "Remove the Angel's calcium chloride recipe in favor of keeping Bob's calcium chloride recipe.",
    "remove-coal-liquefaction": "Remove coal liquefaction, as it is superceded by Angel's coal cracking recipes.",
    "new-nitroglycerin-recipe": "Enable a new nitroglycerin recipe and texture that fits Angel's better. This also modifies Explosives II to use nitroglycerin, as it is the same materials in it.",
    "liquid-fuel-deuterium-barrels": "Force liquid fuel and deuterium to use normal barreling recipes.",
    "productivity-tweaks": "Remove productivity on heavy water electrolysis, calcium chloride, explosives I, and lithium cobalt oxide. In addition, move productivity on Angel's rubber from the rubber recipe to the liquid rubber recipe, to make it consistent with plastic and resin.",
    "remove-bob-warfare-productivity": "Remove productivity on all Bob's warfare intermediates, as this is a weird inconsistency between vanilla and Bob's warfare.",
    "fix-rubber-resin-texture": "Change Angel's resin and rubber recipe to use Bob's resin and rubber icons, as they are weirdly inconsistent.",
    "rubber-resin-tweaks": "Bob's resin recipe no longer takes productivity, to make Angel's resin more appealing. Bob's rubber recipe is removed, and the yield of Angel's rubber I is doubled to compensate as it is now the only way to make rubber. Red and green wire use tinned copper wire instead of insulated wire.",
    "silicon-wafer-tweaks": "Silicon wafers can now be crafted in electronics assembling machines, and take 2 seconds to craft instead of 5.",
    "remove-glass-fiber": "Remove the Angel's glass fiber recipe and fiberglass board from glass fiber recipe.",
    "bob-assembler-tweaks": "Makes it so Bob's assembling machines have 1-2-3-4-5-6 module slots instead of 0-2-4-5-5-6 module slots.",
    "chem-plant-tweaks": "Removes Bob's chem plants and the vanilla chem plant, and adjusts Angel's chem plant speeds to be more in line with Bob's chem plants. The Angel's chem plant is used in the production science recipe, and has the same recipe as the old chem plant.",
    "tech-cleanup": "Remove extraneous prerequisites for Angel's smelting techs that don't need them anymore, make bronze processing its own tech, restructure oil techs, remove dependencies on alloy processing/chemical processing, restructure Bob's warfare/equipment/vehicle equipment techs, add prerequisites to Angel's industries techs, and other miscellaneous changes which are too numerous to list here.",
    "connect-science-pack-techs": "Make it so that each technology requires its respective science pack tech. This excludes series of numbered techs where the tech is not the start of the series to reduce clutter and be consistent with vanilla.",
    "angels-casting-cleanup": "Remove recipes for Angel's casting intermediates that are never used for anything.",
    "cheaper-gem-crystallization": "Crystallizing gems from crystal seedling and crystal catalysts now costs 10 crystal seedling instead of 50 to make it actually viable.",
    "easier-lead-3-smelting": "Remove hexafluorosilicic acid from lead III smelting: the recipe that originally produced lead anodes now produces lead ingots, making lead III smelting actually viable.",
    "fix-ceramic-filtering": "Ceramic filtering returns enough sulfuric waste water to be sulfur positive, making it viable for filtering.",
    "hybrid-catalyst-in-assembling-machine": "Hybrid catalysts are crafted in an assembling machine instead of a crystallizer, as this makes more sense.",
    "gather-gemstone-intermediates": "Move grinding wheels/polishing compound/polishing wheels to the Bob's Gemstones tab to make them easier to find. Move the \"Sort Raw Gems\" recipe next to the geode crushing and gemstone ore crystallization recipes, as it makes more sense there.",
    "remove-bobs-fluids-materials": "Remove the Bob's fluids and Bob's materials tabs entirely, moving their contents to other tabs.",
    "add-nuclear-tab": "Add a nuclear tab containing the nuclear processing recipes as well as the nuclear power structures.",
    "move-offshore-pump": "Move the offshore pump to the Water Treatment tab, as it makes more sense to be there rather than production.",
    "move-rocket-silo": "Move the rocket silo to the production tab, as it is not a military building.",
    "move-ore-silos-warehouses": "Move ore silos/warehouses/large chests to the logistics tab, alongside all the other chests. Also gather the logistic versions of each of the chests in the same place as the normal logistic chests.",
    "reorganize-military": "Reorganize all of the military intermediates and military items into 4 different tabs: combat for weapons/ammo, armor for armor and its equipment, vehicles for cars/tanks and vehicle equipment, and foritifications for walls/turrets/radars.",
    "merge-intermediates": "Make it so that there is only one intermediates tab instead of two.",
    "reorganize-logistics": "Reorganize the existing Logistics and Bob's Logistics tabs into a Logistics tab, a Fluid Handling tab, and a Robots tab.",
    "new-lithium-recipes": "Making lithium perchlorate now requires sodium perchlorate as it does in real life, giving it an extra use. Sodium perchlorate now only requires green catalysts to compensate. Lithium cobalt oxide now requires lithium chloride instead of lithium metal, eliminating the lithium metal recipe entirely.",
    "stone-brick-tweaks": "Makes stone brick stack to 1000 to be consistent with clay brick/concrete/reinforced concrete. Also moves the stone brick recipe to Angel's casting.",
    "merge-angels-industries": "Remove both Angel's industries tabs and merge their contents into other tabs.",
    "angels-fertilizer-for-bobs-greenhouse": "Use Angel's fertilizer for Bob's greenhouse recipes, eliminating Bob's fertilizer entirely. Also makes cosmetic changes to the Bob's fertilizer tech to make it make more sense after the changes. Does nothing if Bob's greenhouses isn't present."
}

option_ids = [
    "gather-gemstone-intermediates",
    "remove-bobs-fluids-materials",
    "add-nuclear-tab",
    "move-offshore-pump",
    "move-ore-silos-warehouses",
    "move-rocket-silo",
    "reorganize-military",
    "merge-intermediates",
    "reorganize-logistics",
    "productivity-tweaks",
    "remove-bob-warfare-productivity",
    "fix-rubber-resin-texture",
    "merge-angels-industries",
    "remove-bobs-valves",
    "remove-bobs-electrolyzers",
    "remove-bobs-water-bores",
    "remove-bobs-small-tanks",
    "remove-bobs-repair-packs",
    "remove-bobs-beacons",
    "remove-angels-fish",
    "remove-angels-meat",
    "remove-angels-alien",
    "remove-angels-paste",
    "remove-phosgene",
    "remove-ammonium-chloride",
    "remove-coal-liquefaction",
    "remove-angels-calcium-chloride",
    "remove-glass-fiber",
    "angels-casting-cleanup",
    "easier-lead-3-smelting",
    "new-nitroglycerin-recipe",
    "new-deuterium-recipe",
    "new-lithium-recipes",
    "liquid-fuel-deuterium-barrels",
    "rubber-resin-tweaks",
    "silicon-wafer-tweaks",
    "bob-assembler-tweaks",
    "chem-plant-tweaks",
    "angels-fertilizer-for-bobs-greenhouse",
    "tech-cleanup",
    "connect-science-pack-techs",
    "stone-brick-tweaks",
    "cheaper-gem-crystallization",
    "fix-ceramic-filtering",
    "hybrid-catalyst-in-assembling-machine"
]

def print_options():
    for key in option_ids:
        print(f'- {option_names[key]}: {option_descriptions[key]}')

print_options()