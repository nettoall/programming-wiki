<div id="page">

<div id="main" class="aui-page-panel">

<div id="main-header">

<div id="breadcrumb-section">

1.  [Programming](index.html)
2.  [Programming](Programming_98307.html)
3.  [Spring](Spring_120848385.html)
4.  [Spring Boot](Spring-Boot_223477765.html)

</div>

# <span id="title-text"> Programming : Spring Boot Profiles </span>

</div>

<div id="content" class="view">

<div class="page-metadata">

Created by <span class="author"> Dongwook Han</span> on 3월 30, 2023

</div>

<div id="main-content" class="wiki-content group">

# 정의

- 프로젝트를 진행할 때 동일한 프로젝트에 인프라 및 개발 등을 이유로 여러 환경을 유지해야하는 경우가 있음

- 이 때 환경적인 요소로 DB 접속 정보나 메시징 서버 정보 등 환경마다 다른 경우가 있기 때문에 각 환경마다 설정을 달리 해야 함.

- Spring Boot Profiles은 이런 환경별 속성을 달리 설정할 수 있게 지원하는 기능

- Spring Framework는 최소한의 노력으로 환경을 전환하기 위해 각 환경에 대해 별도의 profile을 유지할 수 있게 해줌

- 프로그래밍 방식으로 profiles은 application.properties 파일과 유사한 ‘.properties' 확장자를 가진 속성 파일

- Spring Boot 에서는 profile에 ‘.properties’ 외에 ‘.yml’ 확장자를 가질 수 있음

# 프로필의 용도

- 프로필은 Spring 기반 애플리케이션에서 구성 속성과 beans를 제어

  1.  구성 속성 : 어떤 구성 속성을 활성화되어야 하는지 제어

  2.  Beans : 어떤 bean이 Spring Container 에 로드 되어야 하는지 제어. 조건에 다라 Bean,을 등록하는 조항도 제공

# 기본 Profile 이란

- Spring Boot는 기본적으로 ‘application.properties’ 속성 파일 제공 : 기본 profile

- application.yml 파일도 기본 profile. application.properties가 같은 위치에 있을 경우, properties 파일이 우선권을 가짐

- Spring Boot는 기본 프로필에서 모든 속성을 로드

- 기본 프로필외에 환경별로 프로필을 정의할 수 있음 → 해당 환경이 아닌 경우 환경 프로필에서 로드 안 됨

- 모든 환경에서 공통되는 기본 프로필은 유지해야 함.

# Spring Profile 생성 방법

- 각 환경에 대해 별도의 전용 파일 생성

- 또한 기본 프로필에서 단일 항목만 변경하여 필요한 프로필을 활성화 시킬 수 있음

- 예제(환경을 개발,테스트,운영 으로 구분시)

  - Spring Boot 는 기본적으로 ‘application.properties’ 속성 파일을 제공

  - ‘application.properties’ 파일과 동일한 위치에 환경별도 속성 파일 추가

  - application-dev.properties, application-test.properties, application-prod.properties

  - 이름 패턴은 application-\<environment\>.properties

  - 환경별 속성 파일에 일부 구성 속성을 정의 → 파일마다 다른 데이터베이스 구성을 정의

  - applicatoin-dev.properties

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    app.info=This is the DEV Environment Property file
    spring.h2.console.enabled=true
    spring.h2.console.path=/h2
    spring.datasource.driver-class-name=org.h2.Driver
    spring.datasource.url=jdbc:h2:mem:db
    spring.datasource.userName=sa
    spring.datasource.password=sa
    ```

    </div>

    </div>

  - applicatoin-test.properties

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    app.info=This is the TEST Environment Property file
    spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
    spring.datasource.url=jdbc:mysql://localhost:3306/mytestDB
    spring.datasource.userName=root
    spring.datasource.password=root123
    spring.jpa.hibernate.ddl-auto=update
    spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL5Dialect
    ```

    </div>

    </div>

  - application-prod.properties

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    app.info=This is the PROD Environment Property file
    spring.datasource.driver-class-name=oracle.jdbc.OracleDriver
    spring.datasource.url=jdbc:oracle:thin:@localhost:1521:xe
    spring.datasource.userName=username
    spring.datasource.password=password
    spring.jpa.hibernate.ddl-auto=update
    spring.jpa.show-sql=true
    spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.Oracle10gDialect
    ```

    </div>

    </div>

# 특정 Profile 활성화 시키기

특정 Profile을 활성화하기 위해 여러가지 방법이 있는데 그 방법들에 대해선 다음과 같다.

1.  application.properties 파일에 ‘spring.profile.active’ 설정

    - 활성화할 프로필을 지정하여 정의

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      spring.applicatoin.name = Spring Profiles
      spring.profiles.active = dev
      app.info = This is the Primary Application Property file
      ```

      </div>

      </div>

2.  JVM System Parameter 에 설정

    - JVM 시스템 매개변수에 프로필 이름을 전달

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      -Dspring.profiles.active=dev
      ```

      </div>

      </div>

3.  web.xml의 context parameter 설정

    - web.xml 의 context 매개변수를 지정하여 Spring 활성 프로필을 설정

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      <context-param>
        <param-name>spring.profiles.active</param-name>
        <param-value>dev</param-value>
      </context-param>
      ```

      </div>

      </div>

4.  WebApplicationInitializer interface 구현하여 설정

    - 웹 애플리케이션에서 WebApplicationInitializer interface를 구현하여 ServletContext를 구성하여 활성 프로필을 설정

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      @Configuratoin
      publc class MyWebApplicatoinInitializer implements WebApplicationInitializer {
        @Override
        public voiid onStartup(ServletContext servletContext) throws ServletException {
          servletContext.setInitParameter("spring.profiles.active", "dev");
        }
      }
      ```

      </div>

      </div>

5.  maven 빌드 사용시 pom.xml의 active.profiles 설정

    - pom.xml에 다음과 같이 ‘spring.profile.active’ 속성을 지정하여 Maven profile을 통해 Spring Profile을 활성화 시킴

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      <profiles>
        <profile>
          <id>dev</id>
          <activation>
            <activeByDefault>true<activeByDefault>
          </activation>
          <properties>
            <spring.profiles.active>dev</spring.profiles.active>
          </properties>
        </profile>
        <profile>
          <id>test</id>
          <properties>
            <spring.profiles.active>test</spring.profiles.active>
          </properties>
        </profile>
      </profiles>
      ```

      </div>

      </div>

# 여러 접근방식 사용에 대한 우선 순위

- profile 활성화하는 방법에 대해 여러가지 방식을 사용했다고 할 때 우선 순위는 다음과 같이 반영된다.

  1.  web.xml의 context parameter 에 설정

  2.  WebApplicationInitializer interface 구현에 의한 설정

  3.  JVM 시스템 매개변수 설정

  4.  pom.xml의 active profile 설정

# application.properties 파일에서 모든 profile을 정의하는 방법

- 하나의 파일의 모든 속성을 결합하고 구분 기화를 사용하여 프로필을 정의

- 이 방법은 Spring Boot 2.4부터 가능

- YAML 파일에서 가능했던 방법을 properties 에서 지원을 확장함

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  app.info= This is the multi-document file
  spring.config.activate.on-profile=dev
  spring.h2.console.enabled=true
  spring.h2.console.path=/h2
  spring.datasource.driver-class-name=org.h2.Driver
  spring.datasource.url=jdbc:h2:mem:db
  spring.datasource.userName=sa
  spring.datasource.password=sa

  # ---

  spring.config.activate.on-profile=test
  spring.datasource.url=jdbc:mysql://localhost:3306/myTestDB
  spring.datasource.username=root
  spring.datasource.password=root123
  spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
  spring.jpa.hibernate.ddl-auto=update
  spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL5Dialect

  # ---

  spring.config.activate.on-profile=prod 
  spring.datasource.url=jdbc:oracle:thin:@localhost:1521:xe 
  spring.datasource.username=username 
  spring.datasource.password=password 
  spring.jpa.hibernate.ddl-auto=update
  spring.jpa.show-sql=true 
  spring.datasource.driver-class-name=oracle.jdbc.OracleDriver 
  spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.Oracle10gDialect
  ```

  </div>

  </div>

# Spring Container가 다중 파일을 읽는 방법

- 파일을 위에서 아래로 읽으면서 중복된 속성이 있으면 가장 끝의 값을 고려함.

- Spring.config.activate.on-profile 항목이 prod 가 마지막 값이므로 해당 profile은 prod가 활성화 됨

- **<u>결국 활성화할 profile을 맨 마지막에 두어야 하나</u>**?

- Spring Boot 2.4부터 ‘spring.config.activate.on-profile’ 속성과 ‘spring.profiles.active’ 속성을 함께 사용할 수 없음

# @Profile 주석을 사용하는 방법

- @Profile annotation 을 사용하여 Bean이 특정 profile에 속하도록 설정

- @Profile annotatoin은 하나 이상의 프로필 이름을 설정할 수 있음

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Profile("dev")
  @Component
  public class MyBeanConfig{...}
  ```

  </div>

  </div>

- 또한 profile 이름 앞에 NOT 연산자를 붙여 프로필에서 제외가능

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Profile("!dev")
  @Component
  public class MyBeanConfig{...}
  ```

  </div>

  </div>

- XML 구성을 통해 bean을 특정 프로필에 연결할 수도 있음

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  <beans profile="dev">
    <bean id="myBeanConfig" class="com.dev.profiles.MyBeanConfig" />
  </beans>
  ```

  </div>

  </div>

- 아래와 같이 @Profile annotation을 사용해서 한번에 여러 프로필을 활성화 가능

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Configuration
  public class AppConfig {
    @Profile({"prod","dev"})
    @Bean
    public MyBean getBean(){
      return new MyBean();
    }
  }
  ```

  </div>

  </div>

# .yml을 사용하여 Profile 작업

- Spring Boot의 프로필은 YAML(.yml) 파일도 지원

- application.yml 파일에 프로필 생성

- application.yml 파일 존재시 Spring Boot 애플리케이션 시작시 로딩

- 각 환경별로 명명 규칙(application-\<environment\>.yml) 에 따라 환경별 프로필 생성 가능

- 동일한 파일에 여러 프로필 생성 가능

## 환경별 분리된 yml 파일 생성

- application.yml (공통)

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  spring:
    profiles:
      active: dev
    application:
    name: This is default profiles
  app:
    name: This is the Primary Application yml file
  ```

  </div>

  </div>

- application-dev.yml

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  spring:
    profiles: dev
    datasource:
      username: sa
      password: sa
      url: jdbc:h2:mem:db
      driver-class-name: org.h2.Driver
  ```

  </div>

  </div>

- application-test.yml

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  spring:
    profiles: test
    datasource:
      username: root
      password: root123
      url: jdbc:mysql://localhost:3306/myTestDB
      driver-class-name: com.mysql.cj.jdbc.Driver
  ```

  </div>

  </div>

- applicatoiin-prod.yml

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  spring:
    profiles: prod
    datasource:
      username: username1
      password: password@123
      url: jdbc:oracle:thin:@localhost:1521:xe
      driver-class-name: oracle.jdbc.OracleDriver
    jpa:
      hibernate:
        ddl-auto:update
      show-sql: true
      properties:
        hibernate:
          dialect: org.hibernate.dialect.Oracle10gDialect
  ```

  </div>

  </div>

## 하나의 파일에 모든 프로필 생성

- application.yml 을 만들고 그 안에 모든 프로필을 정의

- ‘spring.profiles.active’ 는 활성 프로필을 나타냄

- 세 개의 하이픈은 이 파일에서 프로필 구분 기호로 사용됨

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  spring:
    profiles:
      active: dev
  ---
  spring:
   profiles: dev
   datasource: 
     username: sa
     password: sa
     url: jdbc:h2:mem:db
     driver-class-name: org.h2.Driver
  ---
  spring: 
    profiles: test 
    datasource: 
      username: root
      password: root123
      url: jdbc:mysql://localhost:3306/myTestDB 
      driver-class-name: com.mysql.cj.jdbc.Driver
  ---
  spring: 
    profiles: prod
    datasource: 
      username: username1
      password: password@123
      url: jdbc:oracle:thin:@localhost:1521:xe
      driver-class-name: oracle.jdbc.OracleDriver
    jpa:
      hibernate:
        ddl-auto: update
      show-sql: true
      properties:
        hibernate:
          dialect: org.hibernate.dialect.Oracle10gDialect  
  ---    
  ```

  </div>

  </div>

- dev가 활성화됨

# Spring Boot 에서 프로필

- Spring Boot 2.4에 도입된 새로운 기능에 대한 설명

- Spring Boot 2.4부터 프로필과 관련하여 여러가지 변경사항 정리

  1.  특정 프로필 활성화

      - ‘spring.profiles.active’ 속성외에도 ‘spring.config.activate.on-profile’을 사용하여 특정 프로필을 설정/활성화할 수 있음

      - 두 속성을 같이 사용할 수 없음. 같이 사용시 ConfigDataException 발생

  2.  프로그래밍 방식으로 Spring Boot 에서 프로필을 활성화하려면 다음과 같이 SpringApplication 클래스를 사용

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      SpringApplication.setAdditinalProfiles("test");
      ```

      </div>

      </div>

  3.  pom.xml 을 사용하여 Spring Boot 에서 프로필을 활성하려면 ‘spring-boot-maven-plugin’에 프로필 이름 지정

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      <plugins> 
        <plugin>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-maven-plugin</artifactId> 
              <configuration> 
                 <profiles> 
                   <profile>test</profile>
                 </profiles>
              </configuration> 
        </plugin> 
        ... 
      </plugins>
      ```

      </div>

      </div>

  4.  Spring Boot 2.4에는 ‘Profile Groups’ 기능 도입

      - 유사한 프로필들을 그룹화하여 같이 활성화 가능

        <div class="code panel pdl" style="border-width: 1px;">

        <div class="codeContent panelContent pdl">

        ``` syntaxhighlighter-pre
        spring.profiles.group.production=devdb,devemail
        ```

        </div>

        </div>

      - 결과적으로 devdb와 devemail 도 활성화됨

  5.  하나의 파일에 모든 환경별 프로필을 정의하고 구분 기호를 사용하여 프로필 사용 가능

# 현재 활성화된 프로필 검사하는 방법

- 현재 활성 상태인 프로필을 확인하는 방법

## Environment Object 사용

- autowiring을 통해 Java의 환경 객체를 Bean 으로 사용

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  import org.springframework.core.env;

  public class ProfileController {
     
     @Autowired    
     private Environment env; 
     
     public void getActiveProfiles() {       
        for (String profile : env.getActiveProfiles()) { 
              System.out.println("Current active profile: " + profile);         
        }       
     } 
  }
  ```

  </div>

  </div>

## property ‘spring.profiles.active’ 주입

- 코드 예제

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  public class ProfileController { 

     @Value("${spring.profiles.active:}")
     private String activeProfiles; 

     public String getActiveProfiles() {
        for (String profile : activeProfiles.split(",")) {
           System.out.println("Current active profile: " + profile);
        } 
     } 
  }
  ```

  </div>

  </div>

</div>

</div>

</div>

<div id="footer" role="contentinfo">

<div class="section footer-body">

Document generated by Confluence on 4월 05, 2026 17:57

<div id="footer-logo">

[Atlassian](http://www.atlassian.com/)

</div>

</div>

</div>

</div>
