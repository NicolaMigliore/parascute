function _player_i()
    sprites = { 1, 3, 5, 7 }
    spr_i = 1
    anim_speed = 0.05
    transition_timer = 0
    transition_time = 600
    tortoise_x = 0
    y = 56
end

function _player_u()
    --move
    transition_timer += 1
    if transition_timer > transition_time then
        transition_timer = 0
    end

    transition_perc = transition_timer / transition_time
    local dx = 128
    tortoise_x = flr(transition_perc * dx)

    --update animations
    if spr_i < #sprites + 1 - anim_speed then
        spr_i += anim_speed
    else
        spr_i = 1
    end
end

function _player_d()
    spr(sprites[flr(spr_i)],tortoise_x,y,2,2)
end