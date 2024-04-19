function _scene_level_complete_i()
    load_scene_level_complete()
end

function _scene_level_complete_u()
    control_system.update()
    trigger_system.update()
    particle_system.update()

    if start_timer > 0 then
        start_timer -= 1
    elseif not started_count then
        started_count = true
        count_eggs = true
        music(4)
    end

    if(flash_color_timer > 0) flash_color_timer -= 1
   
    if btnp(❎) then
        if (not started_count) started_count = true count_eggs = true music(4)
        if (finished_count) load_scene_game()
    end
    if (btnp(🅾️) and finished_count) load_scene_start()

    debug=#egg_ents
end

function _scene_level_complete_d()
    -- animation
    gs.update(0)

    -- score
    local score_color = 3
    if (flash_color_timer > 0) score_color = flash_color
    print("level complet",30,10,3)
    print("score:"..score,65,62,score_color)

    -- commands prompt
    if (not started_count) print("press ❎ to count eggs",33,100,6)
    if (finished_count) print("press ❎ to restart",37,100,6) print("press 🅾️ to return to title",24,108,6)

    -- counted eggs
    rect(4,70,123,92,3)
    rectfill(5,71,122,91,5)
    local row = 0
    for i=1,24 do
        row = flr(i/12)
        x = (((i-1)%12) * 9)+10
        y = (flr(i/13) * 9)+73
        
        if i <= #counted_eggs then
            local sprite = counted_eggs[i] and 1 or 2
            spr(sprite, x, y)
        else
            spr(3, x, y)
        end
    end
end

function load_scene_level_complete()
    entities = {}
    particles = {}
    score = 0
    mode = "level_complete"
    music(-1,2000)

    started_count = false
    finished_count = false
    count_eggs = false
    start_timer = 90
    flash_color_timer = 0
    flash_color = 11
    counted_eggs = {}
    egg_ents = {}

    add(entities,new_entity({
        kind = "ui_egg_target",
        position = new_position(45,60,8,8),
        sprite = new_sprite({{x=40,y=0,w=8,h=8}}),
        trigger = new_trigger(0,8,8,6,ui_egg_trigger,"always"),
    }))
    
    for i=1, #caught_eggs do
        local egg_was_caught = caught_eggs[i]
        -- spr(1, 60, 60-(i*9))
        local sprite_x = egg_was_caught and 8 or 16
        add(entities,new_entity({
            kind = "ui_egg",
            position = new_position(45,20,8,8),
            sprite = new_sprite({{x=sprite_x,y=0,w=8,h=8}}),
            collider = new_collider(0,0,8,8,{}),
            -- trigger = new_trigger(0,2,4,4,rock_trigger,"always"),
            control = new_control(nil,nil,nil,nil,nil,nil,egg_animation_control),
        }))
    end
    egg_ents = filter(entities,filter_eggs)
end

function filter_eggs(_item)
    return _item.kind=="ui_egg"
end

function egg_animation_control(_e)
    -- execute only for the last egg
    if count_eggs and egg_ents[1] == _e then
        local mvmt_perc = _e.position.y / 60
        _e.position.y += 2 * easeinoutquad(mvmt_perc)
    end
end

function ui_egg_trigger(_e,_o)
    local smoke_c = {7,15,7,6}
    spawn_smoke(
        _o.position.x+2,
        _o.position.y+2,
        smoke_c,
        { angle = 0.2, max_size = 2.5+rnd(2), dx = -0.3 }
    )
    spawn_smoke(
        _o.position.x+6,
        _o.position.y+2,
        smoke_c,
        { angle = 0.2, max_size = 2.5+rnd(2), dx = 0.3 }
    )
    spawn_shatter(_o.position.x,_o.position.y,{5,6},{})
    -- adjust score based on last egg
    if caught_eggs[#caught_eggs] then
        score += 1
        flash_color = 11
    else
        score -= 1
        flash_color = 8
    end
    add(counted_eggs, caught_eggs[#caught_eggs])
    deli(caught_eggs,#caught_eggs)
    del(entities, _o)
    del(egg_ents, _o)
    
    -- FXs
    flash_color_timer = 20
    local count_perc = (20 - #entities-1) / 20
    if count_perc < 0.3 then
        sfx(24)
    elseif count_perc >= 0.3 and count_perc < 0.6 then
        sfx(25)
    else
        sfx(26)
    end
    
    if(#entities == 1) finished_count = true music(-1)
end