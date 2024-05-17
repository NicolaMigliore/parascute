pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- controllers
#include scripts/main.lua
#include scripts/player.lua
#include scripts/basket.lua
#include scripts/eagle.lua
#include scripts/egg.lua
#include scripts/rock.lua
#include scripts/cloud.lua
#include scripts/components.lua
#include scripts/systems.lua
#include scripts/ui.lua
#include scripts/particles.lua
#include scripts/utils.lua

-- scenes
#include scripts/scenes/start.lua
#include scripts/scenes/game.lua
#include scripts/scenes/level_complete.lua

__gfx__
000000000033ff000000000000dddd00000000000066660000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000f33f330000f00000dddddd0000d6d000666666000000000434300000000000000000000000000000000000043430000000000000000000000000000
007007000ffff33000ff00000dddddd00666655006666660000000033433300bbb00000000004343000000000000000334333000000000000000434300000000
00077000f33ffffff0fff00fdddddddd6dd6655666666666000000333433340b1b000000000334333000000000000033343334000bbb00000003343330000000
00077000f33f3ff3f33f30f3dddddddd6556d66566666666000000434343434bbb00000000333433340bbb00000000434343434bbb1b0000003334333400bbb0
00700700fffffff3fffffff3dddddddd0556666566666666000003343334334bb000000000434343434b1b00000003343334334bbbbb000000434343434bb1b0
000000000fff33f00fff33f00dddddd00066dd6006666660000044444444444b0000000003343334334bbb0000004444444444400000000003343334334bbbb0
0000000000ff330000ff330000dddd000066d50000666600000000bb00000bb00000000044444444444000000000000bb000bb00000000004444444444400000
000000000000000000000000000003f0000003f0000003f0000000bb00000bb00000000000bb00000bb000000000000bb000bb0000000000000bb000bb000000
999999990000000000000000999999990ff033ff0ff033ff000000bbb0000b000000000000bbb0000bbb00000000000b0000bbb000000000000bbb00bbb00000
4444444499999999000000004444444499999999f3fdfff300000000000000000000000000000000000000000000000000000000000000000000000000000000
04994490444444449999999904994490444444449999999900000000000000000000000000004343000000000000000043430000000000000000000000000000
04499440044994404444444404499440044994404444444400000000000000000000000000033433300000000000000334333000000000000000000000000000
094499400944994009449940094499400944994009449940000000000000000000000000003334333400bbb000000033343334000bbb00000000000000000000
09944990099449900994499009944990099449900994499000000000000000000000000000434343434bb1b0000000434343434bbb1b00000000434300000000
00994400009944000099440000994400009944000099440000000000000000000000000003343334334bbbb0000003343334334bbbbb00000003343330000000
00ddddddd0000000000000000000000000ddddddd00000000000000000000000000000004444444444400000000044444444444000000000003334333400bbb0
55555ddddd000000000000000000000055555ddddd000000000000000000000000000000000bb000bb000000000000bb000bb0000000000000434343434bb1b0
0055555dddd0000000000000000000000055555dddd00000000000000000000000000000000bb000bb00000000000bbb00bbb0000000000003343334334bbbb0
000555555ddd77700000000000000000000555555ddd7770000000000000000000000000000b0000b00000000000000000000000000000004444444444400000
00000555555778700000000000007770000005555557787000000000000777000000000000000000000000000000000000000000000000000000000000000000
00000005555577aa000000005557787000000005555577aa00000005557787000000000000000000000000000000000000000000000000000000000000000000
000005555555570a00000055555577aa000005555555570a0000055555577aa00000000000000000000000000000000043430000000000000000434300000000
7775555555550000077755555555570a777555555555000077755555555570a00000000000000000000000000000000334333000000000000003343330000000
0777555555000000007775555555500007775555550000000777555555550000000000000000000000000000000000333433340bbb000000003334333400bbb0
007775590000000000077759d555500000777559000000000077759d55550000999999990000000000000000000000434343434b1b00000000434343434bb1b0
0007700990000000000077909d5555000007700990000000000779f9d5555000444444449999999900000000000003343334334bbb00000003343334334bbbb0
000070900900000000000700dd05550000007093f9000000000073ffd05550000499449044444444999999990000444444444440000000004444444444400000
00000000000000000000000dd00555000000003fff00000000000ff300555000044994400449944044444444000000bb0000bb000000000000bb0000bb000000
00000000000000000000000000055000000000fff3000000000000f000550000094499400944994009449940000000bbb000bbb00000000000bbb000bbb00000
000000000000000000000000000550000000000ff000000000000000005500000994499009944990099449900000000000000000000000000000000000000000
00000000000000000000000000050000000000000000000000000000005000000099440000994400009944000000000000000000000000000000000000000000
00007700000000000000000000000000000000000000000000000070000000000000000000000000000000000000000000000000000007600000000099999999
00677777700000000000000000000000000000000770000000000067700000000000677700000000000000000000670000000000000007600000000099999999
06777777770000000000000000000000000000077777700000000067770000000067777700000000006777700000677077770000000077600000000099999999
66770007770000000067000000000000000000677777700000000066777000000067777700000000006777770000677007777700000076000000000099999999
06700000000000000067700000000770000000677777777000000006777000000077700000000000006777770000067000007766776776000000000099999999
06700000000000000677700000006777000000006777777000000006770000000000000000000000000677700000067000007667777670000000000099999999
00000006777000000677700000006777000000006777777700000007000000000000000000077000000000000000000000076777777677700000000099999999
00000066777700000777000000007777000000000677777700000000700000000000077000677000000000000777000000777777777777770000000099999999
00000067777700000000000000677770000000000677777706777677777770000000070067777700000000006777000000777777777777770000000000000000
00000677777677700006770000677770067000000000777006777677767777770000000067777770006770067777000000076777777677700000000000000000
07006677776677770006777006777770067000000000777000677767776777770067000006777770067770067700000000007667777670000000000000000000
07776777776777770066777706777770067006770000000000677777776777700067700000007700067700677700000000007766776776000000000000000000
77777777776777770067777706777770000006770000000000067777767777000067700000000000677700677000000007777700000076000000000000000000
00007777700677000067777777777777000006777000000000000077677700000006777000000000677770000000000077770000000077600000000000000000
00000777000000000077777770006777000000677000000000000000000000000000077000000000077777000000000000000000000007600000000000000000
00000000000000000000777700000670000000000000000000000000000000000000000000000000007777000000000000000000000007600000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000b333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000b3355333300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00b33355403330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b330dd4400330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b300dd4440033000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
033000d0440003300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b30000d0440000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33000000444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30000000044000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000044000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000044000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000044000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000044000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000554000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000554000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeee33333eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000ddddddddddddddddddddddddddddddddddddddd00000000000000000000000
eeeeeeeeeeeeeeeee30003333eeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000d111111111111111111111111111111111111111d0000000000000000000000
eeeddddddddddddd3007003333ddddddddddddddddddddddddddeee000000000d11111111111111111111111111111111111111111d000000000000000000000
eed1111111111113307000333331111111111111111111111111dee00000000d1111111bbbb1bbbb1bbbb1bbbb1b11b1bbbb1111111d00000000000000000000
ed111111111111133000003333311111111111111111111111111de00000000d1111111b33b1b3331b3331b3331b11b1b3331111111d00000000000000000000
d11bbbbbbbbb11133300033333311bbbbbbbbbbbbbbbbbbbbbb111d00000000d1111111b11b1b1111b1111b1111b11b1b1111111111d00000000000000000000
d11bbbbbbbbbb113333333333331bbbbbbbbbbbbbbbbbbbbbbbb11d00000000d1111111bbb31bbb113bb11b1111b11b1bb111111111d00000000000000000000
d11bbb33333bbb13333377777711bbbbbbbbbbbbbbbbbbbbbbbb11d00000000d1111111b33b1b3311133b1b1111b11b1b3111111111d00000000000000000000
d11bbb11111bbb113333366661113333333333333333bb33333311d00000000d1111111b11b1b1111111b1b1111b11b1b1111111111d00000000000000000000
d11bbbbbbbbbbb111333337771111111111111111111bb11111111d00000000d1111111b11b1bbbb1bbbb1bbbb1bbbb1bbbb1111111d00000000000000000000
d11bbbbbbbbbb311113333333111111111bbbbbbbb11bb1bbbbb11d00000000d1111111311313333133331333313333133331111111d00000000000000000000
d11bb33333333111111333331111111111bbbbbbbbb1bb1bbbbb11d00000000d1111111111111111111111111111111111111111111d00000000000000000000
d11bb11111111111111111111111111111bb33333331bb1bb33311d00000000d1111111111111111111111111111111111111111111d00000000000000000000
d11bb111bb111bbbbbb111bb111bbbbbb1bb11111111bb1bb11111d00000000d1111111111111111111111111111111111111111111d00000000000000000000
d11bb11bbbb11bbbbbb11bbbb11bbbbbb1bb1bb11bb1bb1bb11111d00000000d11bbbb11bb11b11b1bbbb1b1111bbbb1bbbb1bbbb11d00000000000000000000
d11bb11bbbb11bb33bb11bbbb11bb33331bb1bb11bb1bb1bbbb111d00000000d11b3331b33b1bbbb1b33b1b1111b33313b331b33311d00000000000000000000
d11bb1bb33bb1bb11bb1bb33bb1bb11111bb1bb11bb1bb1bbbb111d00000000d11b1111b11b1b33b1b11b1b1111b11111b111b11111d00000000000000000000
d11bb1bb11bb1bbbbbb1bb11bb1bbbbb11bb1bbbbbb1bb1bbbb111d00000000d11b1111b11b1b11b1bbbb1b1111bbb111b111bb1111d00000000000000000000
d11bb1bbbbbb1bbbbbb1bbbbbb13bbbbb1bb1bbbbbb1bb1bb33111d00000000d11b1111b11b1b11b1b3331b1111b33111b111b31111d00000000000000000000
d11bb1bb33bb1bb3bb11bb33bb11333bb1bb13333331bb1bb11111d00000000d11b1111b11b1b11b1b1111b1111b11111b111b11111d00000000000000000000
d11bb1bb11bb1bb1bb11bb11bb11111bb1bb11111111bb1bb11111d00000000d11bbbb13bb31b11b1b1111bbbb1bbbb11b111bbbb11d00000000000000000000
d11bb1bb11bb1bb13bb1bb11bb1bbbbbb1bbbbbbbbb1bb1bbbbb11d00000000d1133331133113113131111333313333113111333311d00000000000000000000
d11bb1bb11bb1bb11bb1bb11bb1bbbbbb1bbbbbbbb31bb1bbbbb11d000000000d11111111111111111111111111111111111111111dd00000000000000000000
d11331331133133113313311331333333133333333113313333311d0000000000d111111111111111111111111111111111111111d0000000000000000000000
ed111111111111111111111111111111111111111111111111111de00000000000ddddddddddddddddddddddddddddddddddddddd00000000000000000000000
eed1111111111111111111111111111111111111111111111111dee0000000000000000000000000000000000000000000000000000000000000000000000000
eeedddddddddddddddddddddddddddddddddddddddddddddddddeee0000000000000000000000000000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
011000210c0240c0200e0320e0310c0400c04210041100400c0500c0500e0400e0400c0400c0421003110030150541505010050100520c0520c050180001c0000c0540c0500e0500e05215052150501500015000
0110000018020180201a0301a03018040180521c0511c05018050180501a0501a05018050180521c0511c05021050210501c0501c0521805218050160000000018050180501a0501a05215052150501500000000
011000000c0500e0501005011050130501505016050000000c0500e0500f0501105013050140501605000000100500d0500f05011050120501405016050000000000000000000000000000000000000000000000
011800000c0530c023000000c0330c0530c023000000c0330c0530c023000000c0330c0530c023000000c0330c0530c023000000c0330c0530c023000000c0330c0530c023000000c0330c0530c023000000c033
011800101c03020030220301c0301c03020030220301c0301e0001e0301c0301d0301c0302000020030220301c03020030220301c0301c03020030220301c0301e0001e0301c0301d0301c030200002003022030
00100020021000210002140021350e01002142021300e01502140021320e01002145021300e012021450e01002140021350e01002142021300e01502140021320e01502140021320e010021450e012021450e015
011000200c0330c03320000200003c6150c0030c0030c0030c0330c0030c0330c0033c615220000c0330c0030c0330c0330c0033c6053c6150c0330c0330c0030c0330c0030c0330c0033c615220000c0330c033
011000201c0541c054145522005022050220521c050105522004520035000002005420045000001c0541c0452205222050105551c04522000220541c050220551c045000001c00010554200501c045200351c000
011000001a0441a0441a0401a0100e5400e5351a035230002004020042200351a0001a0401a0421a035000000e5420e5401a0351a0001e0421e0401e035000001a044200401e0421a0301a03214530125201a025
011000201c1541c144141002015422552221001c1541c1401055010545141002015022142225351c100101501c1421c135141002015222145221001c130101001c1501c145141001c1541c5541c1421c1421c535
011000001070010722107101470014720167201670010720107101072010710147001472016710167101070010720107101071014700147201671016700107101070010720107101470010720107201071010710
0102000634514305272d53628537245002d5152b5002b50034510305272d53628537245202d510005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001e00002e030290312402118011130111f7001d7001d7001b700187001870016700167001370013700137001370013700117001170011700117000f7000f7000c7000c7000c7000a7000a700077000770007700
000400000367503675056550565500645006450064500605006050060500605006050060500605006050060500605006050060500605006050060500605006050060500605006050060500605006050060500605
000300002565325655246542365321633206341d6351963317635136230f6240c6240962507623056240060400604006040060400604006040060400604006040060400604006040060400604006040060400604
001e00002b030270312202113011110111f7001d7001d7001b700187001870016700167001370013700137001370013700117001170011700117000f7000f7000c7000c7000c7000a7000a700077000770007700
010200001152111521125211354115546195561d5521d552005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
010200001d5211d5211e5211f541215462555629552295521d5001d5001e5001f5002150025500295002950200500005000050000500005000050000500005000050000500005000050000500005000050000500
0102000029521295212a5212b5412d546315563555235552000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0020000018c5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
01 0605074a
00 0605074a
00 06050844
02 06050844
03 0b424344
01 06474344
01 06450044
02 06420144

