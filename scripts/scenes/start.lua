function _scene_start_i()
    load_scene_start()
end

function _scene_start_u()
    if btnp(❎) then
        load_scene_game()
    end
end


function _scene_start_d()
    cls()
    print("parascute",50,64,3)
end

function load_scene_start()
    mode = "start"
end