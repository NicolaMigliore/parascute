--- create graphics system
-- handles game graphics
function create_graphics_system()
    local gs = {}
    gs.update = function()
        cls(12)
    
        -- draw world
        rectfill(0,72,128,128,4)
    
        -- draw entities
        for e in all(entities) do
            -- render entity
            if e.sprite != nil and e.position != nil then
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
            if e.collider != nil and (e.collider.show or show_colliders) then
                local color = e.collider.has_collision and 8 or 7
                rect(
                    e.position.x + e.collider.ox,
                    e.position.y + e.collider.oy,
                    e.position.x + e.collider.ox + e.collider.w,
                    e.position.y + e.collider.oy + e.collider.h,
                    color
                )
            end
        end
    end

    return gs
end

--- create control system
-- handles entity controls
function create_control_system()
    local cs = {}
    cs.update = function()
        for e in all(entities) do
            -- update entity movement intention
            if e.control != nil and e.intention then
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
            -- update entity movement intention
            if e.position != nil and e.intention then

                local can_move_x, can_move_y = true, true
                local new_x = e.position.x
                local new_y = e.position.y

                -- left movement
                if e.intention.left then
                    new_x -=1
                    if (e.sprite != nil) e.sprite.flip_x = true
                end
                -- right movement
                if e.intention.right then
                    new_x +=1
                    if (e.sprite != nil) e.sprite.flip_x = false
                end
                -- up movement
                if e.intention.up then
                    new_y -=1
                end
                -- if e.intention.down then e.position.y +=1 end

                -- apply gravity
                new_y += 0.65

                -- check for collisions with other entities
                for o in all(entities) do
                    if o != e and o.collider != nil then
                        e.collider.has_collision = false

                        
                        -- check horizontal collision
                        if colliding(
                            new_x + e.collider.ox, e.position.y + e.collider.oy, e.collider.w, e.collider.h,
                            o.position.x + o.collider.ox, o.position.y + o.collider.oy, o.collider.w, o.collider.h
                        ) then 
                            can_move_x = false
                            e.collider.has_collision = true
                        end

                        --check vertical collision
                        if colliding(
                            e.position.x  + e.collider.ox, new_y  + e.collider.oy, e.collider.w, e.collider.h,
                            o.position.x + o.collider.ox, o.position.y + o.collider.oy, o.collider.w, o.collider.h
                        ) then 
                            can_move_y = false
                            e.collider.has_collision = true
                        end
                    end
                end
                -- update entity position
                if (can_move_x) e.position.x = new_x
                if (can_move_y) e.position.y = new_y
            end
        end
    end
    return ps
end

function colliding(x1,y1,w1,h1,x2,y2,w2,h2)
    return flr(x1+w1) > flr(x2) and flr(x1) < flr(x2+w2)
        and flr(y1+h1) > flr(y2) and flr(y1) < flr(y2+h2)
end