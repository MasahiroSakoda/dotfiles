local function keyCode(key, modifiers)
	modifiers = modifiers or {}
	return function()
		hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
		hs.timer.usleep(500)
		hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
	end
end

local function remapKey(modifiers, key, code)
	hs.hotkey.bind(modifiers, key, code, nil, code)
end

local function keyCodeSet(keys)
	return function()
		for _, keyEvent in ipairs(keys) do
			keyEvent()
		end
	end
end

--
remapKey({'ctrl', 'alt'}, 'h', keyCode('left', {'ctrl'}))
remapKey({'ctrl', 'alt'}, 'l', keyCode('right', {'ctrl'}))

-- This key map is replaced by Karabiner Elements
--[[

-- Ctrl+h/j/k/l
remapKey({'ctrl'}, 'h', keyCode('left'))
remapKey({'ctrl'}, 'j', keyCode('down'))
remapKey({'ctrl'}, 'k', keyCode('up'))
remapKey({'ctrl'}, 'l', keyCode('right'))

-- Ctrl+Shift+h/j/k/l
remapKey({'ctrl', 'shift'}, 'h', keyCode('left', {'shift'}))
remapKey({'ctrl', 'shift'}, 'j', keyCode('down', {'shift'}))
remapKey({'ctrl', 'shift'}, 'k', keyCode('up', {'shift'}))
remapKey({'ctrl', 'shift'}, 'l', keyCode('right', {'shift'}))

-- Ctrl+cmd+h/j/k/l
remapKey({'ctrl', 'cmd'}, 'h', keyCode('left', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'j', keyCode('down', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'k', keyCode('up', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'l', keyCode('right', {'cmd'}))

-- Ctrl+Shift+cmd+h/j/k/l
remapKey({'ctrl', 'shift', 'cmd'}, 'h', keyCode('left', {'shift', 'cmd'}))
remapKey({'ctrl', 'shift', 'cmd'}, 'j', keyCode('down', {'shift', 'cmd'}))
remapKey({'ctrl', 'shift', 'cmd'}, 'k', keyCode('up', {'shift', 'cmd'}))
remapKey({'ctrl', 'shift', 'cmd'}, 'l', keyCode('right', {'shift', 'cmd'}))

remapKey({'ctrl', 'alt'}, 'h', keyCode('left', {'alt'}))
remapKey({'ctrl', 'alt'}, 'j', keyCode('down', {'alt'}))
remapKey({'ctrl', 'alt'}, 'k', keyCode('up', {'alt'}))
remapKey({'ctrl', 'alt'}, 'l', keyCode('right', {'alt'}))

remapKey({'ctrl', 'shift', 'alt'}, 'h', keyCode('left', {'shift', 'alt'}))
remapKey({'ctrl', 'shift', 'alt'}, 'j', keyCode('down', {'shift', 'alt'}))
remapKey({'ctrl', 'shift', 'alt'}, 'k', keyCode('up', {'shift', 'alt'}))
remapKey({'ctrl', 'shift', 'alt'}, 'l', keyCode('right', {'shift', 'alt'}))

remapKey({'ctrl', 'cmd', 'alt'}, 'h', keyCode('left', {'cmd', 'alt'}))
remapKey({'ctrl', 'cmd', 'alt'}, 'j', keyCode('down', {'cmd', 'alt'}))
remapKey({'ctrl', 'cmd', 'alt'}, 'k', keyCode('up', {'cmd', 'alt'}))
remapKey({'ctrl', 'cmd', 'alt'}, 'l', keyCode('right', {'cmd', 'alt'}))


remapKey({'ctrl'}, '[', keyCodeSet({
	keyCode('escape'),
	keyCode(';', {'ctrl', 'shift'})
}))

]]

hs.hotkey.bind({'cmd', 'alt', 'ctrl'}, 'R', function()
	hs.reload()
end)
hs.alert.show("Config loaded")
