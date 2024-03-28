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
function new_sprite(_sprites,_flip_x,_flip_y)
    _flip_x = _flip_x or false
    _flip_y = _flip_y or false
    local s = {
        sprites = _sprites,
        spr_i = 1,
        flip_x = _flip_x,
        slip_y = _flip_y,
    }
    return s
end

function new_animation(_animations,_active_anim)
    local a = {
        animations = _animations,
        active_anim = _active_anim,
    }
    a.set_animation = function(_name,_spr)
        if a.active_anim != _name then
            if a.animations[_name] then
                a.active_anim = _name
            else
                a.active_anim = "idle"
            end
            _spr.spr_i = 1
        end
    end
    return a
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

--- create new intention component
-- describes the entity's intention to move in a direction
function new_intention()
    local i = {
        left = false,
        right = false,
        up = false,
        down = false,
        is_moving = false,
        is_jumping = false,
        is_falling = false
    }
    return i
end

--- create a collider box component
-- it knows it's x and y offset relative to the entity position
function new_collider(_ox,_oy,_w,_h,_gravity,_oncollide)
    local c = {
        ox = _ox,
        oy = _oy,
        w = _w,
        h = _h,
        collide_r = false,
        collide_l = false,
        collide_t = false,
        collide_b = false,
        gravity = _gravity,
        show = false,
        has_collision = false,
        is_falling = _gravity,
        oncollide = _oncollide,
    }
    c.get_bounding_box = function(_pos)
        --- @param _pos: poistion component
        return {
            x = _pos.x + c.ox,
            y = _pos.y + c.oy,
            w = c.w,
            h = c.h
        }
    end
    return c
end

function new_trigger(_ox,_oy,_w,_h,_f)
    local t = {
        ox = _ox,
        oy = _oy,
        w = _w,
        h = _h,
        f = _f,
    }
    return t
end


--- create entity ---
function new_entity(_kind,_pos,_spr,_ctrl,_inte,_col,_anim,_tri)
    local e = {
        kind = _kind,
        position = _pos,
        sprite = _spr,
        control = _ctrl,
        intention = _inte,
        collider = _col,
        animation = _anim,
        trigger = _tri,
    }
    return e
end