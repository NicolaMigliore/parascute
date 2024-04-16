function _basket_i()
    -- create basket
    basket = new_entity({
        kind = "basket",
        position = new_position(64,64,8,8),
        sprite = new_sprite({
            {x=8,y=0,w=8,h=8}
        }),
        animation = new_animation({
            idle = {
                frames = {
                    {x=8,y=0,w=8,h=8}
                },
                speed = 0.01,
                loop = true
            },
            catch = {
                frames = {
                    {x=8,y=0,w=8,h=8},
                    {x=16,y=0,w=8,h=8},
                    {x=24,y=0,w=8,h=8},
                    {x=8,y=0,w=8,h=8},
                },
                speed = 0.5,
                loop = false
            }
        },"catch",nil),
        control = new_control(nil,nil,nil,nil,nil,nil,basket_control),
        intention = new_intention(),
        trigger = new_trigger(-2,-1,11,8,basket_trigger,"always")
    })

    add(entities, basket)
end

function basket_control(_e)
    local offset_y = 0
    local offset_x = 0.5
    -- debug=player.intention.left
    if(player.intention.is_moving) offset_y = sin(time())/2
    if(player.intention.left) offset_x = -0.5
    _e.position.x = player.position.x + 6 + offset_x
    _e.position.y = player.position.y - 6 + offset_y
end

function basket_trigger(_e,_o)
    if _o.kind == "egg" then
        del(entities,_o)
        add(caught_eggs,true)
        score +=1
        if score%3 == 0 then
            level += 1
            eagle.control.spd_x += 0.2
        end
        
        -- trigger animation
        _e.animation.active_anim = "catch"
        _e.sprite.spr_i = 1

        -- spawn particles
        spawn_smoke(
            _o.position.x+2,
            _o.position.y+2,
            {5,6},
            { angle = 0.2, max_size = 2.5+rnd(2) }
        )
        sfx(21)
    end
end