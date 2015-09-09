food_dir = "/home/pi/tg/bot/foodcap/"


function food(user_id)
	send_msg(user_id, '학식입니다.', ok_cb, true)
	send_msg(user_id, '학교홈페이지에서 보기 \n http://goo.gl/bQ93eE', ok_cb, true)
	

	send_photo(user_id, food_dir .. "hac.png", ok_cb, false)
	


end

