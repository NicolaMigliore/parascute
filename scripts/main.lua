function _init()
    debug=""
    show_colliders = false
    score = 0
    level = 0
    caught_eggs = {}

    mode="start"
    music(0)

    entities = {}
    control_system = create_control_system()
    physics_system = create_physics_system()
    gs = create_graphics_system()
    animation_system = create_animation_system()
    trigger_system = create_trigger_system()

    _player_i()
    _eagle_i()

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
end

function _update60()
    control_system.update()
    physics_system.update()
    animation_system.update()
    trigger_system.update()
end

function _draw()
    gs.update()
    _ui_d()

    --debugging
    if debug != "" then
        print(debug,10,8)
    end
end