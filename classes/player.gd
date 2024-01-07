class_name Player

var coins : int = 0
var squads : Array 
var unlocked_characters: Array
var isNewPlayer = false

func _init():
	buildSquad()
	unlocked_characters = []
	prepareDummySquad()
	pass


func buildSquad():
	var squad1 = Squad.new()
	var squad2 = Squad.new()
	var squad3 = Squad.new()
	var squad4 = Squad.new()
	var squad5 = Squad.new()
	var squad6 = Squad.new()
	
	squads = [squad1, squad2, squad3, squad4, squad5, squad6]
	pass

func getSquad(squadNumb: int): 
	if (squadNumb < 6 and squadNumb >= 0):
		return squads[squadNumb]


		
func prepareDummySquad():
	var samatha_job1 = Job.new("the Spearmaiden", 2573, 150, 148, 147, 159, 32, 3, 1, 3, 4, "characters/samatha/Samatha_job1_icon.webp", "", 0.5, true)
	samatha_job1.addXp(52500)
	var samatha_job2 = Job.new("the Huntress", 712, 90, 75, 127, 119, 12, 3, 1, 3, 4, "characters/samatha/Samatha_job2_icon.webp", "", 0.5, true)
	samatha_job2.addXp(8400)
	var samatha_job3 = Job.new("the Foestalker", 312, 51, 50, 54, 48, 1, 3, 1, 3, 4, "characters/samatha/Samatha_job2_icon.webp", "", 0.5, false)
	var samatha = Character.new(0,"Samatha",  [samatha_job1, samatha_job2, samatha_job3], 0)
	

	var bonna_job1 = Job.new("the Idol", 4208, 50, 48, 47, 59, 53, 4, 2, 3, 4, "characters/bonna/Bonna_job1_icon.webp", "", 3.2, true)
	bonna_job1.addXp(126333)
	var bonna_job2 = Job.new("the Lyricist", 470, 50, 48, 47, 59, 2, 4, 2, 3, 4, "characters/bonna/Bonna_job2_icon.webp", "", 0.8, true)
	bonna_job2.addXp(1050)
	var bonna_job3 = Job.new("the PunkRocker", 511, 59, 52, 50, 49, 1, 4, 2, 3, 4, "characters/bonna/Bonna_job3_icon.webp", "", 3.2, false)
	var bonna = Character.new(1, "Bonna", [bonna_job1, bonna_job2, bonna_job3], 1)

	
	var mizury_job1 = Job.new("", 407, 21, 31, 51, 52, 1, 3, 2, 10, 6, "characters/mizury/Mizury_job1_icon.webp", "", 0.1, true)
	var mizury_job2 = Job.new("DNA", 466, 24, 34, 54, 55, 1, 3, 2, 10, 6, "characters/mizury/Mizury_job2_icon.webp", "", 0.0, false)
	var mizury_job3 = Job.new("RNA", 524, 27, 37, 57, 58, 1, 3, 2, 10, 6, "characters/mizury/Mizury_job2_icon.webp", "", 0.0, false)
	var mizury = Character.new(2, "Guardian mizury", [mizury_job1, mizury_job2, mizury_job3], 0)
	
	var high_elf_job = Job.new("the Archer", 420, 53, 50, 21, 30, 1, Constants.species.ELF, Constants.weapons.BOW, 0, Constants.rarities.SS, "characters/high_elf/high_elf_job1_icon.webp", "", 0.0, true)
	var high_elf = Character.new(3, "High elf", [high_elf_job], 0)
	
	Constants.elements.NONE
	var goblinSlayer_job = Job.new("", 1027, 94, 98, 50, 45, 15, Constants.species.HUMAN, Constants.weapons.SWORD, 0, Constants.rarities.S, "characters/goblin_slayer/goblin_slayer_job1_icon.webp", "", 0.4, true)
	var goblin_slayer = Character.new(4, "Goblin Slayer", [goblinSlayer_job], 0)
	
	unlocked_characters.append(samatha)
	unlocked_characters.append(bonna)
	unlocked_characters.append(mizury)
	unlocked_characters.append(high_elf)
	unlocked_characters.append(goblin_slayer)
	
	getSquad(0).changeCharacter(0, samatha)
	getSquad(0).changeCharacter(1, bonna)
	getSquad(0).changeCharacter(2, mizury)
	
	getSquad(1).changeCharacter(0, bonna)
	getSquad(1).changeCharacter(1, high_elf)
	getSquad(1).changeCharacter(2, goblin_slayer)
	getSquad(1).changeCharacter(3, samatha)
