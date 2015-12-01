


-- 인증된 사용자만 BOT을 이용하게 하기 위해 폰 번호를 배열로 등록해둔다.
auth_phone  = { ["821042152535"] = true, 
                ["821035891387"] = true,
                ["801098765432"] = true }

-- 만약 1개의 폰 번호만 등록하고 싶다면 다음과 같이 작성한다.
--[[
auth_phone  = { ["821012341234"] = true }
]]--


-- 로그인 한 ID를 저장하는 변수
our_id = 0

-- Shell Mode FLAG
shell_flag = 0

bot_path        = "/home/pi/tg/bot/"
shell_path      = "/home/pi/tg/bot/shell/"
temp_path       = "/home/pi/tg/bot/tmp/"

bus_path 	= "/home/pi/tg/bot/bus/"
func_path   = "/home/pi/tg/bot/funcf/"

require( "bot/common" )      -- common.lua 를 가져온다
require( "bot/sqlitedb" )    -- sqlite 관련 스크립트
require( "bot/webapi" )      -- 날씨 정보등 web에서 정보를 가져오는 기능 관련 스크립트
require( "bot/raspi" )       -- 라즈베리파이 전용 스크립트
require( "bot/recv_file" )   -- Telegram CLI가 수신 받는 '파일'을 처리 하는 스크립트
require( "bot/torrent" )     -- Torrent 관련 기능 스크립트
require( "bot/wol" )         -- WOL 관련 기능 스크립트
require ( "bot/resistorcalc" ) -- 저항 띄 색깔 계산기
require( "bot/shell" )          -- Shell Mode 스크립트

require ( "bot/basicchat" ) -- 일반적인 대화 
require ( "bot/food" ) -- 학식 
require ( "bot/bus" )

require ( "bot/func" ) -- txt 기능 묶음
require ( "bot/pic" )   -- 사진 기능 추가용
require ( "bot/dice" )  -- dice 실험용
require ( "bot/number")
--require ( "bot/ranchat" )   -- ranchat 실험


function DefaultMessage(user_id, cmd)
    local msg = '[' .. cmd .. '] 등록 되지 않은 키워드입니다, "명령어" 를 입력하세요'
    send_msg(user_id, msg, ok_cb, false)
end

function SendHelp(user_id)
    -- /home/pi/tg/bot/command.txt 파일이 있어야 한다
    send_text(user_id, bot_path .. 'command.txt', ok_cb, false)
end




-- cmd 의 문자열을 비교 하여 각각 함수를 호출 하는 기능을 한다.
-- 앞으로 BOT 명령어는 이곳에 추가한다.
function msg_processing(user_id, cmd, arg)
    if     ( cmd == '사진' )        then    TakePhoto(user_id)                -- Camera still
    elseif ( cmd == '날씨' )        then    GetWether(user_id, arg)           -- 날씨 정보 조회 (ex : 날씨 여의도)
    elseif ( cmd == '토렌트' )      then    SearchTorrent(user_id, arg)       -- 토렌트 검색
    elseif ( cmd == "다운" )        then    DownloadTorrent(user_id, arg)     -- 검색된 토렌트 중 원하는 Index 번호 토렌트 다운로드
    elseif ( cmd == "목록" )        then    SendTorrentSearchList(user_id)    -- 검색된 토렌트 목록을 다시 출력한다
    elseif ( cmd == "wol" )         then    WakeOnLan(user_id, arg)           -- WOL 

    -- 저항값 계산기어
    elseif ( cmd == "저항" )         then    CalcResistorColor(user_id, arg)
    elseif ( cmd == '명령어' )      then    SendHelp(user_id)                 -- 사용 방법 Text 파일 전송
    elseif ( cmd == "쉘모드" )     then    shell_flag = 1; send_msg(user_id, "쉘모드 활성화", ok_cb, false)
    elseif ( cmd == "쉘모드종료" )   then    shell_flag = 0; send_msg(user_id, "쉘모드 비활성화", ok_cb, false)
    elseif ( shell_flag == 1 )      then    print("Shell Mode")
    elseif ( cmd == '시스템' )        then    SendSystemInfo(user_id)
    elseif ( cmd == '설명' )        then 	intro(user_id)

----- 대화 기능 -------

--#1 hello 
    elseif ( cmd == 'ㅎㅇ' )        then    Hello(user_id)
    elseif ( cmd == '안녕' )        then    Hello(user_id)
    elseif ( cmd == '안녕?' )        then    Hello(user_id)
    elseif ( cmd == '바보' )        then    qwe(user_id, arg)



----- 추가 기능 -------
 
     elseif ( cmd == '학식' )        then    food(user_id, arg)  --- 학식 
     elseif ( cmd == '전산실' )         then    comroom(user_id)  --- 
     elseif ( cmd == '캠퍼스맵' )         then    campus(user_id)  --- 
     elseif ( cmd == '주사위' )         then    dice(user_id)  --- 
   --  elseif ( cmd == '랜쳇' )         then    ranchat(user_id)  --- 
     elseif ( cmd == '홈페이지' )    then homepage(user_id) -- 
     elseif ( cmd == '학교번호' )    then roomnumber(user_id) --     

------ 버스 소개 ------
	elseif ( cmd == '버스' )         then    Busintro(user_id)  --- 
	elseif ( cmd == '학교버스' )         then    Busintro(user_id)  --- 
	elseif ( cmd == '셔틀버스' )         then    Busintro(user_id)  --- 
	elseif ( cmd == '통학버스' )         then    Busintro(user_id)  --- 
	elseif ( cmd == '방학버스' )         then    Busintro2(user_id)  ---
------ 버스 수신 ------
	 elseif ( cmd == '인제대역' )         then    Bus0(user_id)  --- 
	 elseif ( cmd == '순환버스' )         then    Bus0(user_id)  --- 

	 elseif ( cmd == '동래' )            then    Bus1(user_id)  --- 
	 elseif ( cmd == '동래한전' )        then    Bus2(user_id)  --- 
	 elseif ( cmd == '하단' )           then    Bus3(user_id)  --- 
	 elseif ( cmd == '개금' )           then    Bus4(user_id)  --- 
	 elseif ( cmd == '해운대' )        then    Bus5(user_id)  --- 
	 elseif ( cmd == '영부' )          then    Bus6(user_id)  --- 
	 elseif ( cmd == '마산' )          then    Bus7(user_id)  --- 
	 elseif ( cmd == '창원' )          then    Bus8(user_id)  --- 
	 elseif ( cmd == '울산' )          then    Bus9(user_id)  --- 

	 elseif ( cmd == '양산' )          then    Bus10(user_id)  --- 
	 elseif ( cmd == '진해' )          then    Bus11(user_id)  --- 
	 elseif ( cmd == '장유' )          then    Bus12(user_id)  --- 
	 elseif ( cmd == '강서구청' )        then    Bus13(user_id)  --- 
	 elseif ( cmd == '강서구청역' )        then    Bus13(user_id)  --- 


---------- 방학중 운행 노선  ------
         elseif ( cmd == '방학강서구청' )        then    Bus14(user_id)  --- 방학
         elseif ( cmd == '방학강서구청역' )        then    Bus14(user_id)  --- 
         elseif ( cmd == '방학하단' )        then    Bus15(user_id)  --- 
         elseif ( cmd == '방학마산' )        then    Bus16(user_id)  --- 
         elseif ( cmd == '방학창원' )        then    Bus17(user_id)  --- 
         elseif ( cmd == '방학울산' )        then    Bus18(user_id)  --- 
         elseif ( cmd == '방학인제대역' )        then    Bus19(user_id)  --- 
	     elseif ( cmd == '방학순환버스' )        then    Bus19(user_id)  --- 

---------- 방학중 비 운행 노선  ------
         elseif ( cmd == '방학동래' )        then    Busx1(user_id)  --- 방학
         elseif ( cmd == '방학개금' )        then    Busx2(user_id)  --- 
         elseif ( cmd == '방학해운대' )        then    Busx3(user_id)  --- 
         elseif ( cmd == '방학영부' )        then    Busx4(user_id)  --- 
         elseif ( cmd == '방학양산' )        then    Busx5(user_id)  --- 
         elseif ( cmd == '방학진해' )        then    Busx6(user_id)  --- 
         elseif ( cmd == '방학장유' )        then    Busx7(user_id)  --- 
         elseif ( cmd == '방학동래한전' )        then    Busx8(user_id)   

            
------ 학교버스사진 ------
     elseif ( cmd == '동래1' )            then    dongnae1(user_id)  --- 
     elseif ( cmd == '동래2' )            then    dongnae2(user_id)  --- 
     elseif ( cmd == '동래3' )            then    dongnae3(user_id)  --- 
     elseif ( cmd == '동래한전1' )            then    anrak1(user_id)  --- 
     elseif ( cmd == '동래한전2' )            then    anrak2(user_id)  --- 
     elseif ( cmd == '동래한전3' )            then    anrak3(user_id)  --- 
     elseif ( cmd == '하단1' )            then    hadan1(user_id)  --- 
     elseif ( cmd == '해운대1' )            then    haeundae1(user_id)  --- 
     elseif ( cmd == '해운대2' )            then    haeundae2(user_id)  --- 
     elseif ( cmd == '해운대3' )            then    haeundae3(user_id)  --- 
     elseif ( cmd == '영부1' )            then    youngbu1(user_id)  --- 
     elseif ( cmd == '영부2' )            then    youngbu2(user_id)  --- 
     elseif ( cmd == '마산1' )            then    masan1(user_id)  --- 
     elseif ( cmd == '마산2' )            then    masan2(user_id)  --- 
     elseif ( cmd == '창원1' )            then    changwon1(user_id)  --- 
     elseif ( cmd == '창원2' )            then    changwon2(user_id)  --- 
     elseif ( cmd == '울산1' )            then    ulsan1(user_id)  --- 
     elseif ( cmd == '울산2' )            then    ulsan2(user_id)  --- 
     elseif ( cmd == '양산1' )            then    yangsan1(user_id)  --- 
     elseif ( cmd == '양산2' )            then    yangsan2(user_id)  --- 
     elseif ( cmd == '양산3' )            then    yangsan3(user_id)  --- 
     elseif ( cmd == '진해1' )            then    jinhae1(user_id)  --- 
     elseif ( cmd == '진해2' )            then    jinhae2(user_id)  --- 
     elseif ( cmd == '진해3' )            then    jinhae3(user_id)  --- 
     elseif ( cmd == '장유1' )            then    jang1(user_id)  --- 
     elseif ( cmd == '장유2' )            then    jang2(user_id)  --- 
     elseif ( cmd == '장유3' )            then    jang3(user_id)  --- 
     elseif ( cmd == '장유4' )            then    jang4(user_id)  --- 
     elseif ( cmd == '장유5' )            then    jang5(user_id)  --- 
     elseif ( cmd == '강서구청1' )            then    gang1(user_id)  --- 
     elseif ( cmd == '강서구청역1' )            then    gang1(user_id)  --- 


------ 홈페이지 연결 ------
   

     elseif ( cmd == '인제홈' )        then inje(user_id) -- 
     elseif ( cmd == '인제대' )        then inje(user_id) --
     elseif ( cmd == 'inje' )          then    inje(user_id)  --- 
     elseif ( cmd == 'injehome' )      then    inje(user_id)  --- 

     elseif ( cmd == '학교홈' )                  then    inje(user_id)  --- 
     elseif ( cmd == '학교홈페이지' )            then    inje(user_id)  --- 
     elseif ( cmd == '인제홈페이지' )            then    inje(user_id)  --- 

     elseif ( cmd == '인제정보' )                then    stud(user_id)  --- 
     elseif ( cmd == '인제정보시스템' )          then    stud(user_id)  --- 
     elseif ( cmd == 'sail' )                    then    sail(user_id)  --- 
     elseif ( cmd == 'sail시스템' )              then    sail(user_id)  --- 
     elseif ( cmd == 'bme' )                     then    bme(user_id)  --- 
     elseif ( cmd == 'BME' )                     then    bme(user_id)  --- 
     elseif ( cmd == '학과홈페이지' )            then    bme(user_id)  --- 
     elseif ( cmd == '학과홈' )                  then    bme(user_id)  ---    


------ 전화번호 연결 ------
     elseif ( cmd == '의용공학부' )            then     roomnumber1(user_id)
     elseif ( cmd == '의무실' )                then     roomnumber2(user_id)
     elseif ( cmd == '학생복지처' )            then     roomnumber3(user_id)
     elseif ( cmd == '창업교육센터' )          then     roomnumber4(user_id)
     elseif ( cmd == '취업교육센터' )          then     roomnumber5(user_id)
     elseif ( cmd == '대학청년고용센터' )      then     roomnumber6(user_id)
     elseif ( cmd == '대외교류처' )            then     roomnumber7(user_id)
  
    
    
    
    


    else                                    DefaultMessage(user_id, cmd)      -- BOT의 기본 메시지
    end

    -- 받은 메시지가 magnet 링크 형식이라면 AddMagnetLink 함수를 호출한다
    if ( string.sub(cmd, 0, 8) == "magnet:?" ) then
        AddMagnetLink(user_id, cmd)
    end

    if ( shell_flag == 1 ) then
        print("shell flag is true")
        ShellMode(user_id, cmd, arg)
    end

end









-- 메시지가 수신 되면 이 함수가 호출되어진다
function on_msg_receive (msg)
    -- msg 변수에 있는 모든 항목을 출력
    vardump(msg)

    -- 자신이 보낸 메시지라면 return
    -- 자신의 계정으로만 사용중이라면 if <--> end 부분을 주석 처리
    if msg.out then
        print("-- : ", msg.out, "\n")
        return
    end

    -- auth (지정한 폰번호만 인증)
    if auth_phone[msg.from.phone] then
        print "auth    : OK "
    else
        print "auth    : invalid user"
        return
    end

    -- 받은 메시지가 파일 또는 이미지 데이터인 경우에는 RecvFile 함수에서 처리한다.
    if msg.media then
        RecvFile(msg)
        mark_read(user_id, ok_cb, false)            -- 읽은 메시지로 표시
        return
    end


    -- 수신 받은 메시지를 띄어쓰기를 기준으로 Command 와 Argument로 나눈다.
    -- ex : search arg1 text 123 => cmd = "search", arg = "arg1 text 123"
    local cmd, arg  = split_command(msg.text)

    -- command 가 영문일 경우 모두 소문자로 변환
    cmd = string.lower(cmd)
    print("receive  : [", cmd, "]\n")
    print("argument : [", arg, "]\n")

    -- 사용자 정보를 print 한다.
    print("Name     : ", msg.from.print_name)   -- 메시지 보낸사람 real name (Jinho)
    print("Phone    : ", msg.from.phone)            -- 메시지 보낸사람 전화번호  (8210AAAABBBB)
    print("Msg Num  : ", msg.id)                    -- 메시지 번호
    print("to.Name  : ", msg.to.print_name)

    -- 메시지를 전송할 대상을 구분하기 위한 기능.
    -- msg 를 보낸 ID와 로그인한 ID가 동일하다면 BOT에서 사용자에게 보낸 메시지이므로 from을 user_id로 설정
    -- msg 를 보낸 ID와 로그인 ID가 다르다면 BOT이 메시지를 수신 받은 경우이므로 to를 user_id로 설정
    if (msg.to.id == our_id) then
        user_id = msg.from.print_name
    else
        user_id = msg.to.print_name
    end

    -- 읽은 메시지로 표시
    mark_read(user_id, ok_cb, false)

    -- 메시지를 구분하는 함수, 이곳에서 command 를 인식하여 각각 처리한다
    msg_processing(user_id, cmd, arg)

end

    -- 비밀 대화방 생성시 호출 (확인 안됨)
function on_secret_chat_created (peer)
    print "secret chat create event"
end

    -- 비밀 대화방 생성이 아래 함수 호출 됨.
function on_secret_chat_update (schat, what)
    print "secret chat update event"
end

    -- 사용자 정보 업데이트시 호출됨
function on_user_update (user)
    print "user update event"
end

    -- 채팅방 업데이트시 호출됨
function on_chat_update (user)
    print "chat update event"
end

    -- 현재 로그인 한 ID를 통지 받는 함수 (숫자 형태의 ID) 
function on_our_id(id)
    our_id = id
    print("My user# : ", id)
end

    -- 어떤 기능인지 확인 안됨
function on_get_difference_end ()
end

    -- 기존 이벤트가 종료 될때 호출, 정확한 의미 파악이 안됨.
function on_binlog_replay_end ()
    -- Telegram BOT 처음 시작시 메시지 전송., user_id는 관리자 ID로 변경해서 사용
    -- send_msg('user#12345678', 'Telegram BOT 서비스가 시작되었습니다', ok_cb, false)
end

    -- telegram cli 에서 제공하는 lua 함수를 수행하였을때 결과를 받기 위한 함수.
    -- ex: send_msg(user_id, '메시지', ok_cb, false)
function ok_cb(extra, success, result)
end




