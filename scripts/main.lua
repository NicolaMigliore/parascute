function _init()
    debug=""
    show_colliders = false
    mode="start"
    -- music(0)

    -- set global lists
    entities = {}
    particles = {}
    caught_eggs = {}

    -- load systems
    control_system = create_control_system()
    physics_system = create_physics_system()
    gs = create_graphics_system()
    animation_system = create_animation_system()
    trigger_system = create_trigger_system()
    particle_system = create_particle_system()

    -- setup scene
    --_scene_start_i()
    load_scene_start()
    -- _scene_game_i()

    

end

function _update60()
    

    if mode == "start" then
        _scene_start_u()
    elseif mode == "game" then 
        _scene_game_u()
    elseif mode == "level_complete" then 
        _scene_level_complete_u()
    end
end

function _draw()
    

    if mode == "start" then
        _scene_start_d()
    elseif mode == "game" then
        _scene_game_d()
    elseif mode == "level_complete" then 
        _scene_level_complete_d()
    end

    --debugging
    if debug != "" then
        print(debug,10,8)
    end
end