--- 전산실 수업 리스트 ---
function comroom(user_id)
    send_text(user_id, func_path .. '113.txt', ok_cb, false)
end

---- 홈페이지 리스트 ----

function homepage(user_id)
    send_text(user_id, func_path .. 'homepagelist.txt', ok_cb, false)
end

function inje(user_id)
    send_text(user_id, func_path .. 'inje.txt', ok_cb, false)
end


function stud(user_id)
    send_text(user_id, func_path .. 'stud.txt', ok_cb, false)
end


function sail(user_id)
    send_text(user_id, func_path .. 'sail.txt', ok_cb, false)
end


function bme(user_id)
    send_text(user_id, func_path .. 'bme.txt', ok_cb, false)
end


---- 학교 번호 ----

function roomnumber(user_id)
    send_text(user_id, func_path .. 'roomnumber.txt', ok_cb, false)
end
	




