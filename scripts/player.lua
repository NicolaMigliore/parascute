function _player_i()

    transition_timer = 0
    transition_time = 600

    player_speed = 0.5
    player_jump_force = 15

    -- local anim_walk = new_animation({
    --     new_sprite({8,0,16,16}),
    --     new_sprite({24,0,16,16}),
    --     new_sprite({40,0,16,16}),
    --     new_sprite({56,0,16,16})},
    --     0.05
    -- )

    player = new_entity(
        new_position(0,50,16,16),
        --new_sprite({1,3,5,7},0.05)
        new_sprite({
            {x=8,y=0,w=16,h=16},
            {x=24,y=0,w=16,h=16},
            {x=40,y=0,w=16,h=16},
            {x=56,y=0,w=16,h=16}},
            0.05),
        new_control(⬅️,➡️,⬆️,⬇️,player_input),
        new_intention(),
        new_collider(0,0,16,16)
    )
    add(entities,player)
end

function _player_u()
    --move
    -- transition_timer += 1
    -- if transition_timer > transition_time then
    --     transition_timer = 0
    -- end

    -- transition_perc = transition_timer / transition_time
    -- local dx = 128
    -- player.position.x = flr(transition_perc * dx)

    -- manage input
    --player_input_old()
    
    --update animations
    if player.sprite.spr_i < #player.sprite.sprites + 1 - player.sprite.anim_speed then
        player.sprite.spr_i += player.sprite.anim_speed
    else
        player.sprite.spr_i = 1
    end
end

function player_input(_e)
    _e.intention.left = btn(_e.control.left)
    _e.intention.right = btn(_e.control.right)
    _e.intention.up = btn(_e.control.up)
    _e.intention.down = btn(_e.control.down)
end

function player_input_old()
    player.position.dx = 0
    player.position.dy = 0

    -- movement
    if btn(➡️) then
        player.position.dx = 1
        player.sprite.flip_x = false  
    end

    if btn(⬅️) then
        player.position.dx = -1
        player.sprite.flip_x = true
    end

    -- jump
    if btnp(❎) then
        player.position.dy = -1
        player.position.dx = player.position.dx * 70
    end

    player.position.x += player.position.dx * player_speed
    player.position.y += player.position.dy * player_jump_force

    -- apply gravity
    if(player.position.y < 72 - player.position.h) then
        player.position.y += 0.65
        debug = "falling"
    else
        debug = player.position.y
    end

    
end