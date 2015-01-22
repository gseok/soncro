손크로 개발자 도움말 문서.

 - 코드 수정 및 업데이트시 본 문서을 수정한다. (버전 정보 및 수정내용 필히 작성)
 - 코드 - src/soncro.ahk
 - 리소스 - src/res/해상도/이미지들
          - src/res/favicon.ico
 - 컴파일시 소스는 src/soncro.ahk, 컴파일 결과는. cookierun 아래, icon 은 favicon.ico 사용
 - 해상도가 다른경우 동일 이름의 이미지를 찍어서 새로운 해상도 폴더를 생성하여 그 아래 넣으면 됨


 버전정보
-------------------------------------------
version 0.0.8 by 경석 

 - buy item 하는 부분 추가
 - 쿠키 정보 view 및 사용자 info view 에 대한 처리 추가.
  -- unknown button 에서 현재 view 을 모르고 좌표상으로 버튼을 눌러대기 때문에 의도하지 않은 view 가 나타나는 경우가 있음. 

-------------------------------------------
version 0.0.7 by 경석 

 - image 없는 상태에서 좌표 값으로 click 하는 commonClickNoimage 함수 추가
 - unknown button 화면에서 특정 좌표 클릭하도록 수정
 - lank change view 에 대한 처리 추가
 - life view 선물하기 처리 추가 (unknown button 누르다 잘못 누르는 경우.. 처리)
 - unknown button 코드 일부 수정 추가
 
-------------------------------------------
version 0.0.6 by 경석

 - code 정리 - commonClick 을 사용하도록 수정
 - gui 도입
   -- auto jump 기능 on/off 추가
   -- exp item 구매에 대한 on/off 추가
   -- run 시 wait 타임 설정 가능. (360 그대로 사용하는 것을 추천)
 - 주의 0.0.5-2 (영택) 에 대한 코드가 빠져있음.
 
-------------------------------------------
version 0.0.5 by 경석

 - code 정리 및 문서 작성
 - gui 도입
   -- 사용자 입력값에 따라 아이템 구매를 optional 하게 진행
   -- run view 일때 wait time 을 optional 하게 줄 수 있도록 함
   -- cmd 상에서 수행시 gui 사용하여도 log 볼 수 있음



-------------------------------------------
version 0.0.4 by 영택

 - episode1 에서 run 시 jump 랜덤 클릭 추가
 - wait time 관련 일부 시간 조정


-------------------------------------------
version 0.0.3 by 경석

 - common click 함수 추가
 - 네트워크 연결 끊김 현상시 자동으로 확인 버튼 클릭
 

-------------------------------------------
version 0.0.2 by 경석

 - wait time 관련 함수 추가
 - debug 을 위한 message 함수 추가
 - image search 을 이용한 클릭시, 랜덤 위치를 클릭하도록 함

-------------------------------------------
version 0.0.1 by 경석

 - 기본 기능 구현
 - 기본 로직 구현
   -- 현재 view 을 판단 하고, 이후 click 하는 형식
   -- 총 8 분의 wait time 을 이용하여 항상 하트 1개는 보장하는 형태
