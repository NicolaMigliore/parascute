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
        trigger = new_trigger(0,2,4,3, function(_e,_o)
            if _o.kind == "environment" then
                del(entities,_e)
                add(caught_eggs,false)
                score-=1
            end
        end)
    }))
end