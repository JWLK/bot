now = os.time()
math.randomseed(now)

function ranchat(user_id)
	local x = math.random(1,3)
	if( x ==1) then
		send_msg(user_id,"사랑해", ok_cb, false)
	else if(x == 2) then
		send_msg(user_id,"미안" , ok_cb, false)
	else if(x == 3) then
		send_msg(user_id,"귀여워" , ok_cb, false)

end
