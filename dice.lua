now = os.time()
math.randomseed(now)

function dice(user_id)


send_msg(user_id, math.random(1,6), ok_cb, false)
end
