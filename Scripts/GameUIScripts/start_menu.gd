extends CanvasLayer

var controls: int

func _ready() -> void:
	# 1. Cargar la partida guardada
	GlobalSave.load_game()

	# 2. Inicializar el plugin nativo si existe el Singleton (en Android)
	if Engine.has_singleton("GodotPlayGameServices"):
		print("✅ Singleton 'GodotPlayGameServices' detectado.")
		GodotPlayGameServices.initialize()

	# 3. Gestionar la autenticación a través del nodo de la escena
	if has_node("PlayGamesSignInClient"):
		if not $PlayGamesSignInClient.user_authenticated.is_connected(_on_user_authenticated):
			$PlayGamesSignInClient.user_authenticated.connect(_on_user_authenticated)
		$PlayGamesSignInClient.sign_in()

func _on_user_authenticated(is_authenticated: bool) -> void:
	if is_authenticated:
		print("✅ Usuario autenticado en Google Play Games.")
		# Enviar la puntuación máxima una vez confirmado el inicio de sesión
		if has_node("PlayGamesLeaderboardsClient"):
			$PlayGamesLeaderboardsClient.submit_score("CgkIsK7QhPMZEAIQAQ", int(GlobalSave.game_data["max_score"]))
	else:
		print("❌ Error: Usuario no autenticado en Google Play Games.")

func _process(_delta: float) -> void:
	if $OptionsMenu.visible:
		GlobalSave.load_game()
		
		if TranslationServer.get_locale() == "es":
			$OptionsMenu/Options/HBoxContainer/Elecciones/IdiomaOpBtn.select(0)
		elif TranslationServer.get_locale() == "en":
			$OptionsMenu/Options/HBoxContainer/Elecciones/IdiomaOpBtn.select(1)
		
	$StartMenu/TotalPointsLbl.text = TranslationServer.translate("Menu_lbl_TotalPoints") + str(GlobalSave.game_data["total_points"])

# Changes to Level Scene
func _on_play_btn_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainLevel.tscn")

# Close the Game
func _on_exit_btn_button_down() -> void:
	GlobalSave.save_game()
	get_tree().quit()

func _on_options_btn_button_down() -> void:
	$StartMenu.visible = false
	$OptionsMenu.visible = true

func _on_atrás_btn_button_down() -> void:
	GlobalSave.save_game()
	$StartMenu.visible = true
	$OptionsMenu.visible = false

func _on_idioma_op_btn_item_selected(index: int) -> void:
	if index == 0:
		TranslationServer.set_locale("es")
	elif index == 1:
		TranslationServer.set_locale("en")
	$StartMenu/TotalPointsLbl.text = TranslationServer.translate("Menu_lbl_TotalPoints") + str(GlobalSave.game_data["total_points"])

func _on_patch_notes_button_down() -> void:
	if $PathcNotes.visible:
		$PathcNotes.visible = false
		$StartMenu/MarginContainer.visible = true
	else:
		$PathcNotes.visible = true
		$StartMenu/MarginContainer.visible = false

func _on_shop_btn_button_down() -> void:
	$Shop.visible = true
	$StartMenu.visible = false

func _on_score_btn_button_down() -> void:
	print("--- BOTÓN PULSADO ---")
	if has_node("PlayGamesLeaderboardsClient"):
		# Prueba pasándole el ID de tu tabla:
		$PlayGamesLeaderboardsClient.show_leaderboard("CgkIsK7QhPMZEAIQAQ")
		# O si usas show_all_leaderboards:
		# $PlayGamesLeaderboardsClient.show_all_leaderboards()
