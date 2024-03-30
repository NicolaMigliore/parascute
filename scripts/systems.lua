--- create graphics system
-- handles game graphics
function create_graphics_system()
    local gs = {}
    gs.update = function()
        cls(12)
    
        -- draw world
        rectfill(0,100,128,127,4)
    
        -- draw entities
        for e in all(entities) do
            -- render entity
            if e.sprite and e.position then
                local cur_sprite = e.sprite.sprites[flr(e.sprite.spr_i)]
                sspr(
                    cur_sprite.x,
                    cur_sprite.y,
                    cur_sprite.w,
                    cur_sprite.h,
                    e.position.x,
                    e.position.y,
                    e.position.w,
                    e.position.h,
                    e.sprite.flip_x,
                    e.sprite.flip_y
                )
            end

            -- render colliders
            if e.collider and (e.collider.show or show_colliders) then
                local color = e.collider.has_collision and 8 or 7
                rect(
                    e.position.x + e.collider.ox,
                    e.position.y + e.collider.oy,
                    e.position.x + e.collider.ox + e.collider.w,
                    e.position.y + e.collider.oy + e.collider.h,
                    color
                )
            end

            -- render triggers
            if e.trigger and show_colliders then
                local color = 10
                rect(
                    e.position.x + e.trigger.ox,
                    e.position.y + e.trigger.oy,
                    e.position.x + e.trigger.ox + e.trigger.w,
                    e.position.y + e.trigger.oy + e.trigger.h,
                    color
                )
            end
        end
    end

    return gs
end

function create_animation_system()
    local as = {}
    -- check if entity is falling
    as.update = function()
        for e in all(entities) do
            if e.sprite and e.animation then
                -- set animation sprites
                if (e.animation.set_animation) e.animation.set_animation(e)
 
                local cur_animation = e.animation.animations[e.animation.active_anim]
                local anim_speed = cur_animation.speed
                e.sprite.sprites = cur_animation.frames

                -- if e.animation.active_anim == "move" then
                --     log(e.animation.active_anim..": "..e.sprite.spr_i)
                -- end
                    -- progress animation
                if e.sprite.spr_i < #e.sprite.sprites + 1 - anim_speed then
                    e.sprite.spr_i += anim_speed
                elseif cur_animation.loop then
                    e.sprite.spr_i = 1
                -- elseif e.sprite.spr_i > #e.sprite.sprites then
                --     e.sprite.spr_i = #e.sprite.sprites
                end
            end
        end
    end
    return as
end

--- create control system
-- handles entity controls
function create_control_system()
    local cs = {}
    cs.update = function()
        for e in all(entities) do
            -- update entity movement intention
            if e.control and e.intention then
                e.control.input(e)
            end
        end
    end
    return cs
end

--- create physics system
-- handles entity movement
function create_physics_system()
    local ps = {}
    ps.update = function()
        for e in all(entities) do

            -- apply gravity
            if e.position and e.collider and e.collider.gravity then
                apply_gravity(e)
            end

            -- update entity movement intention
            if e.position and e.intention then

                local spd_x,spd_y = 1,1
                if e.control then
                    spd_x,spd_y = e.control.spd_x,e.control.spd_y
                end

                local can_move_x, can_move_y = true, true
                local new_x = e.position.x
                local new_y = e.position.y

                -- left movement
                if e.intention.left then
                    new_x -= 1 * spd_x
                    if (e.sprite) e.sprite.flip_x = true
                end
                -- right movement
                if e.intention.right then
                    new_x += 1 * spd_x
                    if (e.sprite) e.sprite.flip_x = false
                end
                -- up movement
                if e.intention.up then
                    new_y -= 1 * spd_y
                end
                if e.intention.down then
                    new_y += 1 * spd_y
                end

                -- check for collisions with other entities
                if e.collider then
                    for o in all(entities) do
                        if o != e and o.collider then
                            local o_bb = o.collider.get_bounding_box(o.position)
                            local e_bb = e.collider.get_bounding_box(e.position)

                            e.collider.has_collision = false

                            -- check horizontal collision
                            if colliding(
                                new_x + e.collider.ox, e_bb.y, e_bb.w, e_bb.h,
                                o_bb.x, o_bb.y, o_bb.w, o_bb.h
                            ) then 
                                can_move_x = false
                                e.collider.has_collision = true
                            end

                            --check vertical collision
                            if colliding(
                                e_bb.x, new_y  + e.collider.oy, e_bb.w, e_bb.h,
                                o_bb.x, o_bb.y, o_bb.w, o_bb.h
                            ) then
                                can_move_y = false
                                e.collider.has_collision = true

                                if e.collider.gravity 
                                    and new_y < o_bb.y
                                then
                                    e.collider.is_falling = false
                                end
                            end
                            if(e.collider and e.collider.has_collision) e.collider.oncollide(o)
                        end
                    end
                end

                -- update falling state
                if can_move_y 
                    and e.position.y > new_y 
                    and e.collider
                then
                    e.collider.is_falling = false
                end

                -- update entity position
                if (can_move_x) e.position.x = new_x
                if (can_move_y) e.position.y = new_y
            end       
        end
    end
    return ps
end

function create_trigger_system()
    local t = {}
    t.update = function()
        for e in all(entities) do
            if e.position and e.trigger then
                -- check for collisions with other entities
                for o in all(entities) do
                    if o.position and o.collider then
                        local o_bb = o.collider.get_bounding_box(o.position)
    
                        if colliding(
                            e.position.x + e.trigger.ox, e.position.y + e.trigger.oy, e.trigger.w, e.trigger.h,
                            o_bb.x, o_bb.y, o_bb.w, o_bb.h
                        ) then
                            e.trigger.f(e,o)
                        end
                    end
                end
            end
        end
    end
    return t
end

function colliding(x1,y1,w1,h1,x2,y2,w2,h2)
    return flr(x1+w1) > flr(x2) and flr(x1) < flr(x2+w2)
        and flr(y1+h1) > flr(y2) and flr(y1) < flr(y2+h2)
end

function apply_gravity(_e)
    local _pos,_col = _e.position, _e.collider
    local new_y = _pos.y
    new_y += 0.65 * _e.collider.mass
    _col.is_falling = true
    _col.collide_b = false

    --check vertical collision
    local entity_i,o = 1,nil

    for o in all(entities) do
        if _e != o and o.collider and o.position then
            local o_bb = o.collider.get_bounding_box(o.position)
            local e_bb = _col.get_bounding_box(_pos)

            local has_collision = colliding(
                e_bb.x, new_y+_col.oy, e_bb.w, e_bb.h,
                o_bb.x, o_bb.y, o_bb.w, o_bb.h
            )
            if new_y+_col.oy < o_bb.y and has_collision then
                _col.has_collision = has_collision
                _col.collide_b = has_collision
                _col.is_falling = false
            end
        end
        entity_i += 1
    end

    -- update position
    if not _col.collide_b then
        _pos.y = new_y
    end
end

-- --- sort the elements
-- function sort(_list)
--     for i=2,#_list do
--         local j = i
--         while j > 1 and _list[j-1].position.y + _list[j-1].position.h < _list[j].position.y + _list[j].position.h do
--             _list[j],_list[j-1] = _list[j-1],_list[j]
--             j-=1
--         end
--     end
-- end