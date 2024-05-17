function _scene_start_i()
    load_scene_start()
end

function _scene_start_u()
    particle_system.update()

    if btnp(❎) then
        load_scene_game()
    end

    
    -- spawn faling eggs
    if rnd() > 0.95 then
        local x = (rnd() * 108) + 10
        local y = rnd() * 5
        local sprite = rnd() > 0.3 and 1 or 4
        spawn_sprite(x ,y,sprite,{has_gravity=true,max_age=100})
    end

    start_blink_timer -=1
    if(start_blink_timer<0) start_blink_timer = 30 start_blink_toggle = not start_blink_toggle
end

function _scene_start_d()
    -- animation
    gs.update(4)

    -- print("parascute",50,64,3)
    palt(0, false)
    if(start_blink_toggle) palt(13, true)
    palt(14, true)
    sspr(0,64,55,27,37,34)
    palt()
    print("press ❎ to start",31,100,blink_color1.color)
end

function load_scene_start()
    start_blink_timer = 30
    start_blink_toggle = false
    mode = "start"
    music(5,1000)
end