function spawn_egg(_x,_y)
    egg_mass = 1 + (level/10)
    debug=egg_mass
    -- create egg
    add(entities,new_entity({
        kind = "egg",
        position = new_position(_x,_y,4,4),
        sprite = new_sprite({{x=0,y=8,w=8,h=8}},0),
        collider = new_collider(0,0,4,4,{
            mass = egg_mass,
            is_solid = false,
        }),
        trigger = new_trigger(0,4,4,2, function(_e,_o)
            if _o.kind == "player" then
                del(entities,_e)
                score+=1
                if score%3 == 0 then
                    level += 1
                    eagle.control.spd_x += 0.2
                end
            end
            if _o.kind == "environment" then
                del(entities,_e)
                score-=1
            end
        end)
    }))
end