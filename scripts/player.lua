function _player_i()

    transition_timer = 0
    transition_time = 600

    player_speed = 0.5
    player_jump_force = 15

    player = new_entity({
        kind = "player",
        position = new_position(0,56,16,16),
        sprite = new_sprite({
            {x=8,y=0,w=16,h=16},
            {x=24,y=0,w=16,h=16},
            {x=40,y=0,w=16,h=16},
            {x=56,y=0,w=16,h=16}
        }),
        control = new_control(⬅️,➡️,⬆️,⬇️,0.7,1,player_input),
        intention = new_intention(),
        collider = new_collider(0,0,16,16,{}),
        animation = new_animation({
            idle = {
                frames = {
                    {x=96,y=16,w=16,h=16},
                    {x=112,y=16,w=16,h=16}
                },
                speed = 0.02,
                loop = true
            },
            move = {
                frames = {
                    {x=8,y=0,w=16,h=16},
                    {x=24,y=0,w=16,h=16},
                    {x=40,y=0,w=16,h=16},
                    {x=56,y=0,w=16,h=16}
                },
                speed = 0.05,
                loop = true
            },
            jump = {
                frames = {
                    {x=56,y=0,w=16,h=16},
                    {x=72,y=0,w=16,h=16},
                    {x=88,y=0,w=16,h=16}
                },
                speed = 0.05,
                loop = false
            },
            fall = {
                frames = {
                    {x=88,y=0,w=16,h=16},
                    {x=104,y=0,w=16,h=16}
                },
                speed = 0.04,
                loop = false
            }
        },
        "idle",
        function (_e)
            local a = _e.animation
            local new_anim = "idle"

            if (_e.intention.is_moving) new_anim = "move"
            if (_e.intention.is_jumping) new_anim = "jump"
            if (_e.collider.is_falling) new_anim = "fall"

            if a.active_anim != new_anim then
                a.active_anim = new_anim
                _e.sprite.spr_i = 1
            end
        end
    ),
        trigger = new_trigger(-1,-1,18,8,function(_e,_o)
            if _o.kind == "egg" then
                del(entities,_o)
                add(caught_eggs,true)
                score +=1
                if score%3 == 0 then
                    level += 1
                    eagle.control.spd_x += 0.2
                end
            end
        end)
    })
    add(entities,player)
end

function player_input(_e)
    -- player movement
    _e.intention.left = btn(_e.control.left)
    _e.intention.right = btn(_e.control.right)
    _e.intention.up = btn(_e.control.up)
    _e.intention.down = btn(_e.control.down)
    _e.intention.is_moving = _e.intention.left
        or _e.intention.right
        -- or _e.intention.up
        -- or _e.intention.down
    _e.intention.is_jumping = _e.intention.up
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
    end

    
end