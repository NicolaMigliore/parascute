function spawn_rock(_x,_y)
    rock_mass = 2 + (level/10)
    -- create rock
    add(entities, new_entity({
        kind = "rock",
        position = new_position(_x,_y,4,4),
        sprite = new_sprite({{x=32,y=0,w=8,h=8}}),
        collider = new_collider(0,0,4,4,{
            mass = rock_mass,
            is_solid = false,
        }),
        trigger = new_trigger(0,2,4,4,rock_trigger,"always"),
        control = new_control(nil,nil,nil,nil,nil,nil,rock_control),
    }))
    sfx(23)
end

function rock_control(_e)
    -- spawn trail particles
    local offset = (sin(_e.position.y))
    local px = _e.position.x + 2 + offset
    spawntrail(px, _e.position.y, {15}, 6+rnd(3,3,7))
end

function rock_trigger(_e,_o)
    if _o.kind != "basket" then
        del(entities,_e)
        
        -- add Fxs
        spawn_shatter(_e.position.x,_e.position.y,{5,6},{chunk_sprites = {}})
        sfx(22)
    end
end