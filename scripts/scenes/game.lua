function _scene_game_i()
    load_scene_game()
end

function _scene_game_u()
    control_system.update()
    physics_system.update()
    animation_system.update()
    trigger_system.update()
    particle_system.update()

    _cloud_u()

    -- check if level is complete
    if #caught_eggs > 23 then
        load_scene_level_complete()
    end
end

function _scene_game_d()
    gs.update()
    _ui_d()
end

function load_scene_game()
    entities = {}
    particles = {}
    caught_eggs = {}
    score = 0
    level = 0
    mode = "game"

    music(0)

    -- create scene entities
    -- create ground 
    add(entities,new_entity({
        kind = "environment",
        position = new_position(0,100,128,28),
        sprite = new_sprite({{x=120,y=32,w=8,h=8}}),
        collider = new_collider(0,0,127,55,{
            gravity = false,
            mass = 0,
        }),
    }))
    -- create left border
    add(entities,new_entity({
        kind = "environment",
        position = new_position(-5,0,-5,128),
        collider = new_collider(0,0,5,128,{
            gravity = false,
            mass = 0,
        }),
    }))
    -- create right border
    add(entities,new_entity({
        kind = "environment",
        position = new_position(128,0,133,128),
        collider = new_collider(0,0,5,128,{
            gravity = false,
            mass = 0,
        }),
    }))

    -- tree 1
    add(entities,new_entity({
        kind ="scene",
        position = new_position(100,68,32,32,2),
        sprite = new_sprite({{x=0,y=48,w=16,h=16}},false),
    }))


    -- setup other entities
    _player_i()
    _eagle_i()
    _basket_i()
    _cloud_i()
end