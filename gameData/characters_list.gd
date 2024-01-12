class_name CharactersList extends Resource

@export var characters : Array[Character] = []

func _init():
	pass
	
	
func generate_test_characters():
	var samatha = Character.new("Samatha", [], 0)
	var samatha_job1_stats = CreatureStats.new(2573, 150, 148, 147, 159)
	var samatha_job1 = Job.new("the Spearmaiden", samatha_job1_stats, 32, Constants.species.HUMAN, Constants.weapons.SPEAR, Constants.elements.LIGHTNING, Constants.rarities.S, "characters/samatha/Samatha_job1_icon.webp", "", 0.5, true)
	samatha_job1.addXp(52500)
	var samatha_job2_stats = CreatureStats.new(712, 90, 75, 127, 119)
	var samatha_job2 = Job.new("the Huntress", samatha_job2_stats, 12, Constants.species.HUMAN, Constants.weapons.SPEAR, Constants.elements.LIGHTNING, Constants.rarities.S, "characters/samatha/Samatha_job2_icon.webp", "", 0.5, true)
	samatha_job2.addXp(8400)
	var samatha_job3_stats = CreatureStats.new(312, 51, 50, 54, 48)
	var samatha_job3 = Job.new("the Foestalker", samatha_job3_stats, 1, Constants.species.HUMAN, Constants.weapons.SPEAR, Constants.elements.LIGHTNING, Constants.rarities.S, "characters/samatha/Samatha_job2_icon.webp", "", 0.5, false)
	samatha.jobs.append_array([samatha_job1, samatha_job2, samatha_job3])

	var bonna = Character.new("Bonna", [], 1)
	var bonna_job1_stats = CreatureStats.new(4208, 50, 48, 47, 59)
	var bonna_job1 = Job.new("the Idol", bonna_job1_stats, 53, 4, 2, 3, 4, "characters/bonna/Bonna_job1_icon.webp", "", 3.2, true)
	bonna_job1.addXp(126333)
	var bonna_job2_stats = CreatureStats.new(470, 50, 48, 47, 59)
	var bonna_job2 = Job.new("the Lyricist", bonna_job2_stats, 2, 4, 2, 3, 4, "characters/bonna/Bonna_job2_icon.webp", "", 0.8, true)
	bonna_job2.addXp(1050)
	var bonna_job3_stats = CreatureStats.new(511, 59, 52, 50, 49)
	var bonna_job3 = Job.new("the PunkRocker", bonna_job3_stats, 1, 4, 2, 3, 4, "characters/bonna/Bonna_job3_icon.webp", "", 3.2, false)
	bonna.jobs.append_array([bonna_job1, bonna_job2, bonna_job3])

	var mizury = Character.new("Guardian mizury", [], 0)
	var mizury_job1 = Job.new("", CreatureStats.new(407, 21, 31, 51, 52), 1, 3, 2, 10, 6, "characters/mizury/Mizury_job1_icon.webp", "", 0.1, true)
	var mizury_job2 = Job.new("DNA", CreatureStats.new(466, 24, 34, 54, 55), 1, 3, 2, 10, 6, "characters/mizury/Mizury_job2_icon.webp", "", 0.0, false)
	var mizury_job3 = Job.new("RNA", CreatureStats.new(524, 27, 37, 57, 58), 1, 3, 2, 10, 6, "characters/mizury/Mizury_job2_icon.webp", "", 0.0, false)
	mizury.jobs.append_array([mizury_job1, mizury_job2, mizury_job3])
	
	var high_elf_job = Job.new("the Archer", CreatureStats.new(420, 53, 50, 21, 30), 1, Constants.species.ELF, Constants.weapons.BOW, 0, Constants.rarities.SS, "characters/high_elf/high_elf_job1_icon.webp", "", 0.0, true)
	var high_elf = Character.new("High elf", [high_elf_job], 0)
	
	var goblinSlayer_job = Job.new("the legend", CreatureStats.new(1027, 94, 98, 50, 45), 15, Constants.species.HUMAN, Constants.weapons.SWORD, 0, Constants.rarities.S, "characters/goblin_slayer/goblin_slayer_job1_icon.webp", "", 0.4, true)
	var goblin_slayer = Character.new("Goblin Slayer", [goblinSlayer_job], 0)
	
	var prietress_job = Job.new("the newbie", CreatureStats.new(400, 35, 40, 45, 57), 1, Constants.species.HUMAN, Constants.weapons.STAFF, 0, Constants.rarities.S, "characters/prietress/prietress_job1_icon.webp", "characters/prietress/prietress_job1.webp", 0.4, true)
	var prietress = Character.new("Young prietress", [prietress_job], 0)

	var lizard_shaman_job = Job.new("the cheese lover", CreatureStats.new(450, 35, 40, 45, 57), 1, Constants.species.LIZARD_FOLK, Constants.weapons.SWORD, 0, Constants.rarities.SS, "characters/lizard_shaman/lizard_shaman_job1_icon.webp", "characters/lizard_shaman/lizard_shaman_job1.webp", 0.4, true)
	var lizard_shaman = Character.new("Shaman", [lizard_shaman_job], 0)
	
	characters.append(samatha)
	characters.append(bonna)
	characters.append(mizury)
	characters.append(high_elf)
	characters.append(goblin_slayer)
	characters.append(prietress)
	characters.append(lizard_shaman)


func _save():
	var path = "res://gameData/characters_list.tres"
	var result = ResourceSaver.save(self, path)
	assert(result == OK)
