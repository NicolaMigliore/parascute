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

function new_animation(_animations,_active_anim,_set_anim)
    local a = {
        animations = _animations,
        active_anim = _active_anim,
    }
    a.set_animation = _set_anim
    return a
end

--- create new control component
-- describes the intity's controls
function new_control(_left,_right,_up,_down,_spd_x,_spd_y,_input)
    local c = {
        left = _left,
        right = _right,
        up = _up,
        down = _down,
        spd_x = _spd_x,
        spd_y = _spd_y,
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
-- function new_collider(_ox,_oy,_w,_h,_gravity,_oncollide,_mass,_solid)
function new_collider(_ox,_oy,_w,_h,_opts)
    -- calculate defaults
    local is_solid,gravity,mass = true, true, 1
    if (_opts.is_solid != nil) is_solid = _opts.is_solid
    if (_opts.gravity != nil) gravity = _opts.gravity
    if (_opts.mass != nil) mass = _opts.mass

    local c = {
        ox = _ox,
        oy = _oy,
        w = _w,
        h = _h,
        collide_r = false,
        collide_l = false,
        collide_t = false,
        collide_b = false,
        gravity = gravity,
        show = false,
        has_collision = false,
        is_falling = gravity,
        oncollide = _opts.oncollide,
        mass = mass,
        is_solid = is_solid,
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

function new_trigger(_ox,_oy,_w,_h,_f,_kind)
    --- kinds:
    ---- "once"     - calls function once then delets the trigger
    ---- "always"   - calls function every frame that it is triggered
    ---- "wait"     - waits for trigger to no longer be activated then calls function
    local t = {
        ox = _ox,
        oy = _oy,
        w = _w,
        h = _h,
        f = _f,
        kind = _kind,
        is_active = false
    }
    return t
end


--- create entity ---
function new_entity(_opts)
    local e = {
        kind = _opts.kind,
        position = _opts.position,
        sprite = _opts.sprite,
        control = _opts.control,
        intention = _opts.intention,
        collider = _opts.collider,
        animation = _opts.animation,
        trigger = _opts.trigger,
    }
    return e
end

-- create particle --
function new_particle(_kind,_pos,_dx,_dy,_max_age,_colors,_max_size,_opts)
    local p = {
        position = _pos,
        dx=_dx,
        dy=_dy,
        kind=_kind,
        age=0,
        max_age=_max_age,
        colors=_colors,
        color=_colors[1],
        max_size=_max_size,
        has_gravity=_opts.has_gravity or false,
        has_gravity=_opts.has_rotation or false,
    }
    return p
end
