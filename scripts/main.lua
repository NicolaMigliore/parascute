function _init()
    debug=""
    show_colliders = false

    mode="start"
    music(0)

    entities = {}
    control_system = create_control_system()
    physics_system = create_physics_system()
    gs = create_graphics_system()

    _player_i()

    -- create ground 
    add(entities,new_entity(
        new_position(0,72,127,127),
        nil,
        nil,
        nil,
        new_collider(0,0,127,55)
    ))
end

function _update60()
    control_system.update()
    physics_system.update()
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