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
        "player",
        new_position(0,56,16,16),
        --new_sprite({1,3,5,7},0.05)
        new_sprite({
            {x=8,y=0,w=16,h=16},
            {x=24,y=0,w=16,h=16},
            {x=40,y=0,w=16,h=16},
            {x=56,y=0,w=16,h=16}
        }),
        new_control(⬅️,➡️,⬆️,⬇️,player_input),
        new_intention(),
        new_collider(0,0,16,16,true,player_collide),
        new_animation({
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
        },"idle"),
        new_trigger(0,-5,16,6,function(_e,_o)
            if _o.kind == "egg" then
                del(entities,_o)
                score +=1
            end
        end)
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
    -- if player.sprite.spr_i < #player.sprite.sprites + 1 - player.sprite.anim_speed then
    --     player.sprite.spr_i += player.sprite.anim_speed
    -- else
    --     player.sprite.spr_i = 1
    -- end

    
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

function delete_entity(_e)
    log("------------")
    log("len: "..#entities)
    del(entities, _e)
    log("len: "..#entities)
end

--- Handle player collisions
-- @param _ce: Collided entity, a reference to the entity the player collided with
function player_collide(_ce)
    --log("Hit entity: ".._ce.kind)
    if _ce.kind == "egg" then
        --_ce.collider = nil
        -- delete_entity(_ce)
    end
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