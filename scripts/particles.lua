-- spawn static pixel
-- function spawn_static_pixel(_x,_y,_colors,_max_age)
--     _max_age = _max_age or rnd(20)+10
--     add_particle(_x,_y,0,0,0,_max_age,_colors,1)
-- end

-- spawn trail particles
function spawntrail(_x,_y,_colors,_max_age)
	if rnd() < 0.5 then return end

    local max_age = _max_age or 15+rnd(15)
	local angle = rnd()
	local offset_x = sin(angle)*0.6
	local offset_y = cos(angle)*0.6
	
	local p = new_particle(
        "pixel",
        new_position(_x+offset_x, _y+offset_y, 1,1),
		0,
		0,
		max_age,
		_colors
	)
    add(particles, p)
end