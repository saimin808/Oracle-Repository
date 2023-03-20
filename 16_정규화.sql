-- 16_정규화.sql

/*
    # 정규화 (Normalization)
    
        - 필요한 데이터들을 데이터베이스에 적합한 구조로 변환하는 과정
        - 정규화가 되지 않은 데이터들은 이상현상을 일으킨다.
    
    # 제1정규형 (1NF)
    
        - 각 컬럼은 하나의 값만 가져야 한다.
        - 하나의 컬럼 데이터들은 같은 타입을 가져야 한다 (도메인 무결성)
        - 각 컬럼을 유일하게 구분할 수 있어야 한다.
        - 컬럼의 순서가 상관없어야 한다.
    
    # 1NF를 만족시키지 못한 형태    
    
        커피 테이블
    
        커피이름    / 커피가격 / 커피크키 / 커피온도
        --------------------------------------
        아메리카노      8000       T, G, V       H, I
        
    # 1NF를 만족시킨 상태 ver1
    
        커피 정보 테이블
        --------------------
        아메리카노       8000
        카페라떼          7000
        
        커피별 컵 사이즈 테이블
        ---------------------
        아메리카노       Tall
        아메리카노       Grande
        아메리카노       Venti
        카페라떼          Tall
        카페라떼          Venti
        
        커피별 가능 온도 테이블
        ----------------------
        아메리카노       Hot
        아메리카노       Ice
        
    # 1NF를 만족시킨 상태 ver2
    
        커피이름    / 커피가격  /   Tall    /   Grande  /   Venti   /   Hot     /   Ice
        ----------------------------------------------------------------
        아메리카노       8000          O             O             O           O           O
        카페라떼          7000          O             X             O           X            X
        
    # 제2정규형 이후의 정규형들은 궁금하다면 구글링 ㄱㄱ
        (보통은 직관적으로 해결 됩니다)
        
    # 1 : N 관계 해결 방법
    
        - 각 개체들이 1 : N 관계인 경우 외래키를 통한 관계 설정을 해주면 된다.
        - 1 : N 관계는 관계형 데이터베이스에서는 아주 바람직한 관계라고 할 수 있다.
    
    # N : N 관계 해결 방법
    
        1. N : N 관계의 개체 사이에 테이블을 하나 추가해 두 개의 1 : N 관계로 만들 수 있다.
        
            - 물리적 저장 공간을 절약할 수 있다. (데이터 중복을 최소화)
            - 조회 시 조인이 많이 발생하기 때문에 조회가 느려질 우려가 있다.
        
            피자                  토핑
            페퍼로니 피자     치즈
            슈퍼 슈프림        페퍼로니
                                     파인애플
                                     올리브
                                     피망
                                     양파
                                     
            피자 테이블
            
            피자 이름           /   가격  /   칼로리 /   토핑ID(FK)
            ---------------------------------------------
            슈퍼슈프림            22000      2200        치즈
            슈퍼슈프림            22000      2200        페퍼로니
            슈퍼슈프림            22000      2200        피망
            
            
            토핑 테이블
            
            토핑 이름   /   구분  /  영양성분 /  단가   /   사용되는 피자ID(FK)
            --------------------------------------------
            치즈            유제품       좋음          좋음      슈퍼슈프림
            치즈            유제품       좋음          좋음      하와이안
            치즈            유제품       좋음          좋음      콤비네이션
            치즈            유제품       좋음          좋음      페퍼로니
            페퍼로니
            피망
            ※ 기본적으로 N : N 관계의 테이블을 만들면 불필요한 행들이 많이 만들어 진다.
            
            
            ***해결책*** (N : N 관계의 테이블들 사이에 테이블을 추가해준다)
            
            피자                  레시피                             토핑
            페퍼로니 피자    페퍼로니 피자 / 치즈         치즈
            슈퍼 슈프림       페퍼로니 피자 / 치즈         페퍼로니
                                                                           파인애플
                                                                           올리브
                                                                           피망
                                                                           양파
                                                                           
            피자 테이블
            
            피자 이름           /   가격  /   칼로리 /   토핑ID(FK)
            ---------------------------------------------
            슈퍼슈프림            22000      2200        치즈
            슈퍼슈프림            22000      2200        페퍼로니
            슈퍼슈프림            22000      2200        피망
            
            조합 테이블
            조합ID (PK)               /   피자ID(FK)        /   토핑ID(FK)
            ----------------------------------------------
            페퍼로니 치즈 피자      페치피자                페퍼로니_치즈
            콤비네이션 피자          콤비피자                페퍼로니_올리브_피망...
            
        2. 두 개의 테이블을 하나로 합친다 (빅데이터 스타일 no-SQL)
        
            - 물리적 저장 공간을 낭비하게 된다 (중복 데이터가 늘어난다)
            - 대신 조회 속도가 매우 빠르다.
            
            피자 이름   /   가격  /   칼로리 /   토핑ID    /   조합ID    /   피자ID   / 토핑ID_피자
*/

/*
    ※ 다대다 관계의 두 엔티티를 생각해보고 1번 방식으로 테이블을 설계하여 생성해보세요
          
                                                          
          
          겨울 의류                                                         고객
           
          후아유 푸퍼패딩                                                고객1
          디스커버리 양털자켓                                          고객2
          유니클로 히트텍                                                고객3
          탑텐 기모 맨투맨                                               고객4
          젝시믹스 기모 레깅스                                         고객5
                                                                                  고객6
                                                                                  고객7
                                                                          
        겨울의류 구매 내역
        
        구매 번호 (PK) /  상품명(FK)  /   구매자(FK)   /    가격     /   .....
        ---------------------------------------------------------------------
        0001               /    유니클로 히트텍  /   고객3     /   12000 /   ....
        0002               /    디스커버리 양털자켓  /   고객5 /   120000  /   ...
        0003               /    디스커버리 숏패딩   /   고객1 /   200000  /   ...
          
*/
DROP TABLE clothing;
CREATE TABLE clothing (
    product_code    VARCHAR2(20),
        CONSTRAINT cloth_pc_pk PRIMARY KEY (product_code),
    product_name    VARCHAR2(30),
    price                  NUMBER(10),
    product_type     VARCHAR2(15),
    product_season CHAR(4),
        CONSTRAINT cloth_ps_chk CHECK (upper(product_season) IN ('SG','SR','AN','WR'))
);
ALTER TABLE clothing MODIFY(
    product_code VARCHAR2(20),
    product_name  VARCHAR2(50)
);

INSERT INTO clothing VALUES ('WRU_PP_WR', '후아유 푸퍼패딩', 80000, 'padding','WR');
INSERT INTO clothing VALUES ('DIS_GDP_WR', '디스커버리 구스다운패딩', 300000, 'padding','WR');
INSERT INTO clothing VALUES('TT_TS_SR', '탑텐 오가닉 티셔츠', 9000, 'T-Shirt', 'SR');
INSERT INTO clothing VALUES('GODN_LS_NONE','지오다노 긴팔셔츠', 25000, 'Shirt', null);

DROP TABLE customer;
CREATE TABLE customer (
    customer_code    NUMBER(4),
        CONSTRAINT custom_cd_pk PRIMARY KEY (customer_code),
    name    VARCHAR2(20),
    age       NUMBER(2),
    gender  VARCHAR2(6),
        CONSTRAINT custom_gdr_chk CHECK (lower(gender) IN ('male','female')), 
    purchased_date   DATE,
    purchased_product_code VARCHAR2(20)
);
ALTER TABLE customer ADD CONSTRAINT custom_ppc_fk FOREIGN KEY (purchased_product_code)
    REFERENCES clothing(product_code);
DESC customer;
INSERT INTO customer VALUES(1, 'Kim', 23, 'female', '2021-07-05', 'GODN_LS_NONE');
INSERT INTO customer VALUES(2, 'Tyler', 30 , 'male', '2021-08-09', 'WRU_PP_WR');
INSERT INTO customer VALUES(3, 'Jack', 42, 'male', '2021-05-23', 'TT_TS_SR');
INSERT INTO customer VALUES(4, 'Yang',56, 'male', '2021-11-30', 'DIS_GDP_WR');
SELECT * FROM customer;
SELECT * FROM clothing;

SELECT
    *
FROM
    clothing cloth INNER JOIN customer custom
ON
    cloth.product_code = custom.purchased_product_code;

