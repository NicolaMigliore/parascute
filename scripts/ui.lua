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
            local sprite = caught_eggs[i] and 64 or 66
            spr(sprite, x, y)
        else
            spr(65, x, y)
        end

    end

    -- print("score: "..score,10,121,7)
    -- print("level: "..level,50,121,7)
end