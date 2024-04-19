function log(_text)
	printh(_text,"parascute/log")
end

--- easing functions ---
-- credit for functions: https://www.lexaloffle.com/bbs/?pid=easingcheatsheet-2
function easeinoutquad(t)
	if(t<.5) then
		return t*t*2
	else
		t-=1
		return 1-t*t*2
	end
end


-- Enumerate and potentially filter a table
function filter(_t, _callback_fn)
	local new_table = {}
	for item in all(_t) do
		if (_callback_fn(item)) add(new_table, item)
	end
	return new_table
end
