function _init()
    debug=""
    show_colliders = true

    mode="start"
    music(0)

    entities = {}
    control_system = create_control_system()
    physics_system = create_physics_system()
    gs = create_graphics_system()
    animation_system = create_animation_system()
    trigger_system = create_trigger_system()

    _player_i()

    -- create ground 
    add(entities,new_entity(
        "environment",
        new_position(0,100,127,27),
        nil,
        nil,
        nil,
        new_collider(0,0,127,55,false,nil),
        nil,
        nil
    ))

    -- create egg
    add(entities,new_entity(
        "egg",
        new_position(32,32,4,4),
        new_sprite({{x=0,y=8,w=8,h=8}},0),
        nil,
        nil,
        new_collider(0,0,4,4,true,nil),
        nil,
        new_trigger(-3,-1,8,6,function(egg,other)
            if other.kind == "player" then
                del(entities,egg)
                log("deleted egg")
            end
        end)
    ))
end

function _update60()
    control_system.update()
    physics_system.update()
    animation_system.update()
    trigger_system.update()
    _player_u()
end

function _draw()

    -- _player_d()
    gs.update()

    --debugging
    if debug != "" then
        print(debug,10,8)
    end
end