function _eagle_i()
    drop_timer = 5--100
    eagle_spd = 1

    -- create eagle
    eagle = new_entity({
        kind = "eagle",
        position = new_position(20,10,16,16),
        sprite = new_sprite({
            {x=32,y=16,w=16,h=16},
        }),
        animation = new_animation({
            idle = {
                frames = {
                    {x=0,y=16,w=16,h=16},
                    {x=16,y=16,w=16,h=16}
                },
                speed = 0.1,
                loop = true
            },
            idle_with_egg = {
                frames = {
                    {x=32,y=16,w=16,h=16},
                    {x=48,y=16,w=16,h=16}
                },
                speed = 0.1,
                loop = true
            },
        },
        "idle_with_egg",
        function(_e)

        end
        ),
        control = new_control(nil,nil,nil,nil,eagle_spd,0.2,eagle_control),
        intention = new_intention()
    })
    add(entities,eagle)
end


function eagle_control(_e)
    if not _e.intention.is_moving then
        _e.intention.is_moving = true
        _e.intention.left = true
        _e.intention.right = false
    end

    -- horizontal movement
    if _e.intention.left and _e.position.x < 5 then
        _e.intention.left = false
        _e.intention.right = true
    end
    if _e.intention.right and _e.position.x > 106 then
        _e.intention.left = true
        _e.intention.right = false
    end

    -- vertical movent
    local elevation = sin(time())
    if elevation > 0.9 then
        _e.intention.up = false
        _e.intention.down = true
    end
    if elevation < -0.9 then
        _e.intention.up = true
        _e.intention.down = false
    end

    local rnd_val = rnd(10)
    -- switch direction
    if rnd_val > 9.9 then
        if _e.intention.left then
            _e.intention.left = false
            _e.intention.right = true
        else
            _e.intention.left = true
            _e.intention.right = false
        end
    end

    -- advance drop timer
    if rnd_val > 7 then
        drop_timer -= 1
        if drop_timer < 1 then
            drop_timer = 50
            if rnd()>0.5 then
                spawn_egg(_e.position.x+6,_e.position.y+12)
            else
                spawn_rock(_e.position.x+6,_e.position.y+12)
            end
        end
    end

    -- spawn trail particles
    local px = _e.intention.left and _e.position.x+12 or _e.position.x+4
    spawntrail(px, _e.position.y+6, {6,7})
    spawntrail(px, _e.position.y+10, {6,7})
end
