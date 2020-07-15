extends Level

func _on_GunPickup_body_entered(body):
	$Portal.position = $PortalPos.position
	$Gun.visible = false
	PlayerVariables.has_gun = true
