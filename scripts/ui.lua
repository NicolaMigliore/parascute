function _ui_i()
    blink_color1 = {
        colors={7,6,7},
        ci=1,
        color=7
    }
end

function _ui_u()
    blink_color1.ci+=1/30
    if(blink_color1.ci>#blink_color1.colors+1) blink_color1.ci=1
    blink_color1.color=blink_color1.colors[flr(blink_color1.ci)]
end

function _ui_d()
    palt(0,false)
    rect(4,104,123,126,0)
    palt()
    rectfill(5,105,122,125,5)
    local row = 0
    for i=1,24 do
        row = flr(i/12)
        x = (((i-1)%12) * 9)+10
        y = (flr(i/13) * 9)+107
        
        if i <= #caught_eggs then
            local sprite = caught_eggs[i] and 1 or 2
            spr(sprite, x, y)
        else
            spr(3, x, y)
        end
    end
end