extends Node

# Instancia del plugin de Google Play Game Services
var play_services

func _ready() -> void:
	# Verificamos si el plugin está disponible (solo existirá en un dispositivo Android)
	if Engine.has_singleton("GodotPlayGameServices"):
		play_services = Engine.get_singleton("GodotPlayGameServices")
		
		# Conectar las señales para saber si inició sesión con éxito
		if play_services.has_signal("user_authenticated"):
			play_services.connect("user_authenticated", _on_user_authenticated)
		
		# Iniciar sesión al arrancar el juego
		play_services.signIn()
	else:
		print("Google Play Game Services solo está disponible en Android.")

func _on_user_authenticated(is_authenticated: bool) -> void:
	if is_authenticated:
		print("¡Sesión iniciada con éxito en Google Play!")
	else:
		print("El usuario no pudo iniciar sesión en Google Play.")
