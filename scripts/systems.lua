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
    local ps = {
        floor_y = 72
    }
    ps.update = function()
        for e in all(entities) do
            -- update entity movement intention
            if e.position != nil and e.intention then
                -- left movement
                if e.intention.left then
                    e.position.x -=1
                    if (e.sprite != nil) e.sprite.flip_x = true
                end
                -- right movement
                if e.intention.right then
                    e.position.x +=1
                    if (e.sprite != nil) e.sprite.flip_x = false
                end
                -- up movement
                if e.intention.up then
                    e.position.y -=1
                    
                end
                -- if e.intention.up then e.position.y -=1 end
                -- if e.intention.down then e.position.y +=1 end

                -- apply gravity
                if e.position.y < ps.floor_y - e.position.h then
                    player.position.y += 0.65
                end
            end
        end
    end
    return ps
end