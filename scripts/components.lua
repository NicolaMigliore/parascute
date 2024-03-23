--- create position component ---
-- @param a parameter a desc
-- @param b parameter b desc
function new_position(_x,_y,_w,_h)
    local p = {
        x = _x,
        y = _y,
        w = _w,
        h = _h,
        dx = 0,
        dy = 0,
    }
    return p
end

--- create sprite component ---
-- @param _sprites List of sprites in the form {{sx,sy,sw,sh}} 
function new_sprite(_sprites,_anim_speed,_flip_x,_flip_y)
    _flip_x = _flip_x or false
    _flip_y = _flip_y or false
    local s = {
        sprites = _sprites,
        spr_i = 1,
        anim_speed = _anim_speed,
        flip_x = _flip_x,
        slip_y = _flip_y,
    }
    return s
end

--- create new control component
-- describes the intity's controls
function new_control(_left,_right,_up,_down,_input)
    local c = {
        left = _left,
        right = _right,
        up = _up,
        down = _down,
        input = _input
    }
    return c
end

--- create new intention controller
-- describes the entity's intention to move in a direction
function new_intention()
    local i = {
        left = false,
        right = false,
        up = false,
        down = false
    }
    return i
end

--- create entity ---
function new_entity(_pos,_spr,_ctrl,_inte)
    local e = {
        position = _pos,
        sprite = _spr,
        control = _ctrl,
        intention = _inte
    }
    add(entities,e)
    return e
end