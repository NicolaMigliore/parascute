function _cloud_i()
    cloud_timer = 0

    spawn_cloud((rnd()*40)+20,(rnd()*40)+10)
    spawn_cloud((rnd()*40)+60,(rnd()*40)+10)
end

function _cloud_u()
    cloud_timer += 1
    if cloud_timer > 450 then
        cloud_timer = 0

        -- spawn clouds
        local x,y = 130, (rnd() * 40) + 10
        spawn_cloud(x,y)
    end
end


function spawn_cloud(_x,_y)
    local sprite_x = rnd({0,16,24,32,48,64,80})
    if(rnd()>0.85) sprite_x = 96

    -- create new entity
    add(entities,new_entity({
        kind ="cloud",
        position = new_position(_x,_y,16,16,2),
        sprite = new_sprite({{x=sprite_x,y=32,w=16,h=16}},0),
        control = new_control(nil,nil,nil,nil,0.1,0.05,cloud_control),
        intention = new_intention()
    }))
end

function cloud_control(_e)
    if not _e.intention.is_moving then
        _e.intention.is_moving = true
        _e.intention.left = true
    end

    -- vertical movent
    local elevation = sin(time()) * 1
    if elevation > 0.9 then
        _e.intention.up = false
        _e.intention.down = true
    end
    if elevation < -0.9 then
        _e.intention.up = true
        _e.intention.down = false
    end

    -- delete far clouds
    if _e.position.x < -20 then
        del(entities, _e)
    end
end