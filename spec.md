Specification


The game is composed of several menu which allow to start a party or to manage resources.
Resources is composed of characters, items, coins and stamina.

Following element is describing those elements.


Coins: 
	- They are reward for won battle. 
	- They are used to buy characters, items & stamina. 
	- They are also used to upgrade characters

Stamina:
	- is consumed to start a party
	- max amount increase at some point
	- can be recover with time or coins


Character:
	- They are player's unit
	- They can be in many squad
	- it has name
	- it has 1 or 3 different jobs but only job is enabled at time
	- it has one specy
	- it has one rarity level
	- it has a gender

Characters's job
	- it has name suffix
	- it has stats: HP, ATK, DEF, mATK, mDef, SkillBoost
	- it can be unlocked under level condition
	- it has 4 skills: 1 available by default
	- it has 4 slot for extra skills selectable from other jobs
	- it has one weapon type
	- it has one element
	- it has a level
	- it has experiences
	- it can equip one item
	- it has a picture
	- it as an icon

Skills
	- can be active or passive
	- have an area of effect
	- have a single effect
	- it has a name
	- it has an element
	- it may have a weapon type
	- it has visual effect

Active Skills
	- They can be triggered from pincering, chaining or both
	- They have a Triggering rate


https://terrabattle.fandom.com/wiki/Status_Effect

Chapter
	- A chapter is identified by a number
	- a several stage

Stage
	- It has a title
	- it has a stage number
	- It has one or many Floor
	- It has a background image
	- It has a list of drappable items and recruitable character associated to drop condition & rate
	- 6 starting position for player's characters
	- it can already have been done
	- it can have restriction to start like character level, or character number
	- It has a text introduction

Floor
	- it is subpart of a stage
	- It has a list of foe associated to a started position in the battle grid
	- it has a order's number
	- It may have traps on fixed position

https://terrabattle.fandom.com/wiki/Traps

---

Menu & View:


main:

	- it has a menu bar which allow to navigate into other main menu
	- A top bar display: stamina & coins
	- It has a central view with yet undefined content


main Menu bar
	- It has a button to open the chapter menu named "Story"
	- It has a button to open the squad management menu
	- It has a button to open character management menu
	- It has a button to open Item list
	- It has a settings menu


Chapter menu
	- The chapter menu  display lists of selectable chapter
	- When a chapter is selected, it opens the stage menu for the given chapter

	chapter item:
		- A chapter item is composed of a button with: chapter ID & title. Ex: "Chapter 3: a bloody mist"
		- A chapter item is 

stage menu
	- It display a list of selectable stage for the given chapter
	- When a stage is selected, it display the battle menu
	- It has a "back" button which allow to return to chapter menu

	stage item:
		- It display the 

Battle menu
	- It display chapter's number and stage number (e.g chapter 1, stage 3 =>  "1-3")
	- It display the chapter's title
	- It display number of enemies with basic info: their weapon type and element
	- It allow to choose the squad that will battle
	- It has a "start menu" button that start the battle game
	- It has a "back" button which allow to return to stage menu


Battle game view
	- It as a top bar with some info
	- It has a grid that represents the game's area
	- it has no sub menu bar
	- it take the full screen
	- it display characters and foe tile
	- A Boss tile is a 2x2 tiles

	Battle top bar
		- it has a timer for player action time
		- it display amount of coins collected
		- it display amount of exp collected
		- it display amount of items collected
		- it display amount of recruited unit
		- it display the power point raising bar
		- it has a pause button that pause the game


---

mechanics and logic


Battle Game:
	- during a battle, player and computer play one after the other
	- the game follow the given process:
		1. Player action turn
		2. resolution time
		3. Computer action turn
	- Chaining is the action of lining up other units with the ones performing the pincer. A unit is considered to be in a chain if it is in the same row or column as a pincering unit, and there are no enemies or obstacles between them. Each unit can only be in one chain per pincer

	Player action turn
		- The Player has (by default) 4 secondes time frame to move one of its characters
		- When the moving character collides with another one, they exchange their place
		- If the moving characters enter a trap or a bomb it takes damage

	resolution time
		- Check for pincering
		- collect skill to activate from pincering
		- Check for chaining
		- collect skill to activate from chaining
		- apply skills
		- if a foe die: collect coins, xp, items & recruitable char
		- remove the foe
		- if all foe died : move to next floor. If no more floor: leave and display success page.

	Computer action turn
		- For each foe:
			- move
			- use skill if possible


	from Terra Battle wiki:

		```
	    Player turn
	        Movement
	        Pincer attacks
	            Buff skills
	            Attack
	            Attack/debuff skills
	            Healing
	            Capsule
	            Enemy counter
	            Repeat until all pincers have been resolved
	    Enemy turn
	        The following may be performed in any order:
	            Enemy movement
	            Enemy pincer
	                Player counter
	            Enemy skills
	        Repeat until all enemies have performed their actions
	    After enemy turn
	        Status effect and trap damage
	        Regen healing
	        Reduce buff, debuff and effect turn counters by 1
	    ```


	src: https://terrabattle.fandom.com/wiki/Battles







Player turn:
	wait for player to pick a fighter
	once a fighter is picked:
		set fighter as picked
		start timer => update time bar
		Update fighter pos
		When timer finish:
			stop unit on its tile
			set unpicked

			





How to detect pincer...


A: allié
X: enemy
-: vide


 X A - - - -
 A - - - - -
 - - - - - -
 - - - - - -
 - - - - - -
 - - - - - -
 - - - - - -
 - - - - - -
 - - - - - -


A: allié
X: enemy
-: vide


 - - - - - -
 A X A - - -
 - - - - - -
 - - - - - -
 - A X X X A
 - - - - - -
 - - - - - -
 - - - - - -
 - - - - - -


A: allié
X: enemy
-: vide


 - - - - - -
 - - A - - -
 - - X - - -
 - - X - - -
 - - X - - -
 - - A - - -
 - - - - - A
 - - - - - X
 - - - - - A






 algo:

 	For each fighter
 		check if other  in same line