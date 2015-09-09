    -- 수신 받은 메시지 중 특정 단어에 대해 처리 하는 함수들
function Hello(user_id)
    send_msg(user_id, '안녕하세요!', ok_cb, false)
end
 
function intro(user_id)
    send_msg(user_id, 'INJE UNIVERSITY BME NetworkTeam,\n 팀원들에게 편리 제공을 위해 만들어진 봇입니다.\n 궁금한점은 "명령어" 를 입력해주세요!', ok_cb, false)
end

function qwe(user_id)
    send_msg(user_id, '뭐 이 바보야', ok_cb, false)
end
 

