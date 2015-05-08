function love.conf(t)
	t.identity = "Radial Clock"
	--t.version = "0.9.2"

	t.window = {}
	t.window.title = "Radial Clock"
	t.window.width = 600
	t.window.height = 600
	t.window.fullscreen = false
	--t.window.borderless = true
	t.window.resizable = true

	--t.modules = {}
	t.modules.joystick = false
	t.modules.physics = false
end
