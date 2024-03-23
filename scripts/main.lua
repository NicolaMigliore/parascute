function _init()
    debug=""
    mode="start"
    music(0)

    entities = {}
    control_system = create_control_system()
    physics_system = create_physics_system()
    gs = create_graphics_system()

    _player_i()
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