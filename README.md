# DB_Team_phase4

# 0. 프로젝트 및 팀원 소개

---

## 1) 프로젝트

- HiAuction : **지역기반** 중고 물품 경매 서비스
    - **같은 동네**에 사는 유저들끼리 중고 물품을 **경매**를 통해 판매하고 직거래 할 수 있는 서비스

## 2) 팀원

- 김재현 - 2017113301
- 김태원 - 2017112351
- 나현준 - 2017114482

# 1. 실행환경

---

- OS : window10 x64
- IDE : IntelliJ IDEA 2021.2.3 (Ultimate Edition)
- DBMS : oracle 19c
- Web Server : Tomcat 8.5.72
- JAVA : jdk-1.8.0_311

# 2. 실행방법

## 1) Github PULL

---

1. 링크를 통하여 JSP 프로젝트를 생성합니다.([링크](https://velog.io/@ruddms936/IntelliJ%EB%A1%9C-JSP-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%83%9D%EC%84%B1))
프로젝트 이름은 DB_Team_phase4으로 합니다.
2. File - Project Structure - Libraries에 ojdbc8을 추가합니다.
3. git pull 명령어를 통해 코드를 내려받습니다.
4. db_final.dump 파일을 통해 데이터베이스를 복원합니다.
데이터베이스 유저 이름과 비밀번호는 DBTeam7/comp322로 해야합니다.
복원 명령어 - imp userid=DBTeam7/comp322 FILE="db_final.dump파일 경로"
5. 서버를 실행시킵니다.

## 2) ZIP 형식

---

1. zip 파일 해제 후 intellij로 폴더 열기
2. 최상단 DB_Team_phase4 폴더에서 우클릭 후 Add Frameworks Support
    
    ![Untitled](https://www.notion.so/taewon98/Read-Me-phase4-team7-232c292605c24ebd8803cfabe33bb99a#cb103abb2c094248b9852aef59b3ec26)
    
    - 위와 같이 설정 후 OK
3. 상단 add configuration에서

![Untitled](Read%20Me%20-%20phase4(team7)%20cb103abb2c094248b9852aef59b3ec26/Untitled%201.png)

이후 Deployment에서 Artifact 추가

![Untitled](Read%20Me%20-%20phase4(team7)%20cb103abb2c094248b9852aef59b3ec26/Untitled%202.png)
