function _init()
    debug=""
    mode="start"
    music(0)

    _player_i()
end

function _update60()
    _player_u()
end

function _draw()
    cls(12)
	rectfill(0,72,128,128,4)

    _player_d()

    --debugging
    if debug != "" then
        print(debug,10,8)
    end
end