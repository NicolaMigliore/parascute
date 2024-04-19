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
		_colors,
		nil,
		{}
	)
    add(particles, p)
end

--spawn smoke
function spawn_smoke(_x,_y,_colors,_opts)
	for i=0, 2+rnd(4) do
		local angle = _opts.angle or rnd()
		local max_size = _opts.max_size or 0.5+rnd(2)
		local dx = sin(angle)*0.05
		local dy = cos(angle)*0.05

		if (_opts.dx) dx = _opts.dx
		if (_opts.dy) dx = _opts.dy 

		local p = new_particle(
			"smoke",
			new_position(_x,_y,max_size,0),
			dx,
			dy,
			30,
			_colors,
			max_size,
			{}
		)
		add(particles, p)
	end
end

-- 
function spawn_shatter(_x,_y,_colors,_opts)
	local chunk_sprites = _opts.chunk_sprites
	local tmp_dx, tmp_dy = _opts.dx or 0, _opts.dy or -1

	for i=1,rnd(10,15) do
		local angle = rnd()
		local dx = sin(angle)*rnd(1.5)+(tmp_dx/2)
		local dy = cos(angle)*rnd(1.5)+(tmp_dy/2)

		local p = new_particle(
			"pixel",
			new_position(_x,_y,1,0),
			dx,
			dy,
			30,
			_colors,
			1,
			{ has_gravity=true }
		)
		add(particles, p)
	end
	-- if chunk_sprites != nil then
	-- 	local chunks_no=1+flr(rnd(2))
	-- 	for i=0, chunks_no do
	-- 		local angle = rnd()
	-- 		local dx = sin(angle)*rnd(1.5)+(tmp_dx/2)
	-- 		local dy = cos(angle)*rnd(1.5)+(tmp_dy/2)
	-- 		local sprt = rnd(chunk_sprites)
	-- 		addparticle(_x,_y,dx,dy,2,30,{sprt})
	-- 		local p = new_particle(
	-- 			"sprite",
	-- 			new_position(_x,_y,1,0),
	-- 			dx,
	-- 			dy,
	-- 			30,
	-- 			_colors,
	-- 			1
	-- 		)
	-- 		add(particles, p)
	-- 	end
	-- end
end