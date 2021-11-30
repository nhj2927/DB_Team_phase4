# DB_Team_phase4

## 0. 프로젝트 및 팀원 소개

### 1) 프로젝트

- HiAuction : **지역기반** 중고 물품 경매 서비스
    - **같은 동네**에 사는 유저들끼리 중고 물품을 **경매**를 통해 판매하고 직거래 할 수 있는 서비스

### 2) 팀원

- 김재현 - 2017113301
- 김태원 - 2017112351
- 나현준 - 2017114482

## 1. 실행환경


- OS : window10 x64
- IDE : IntelliJ IDEA 2021.2.3 (Ultimate Edition)
- DBMS : oracle 19c
- Web Server : Tomcat 8.5.72
- JAVA : jdk-1.8.0_311

## 2. 실행방법

### 1) Github PULL
- github에서 pull한 경우
1. 링크를 통하여 JSP 프로젝트를 생성합니다.([링크](https://velog.io/@ruddms936/IntelliJ%EB%A1%9C-JSP-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%83%9D%EC%84%B1))
    
    프로젝트 이름은 DB_Team_phase4으로 합니다.
    
2. File - Project Structure - Libraries에 ojdbc8과 tomcat lib에 있는 모든 jar파일들을 추가합니다.
3. index.jsp 파일을 지웁니다.
4. git pull 명령어를 통해 코드를 내려받습니다.git pull 오류시 git pull origin 브런치명 --allow-unrelated-histories를 실행합니다
5. db_final.dump 파일을 통해 데이터베이스를 복원합니다.데이터베이스 유저 이름과 비밀번호는 DBTeam7/comp322로 해야합니다. 
    
    복원 명령어 - imp userid=DBTeam7/comp322 FILE="db_final.dump파일 경로"
    
6. 서버를 실행시킵니다.

### 2) ZIP 형식
- 따로 제출한 zip 파일의 압출을 풀어 실행할 경우
1. zip 파일 해제 후 intellij로 폴더 엽니다
2. 우측 하단에 아래와 같이 뜨면 configure 누릅니다
    
    ![Untitled](https://user-images.githubusercontent.com/33050476/144116782-c8d494f6-40b0-46b3-aad8-04f18401313f.png)
    
    - 아래와 같이 한 후 OK를 누릅니다
        
        ![Untitled 1](https://user-images.githubusercontent.com/33050476/144116210-10ce8c5e-183f-4c5f-ae13-4f1803f98633.png)
        
3. JDK 설정
    
    file - project structure - project에서 SDK를 1.8로 language level을 8로 설정
    
    ![Untitled 2](https://user-images.githubusercontent.com/33050476/144116227-5aa14baf-4292-48a0-a809-3cb0cb940276.png)
    
        
4. File-Project Structure-Artifact에서 Web Application: Exploed 누르고 From Modules을 클릭합니다
    
    ![Untitled 3](https://user-images.githubusercontent.com/33050476/144116246-7999ce90-8a96-4fc6-8f20-39a7c791887d.png)
    
    - 아래와 같이 뜨면 OK를 누릅니다
        
        ![Untitled 4](https://user-images.githubusercontent.com/33050476/144116274-fb8d5cf5-f5c6-4cd8-93f9-689f8162bdcb.png)
        
    - 확인 후 OK를 누릅니다
        
        ![Untitled 5](https://user-images.githubusercontent.com/33050476/144116420-3d9343db-3a0b-4cd3-8579-7dcbdd5dffdb.png)
        
    
5. 상단 add configuration에서 Add new → Tomcat Server Local을 추가합니다
    
    ![Untitled 6](https://user-images.githubusercontent.com/33050476/144116547-fd21f537-b49d-49c7-932e-dcf3634db77c.png)
    
    - Deployment 탭으로 이동하여 Artifact를 누릅니다
        
        ![Untitled 7](https://user-images.githubusercontent.com/33050476/144116592-7afde4b4-01c5-4f70-8a1b-0e8a35cbffb8.png)
        
    - 아래와 같이 뜨면 Server 탭으로 갑니다
        
        ![Untitled 8](https://user-images.githubusercontent.com/33050476/144116622-22a98905-89d4-424f-8dd9-50f5a6cf855b.png)
        
    - Server 탭의 정보가 아래와 같이 올바른지 확인 후 OK를 누릅니다
        
        ![Untitled 9](https://user-images.githubusercontent.com/33050476/144116654-63007c5c-ba63-474f-82c6-acf85e2e5b63.png)
        
    - 실행시키면 아래와 같이 확인가능합니다
        
        ![Untitled 10](https://user-images.githubusercontent.com/33050476/144116713-0baf8f47-ea27-4f49-a35a-29e56295d10d.png)
        

# 4. DEMO 영상

---

[https://youtu.be/VgkZnqWeVsQ](https://youtu.be/VgkZnqWeVsQ)
