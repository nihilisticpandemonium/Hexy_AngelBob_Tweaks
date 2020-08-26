#What is this?
This mod makes many tweaks and changes to the AngelBob's experience to make the experience more consistent and coherent throughout, as well as totally reorganize all the recipes in the game. Major tweaks and changes have been separated into other mods, which I list at the end of this description. Every change this mod makes is configurable, and is designed to be compatible with just about any combination of Angel's and Bob's mods. By default, no recipe or technology changes are turned on in order to maximize compatibility with mods outside the normal AngelBob's suite that I haven't specifically designed around: if one of the options causes the game to crash when loading or makes something impossible, the option can simply be disabled. If you are not sure if this mod is compatible with another mod, look at the FAQ and that will answer your questions.

##My Other Mods
[Better AngelBob's Concrete](https://mods.factorio.com/mod/AngelBob_Better_Concrete)
[Angel's Smelting Complete](https://mods.factorio.com/mod/Better_Angels_Smelting)
[All Bob's Furnaces are Multipurpose](https://mods.factorio.com/mod/Bob_Furnaces_Multipurpose)
[Make Strand Casting Great Again](https://mods.factorio.com/mod/Better_Strand_Casting)
[Better Bob's Solar Panels](https://mods.factorio.com/mod/Better_Bobs_Solar)
[Bob's Power Fix for Angel's](https://mods.factorio.com/mod/Bob_Power_Fix)
[Earlier Thermal Water](https://mods.factorio.com/mod/Better_Thermal_Water)
[Pure Manganese/Chrome Sorting](https://mods.factorio.com/mod/Manganese_Chrome_Sorting)
[Swap Silver and Nickel in AngelBob's](https://mods.factorio.com/mod/Silver_Nickel_Swap)
[Hexy's MadClown Tweaks](https://mods.factorio.com/mod/Hexy_MadClown_Tweaks)

#Options
##Reorganization/Non-Breaking Options (on by default)
- Move gemstone intermediates to gemstones tab: Move grinding wheels/polishing compound/polishing wheels to the Bob's Gemstones tab to make them easier to find. Move the "Sort Raw Gems" recipe next to the geode crushing and gemstone ore crystallization recipes, as it makes more sense there.
- Remove Bob's fluids and Bob's materials tabs: Remove the Bob's fluids and Bob's materials tabs entirely, moving their contents to other tabs.
- Add nuclear tab: Add a nuclear tab containing the nuclear processing recipes as well as the nuclear power structures.
- Move offshore pump to water processing: Move the offshore pump to the Water Treatment tab, as it makes more sense to be there rather than production.
- Move ore silos/warehouses/large chests to logistics tab: Move ore silos/warehouses/large chests to the logistics tab, alongside all the other chests. Also gather the logistic versions of each of the chests in the same place as the normal logistic chests.
- Move rocket silo to production tab: Move the rocket silo to the production tab, as it is not a military building.
- Reorganize military tab: Reorganize all of the military intermediates and military items into 4 different tabs: combat for weapons/ammo, armor for armor and its equipment, vehicles for cars/tanks and vehicle equipment, and foritifications for walls/turrets/radars.
- Merge intermediates tabs: Make it so that there is only one intermediates tab instead of two.
- Reorganize logistics tabs: Reorganize the existing Logistics and Bob's Logistics tabs into a Logistics tab, a Fluid Handling tab, and a Robots tab.
- Fix productivity inconsistencies: Remove productivity on heavy water electrolysis, calcium chloride, explosives I, and lithium cobalt oxide. In addition, move productivity on Angel's rubber from the rubber recipe to the liquid rubber recipe, to make it consistent with plastic and resin.
- Remove productivity on Bob's warfare intermediates: Remove productivity on all Bob's warfare intermediates, as this is a weird inconsistency between vanilla and Bob's warfare.
- Angel's resin and rubber recipe use Bob's icons: Change Angel's resin and rubber recipe to use Bob's resin and rubber icons, as they are weirdly inconsistent.
- Remove Angel's industries tabs: Remove both Angel's industries tabs and merge their contents into other tabs.
- Fix ferrous/cupric sludge recipes: The amount of sludge produced by the ferrous/cupric sludge recipes are multiplied by 10 to fit in line with the other recipes.
- Nutrient pulp can be clarified: Nutrient pulp is clarifiable, since Angel's bioprocessing does not enable this by default and it is useful to be able to clarify it.
- Remove ingredient count limits: Removes ingredient count limits from all machines. If Bob's Assembling Machines's "Factory ingredient limits" option is enabled, this option does nothing.

##"Removing Things" Options (off by default)
- Remove Bob's valves: Remove Bob's valve, overflow valve, and topup valve.
- Remove Bob's electrolyzers: Remove Bob's electrolyzers, and move the recipes the machines originally had to other machines.
- Remove Bob's water bores: Remove Bob's water bores, along with all their recipes.
- Remove Bob's small tanks: Remove Bob's small tank and small inline tank.
- Remove Bob's repair packs: Remove Bob's new repair packs.
- Remove Bob's beacons: Remove Bob's new beacons, as they are overpowered.
- Remove Angel's fish recipes: Remove Angel's bioprocessing fish recipes, as they currently have no use.
- Remove Angel's meat recipes: Remove Angel's meat recipes and butchery, as they currently have no use.
- Remove Angel's alien bioprocessing recipes: Remove Angel's biter bioprocessing recipes, as they currently have no use. If Bob's Enemies is not present, also removes alien bioprocessing entirely. This changes Mushredtato's processing to give crystal dust instead of alien bacteria, as well as change red algae to give sodium perchlorate.
- Remove silver metal paste: Remove silver metal paste, as it has no use even with Bob's Enemies.
- Remove phosgene: Remove the phosgene gas recipe, as it currently has no use.
- Remove ammonium chloride: Remove the ammonium chloride recipe, as it currently has no use.
- Remove coal liquefaction: Remove coal liquefaction, as it is superceded by Angel's coal cracking recipes.
- Remove Angel's calcium chloride recipe: Remove the Angel's calcium chloride recipe in favor of keeping Bob's calcium chloride recipe.
- Remove Angel's glass fiber: Remove the Angel's glass fiber recipe and fiberglass board from glass fiber recipe.
- Clean up Angel's casting recipes: Remove recipes for Angel's casting intermediates that are never used for anything.

##Balance/Restructuring Tweaks (off by default)
- Easier lead III smelting: Remove hexafluorosilicic acid from lead III smelting. The recipe that originally produced lead anodes now produces lead ingots, making lead III smelting actually viable.
- Enable new nitroglycerin recipe: Enable a new nitroglycerin recipe and texture that fits Angel's better. This also modifies Explosives II to use nitroglycerin, as it is the same materials in it.
- Enable new deuterium recipes: Adds new textures and recipes for deuterium processing in the Angel's style.
- Enable new lithium processing recipes: Make lithium perchlorate require sodium perchlorate as it does in real life, giving it an extra use. Sodium perchlorate now only requires green catalysts to compensate. Lithium cobalt oxide now requires lithium chloride instead of lithium metal, eliminating the lithium metal recipe entirely. Deuterium fuel reprocessing now returns lithium chloride to compensate.
- Liquid fuel and deuterium use normal barrels: Force liquid fuel and deuterium to use normal barreling recipes. If PetrochemPlus is present and the "Replace Gas Barrels with Gas Cylinders" option is enabled then deuterium will stay in a gas barrel.
- Rubber and resin tweaks: Bob's resin recipe no longer takes productivity, to make Angel's resin more appealing. Bob's rubber recipe is removed, and the yield of Angel's rubber I is doubled to compensate as it is now the only way to make rubber. Red and green wire use tinned copper wire instead of insulated wire. If used with PetrochemPlus, this setting will *override* PetrochemPlus's changes.
- Silicon wafer tweaks: Silicon wafers can now be crafted in electronics assembling machines, and take 2 seconds to craft instead of 5.
- Solder tweaks: Bob's solder recipe now produces 4 solder instead of 8, making it worse than Angel's solder recipes rather than better.
- Bob's assembling machines module slots tweak: Makes it so Bob's assembling machines have 1-2-3-4-5-6 module slots instead of 0-2-4-5-5-6 module slots.
- Chem plant tweaks: Removes Bob's chem plants and the vanilla chem plant, and adjusts Angel's chem plant speeds to be more in line with Bob's chem plants. Angel's chem plant I is used in the production science recipe, and has a similar recipe to the old chem plant.
- Use Angel's fertilizer for Bob's greenhouse recipes: Use Angel's fertilizer for Bob's greenhouse recipes, eliminating Bob's fertilizer entirely. Also makes cosmetic changes to the Bob's fertilizer tech to make it make more sense after the changes. Does nothing if Bob's greenhouses isn't present.
- Technology cleanup: Remove extraneous prerequisites for Angel's smelting techs that don't need them anymore, make bronze processing its own tech, restructure oil techs, remove dependencies on alloy processing/chemical processing, restructure Bob's warfare/equipment/vehicle equipment techs, add prerequisites to Angel's industries techs, and other miscellaneous changes which are too numerous to list here.
- Make technologies require respective science pack techs: Make it so that each technology requires its respective science pack tech. This excludes series of numbered techs where the tech is not the start of the series to reduce clutter and be consistent with vanilla.
- Stone brick tweaks: Makes stone brick stack to 1000 to be consistent with clay brick/concrete/reinforced concrete. Also moves the stone brick recipe to Angel's casting.
- Cheaper gemstone crystallization: Crystallizing gems from crystal seedling and crystal catalysts now costs 10 crystal seedling instead of 50 to make it actually viable.
- Ceramic filtering tweaks: Ceramic filtering returns enough sulfuric waste water to be sulfur positive, making it viable for filtering.
- Hybrid catalysts crafted in assembling machine: Hybrid catalysts are crafted in an assembling machine instead of a crystallizer, as this makes more sense.