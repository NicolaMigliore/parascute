function spawn_egg(_x,_y)
    egg_mass = 2 + (level/10)
    -- create egg
    add(entities,new_entity({
        kind = "egg",
        position = new_position(_x,_y,4,4),
        sprite = new_sprite({{x=8,y=0,w=8,h=8}}),
        collider = new_collider(0,0,4,4,{
            mass = egg_mass,
            is_solid = false,
        }),
        trigger = new_trigger(0,2,4,4,egg_trigger,"always"),
        control = new_control(nil,nil,nil,nil,nil,nil,egg_control),
    }))
    sfx(20)
end

function egg_control(_e)
    -- spawn trail particles
    local offset = (sin(_e.position.y))---0.5
    local px = _e.position.x + 2 + offset
    spawntrail(px, _e.position.y, {15}, 6+rnd(3,3,7))
end

function egg_trigger(_e,_o)
    if _o.kind == "environment" then
        del(entities,_e)
        add(caught_eggs,false)
        score-=1

        -- add Fxs
        spawn_shatter(_e.position.x,_e.position.y,{7},{chunk_sprites = {}})
        sfx(22)
    end
end