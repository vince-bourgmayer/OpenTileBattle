class_name BattleTopBar extends Control


func add_power(amount: int):
	$mainContainer/progressContainer/power_bar.addPower(amount)
	
func finish_player_time_bar():
	$mainContainer/progressContainer/playerTimeBar.finish()

func start_player_turn_timer():
	$mainContainer/progressContainer/playerTimeBar.startTimer()
	
func set_player_turn_timer_callback(callback: Callable):
	$mainContainer/progressContainer/playerTimeBar.set_timeout_callback(callback)

func update_xp_gathered(amount: int):
	$mainContainer/rewardContainer/pexIcon/collectedPex.text = str(amount)

func update_coins_gathered(amount:int):
	$mainContainer/rewardContainer/coinsIcon/collectedCoins.text = str(amount)
