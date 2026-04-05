<div id="page">

<div id="main" class="aui-page-panel">

<div id="main-header">

<div id="breadcrumb-section">

1.  [Programming](index.html)
2.  [Programming](Programming_98307.html)
3.  [Spring](Spring_120848385.html)
4.  [Spring Boot](Spring-Boot_223477765.html)

</div>

# <span id="title-text"> Programming : SpringBoot Test </span>

</div>

<div id="content" class="view">

<div class="page-metadata">

Created by <span class="author"> Dongwook Han</span> on 6월 23, 2023

</div>

<div id="main-content" class="wiki-content group">

- Spring-boot-starter-test 포함 Library

  - JUnit5

  - Spring Test & Spring Boot Test

  - AssertJ

  - Hamcrest

  - Mockito

  - JSONassert

  - JsonPath

- 코드를 단위 테스트하기 쉽게 만들어야 함

- New 를 사용하여 Spring을 포함하지 않고도 연산자를 사용해서 객체를 인스턴스화

- Mock 객체를 사용

- 통합테스트(ApplicatoinContext 사용)- 애플리케이션을 배포하거나 다른 인프라테 연결할 필요 없이 수행

- 통합테스트를 위한 전용 테스트 모듈이 포함됨

# Spring Test

단위 테스트에 IoC 원칙에 의해 추가된 가치와 통합 테스트에 대한 Spring 프레임워크 지원의 이점을 언급

## 단위 테스트

- 종속성 주입(DI)은 기존 J2EE/Java EE 개발에서보다 컨테이너에 대한 코드의 종속성을 줄여 주어야 함

- 애플리케이션을 구성하는 POJO는 Spring 이나 다른 컨테이너 없이 new 연산자를 사용하여 객체를 인스턴스화하여 JUnit 또는 TestNG 에서 테스트할 수 있어야 함

- Mock 객체를 사용하여 코드를 격리하여 테스트할 수 있음(Spring 이나 컨테이너 지원 없이)

- Spinrg의 아키텍처 권장 사항을 따랐다면, 코드 베이스의 깔끔한 계층화 및 구성 요소화가 더 쉬운 단위 테스트를 용이하게 함 (즉, Spring 아키텍처에 맞쳐 Layer 나누고, component 등을 구성하고 했으면 JUnit 테스트 할 때 설정 등을 쉽게 할 수 있다는 말)

- 단위 테스트를 실행하는 동안 영구 데이터에 액세스할 필요 없이 DAO 또는 리포지토리 인터페이스를 스텁하거나 mock 하여 서비스 계층 개체를 테스트 할 수 있음

- 진정한 단위 테스트를 전형적으로(일반적으로) 설정할 런타임 인프라가 없기 때문에 매우 빠르게 실행됨

- 개발 방법론의 일부로 진정한 단위 테스트를 강조하면 생산성을 높일 수 있다.

- IoC 기반 응용 프로그램에 대한 효과적인 단위 테스트를 작성하는데 도움이 되는 테스트 장의 이섹션이 필요하지 않을 수 있음. 그러나 특정 단위 테스트 시나리오의 경우 Spring Framework는 이 장에서 설명하는 모의 객체 및 테스트 지원 클래스를 제공함

## Mock 객체

### 환경

- org.springframework.mock.env 에는 환경과 PeoprtySource 추상화 Mock 구현이 포함됨(<a href="https://docs.spring.io/spring-framework/reference/core/beans/environment.html#beans-definition-profiles" class="external-link" rel="nofollow">Bean Definition Profiles</a> 와 <a href="https://docs.spring.io/spring-framework/reference/core/beans/environment.html#beans-property-source-abstraction" class="external-link" rel="nofollow">PropertySource Abstraction</a> 참조)

- MockEnvironment와 MockPropertySource는 환경별 속성에 의존하는 코드에 대한 컨테이너 외부 테스트를 개발하는데 유용 (컨테이너를 사용하지 않는 테스트? )

### JNDI

- org.springframework.mock.jndi 에는 JNDI SPI의 부분 구현이 포함, 테스트 스위트 또는 독립 실행형 애플리케이션을 위한 간단한 JNDI 환경 설정하는데 사용 가능

- 예 : JDBC DataSource 인스턴스가 Jakarata EE 컨테이너에서와 마찬가지로 테스트 코드에서 동일한 JNDI 이름에 바인딩되면 수정없이 테스트 시나리오에서 애플리케이션 코드와 구성을 모두 재사용 가능

- 패키지의 모의 JNDI 지원은 Simple JNDI(org.springframework.mock.jndi) 와 같은 타사의 완전한 솔루션을 위해 Spring Framework5.2부터 공식적으로 사용되지 않음

### 서블릿 API

- <a href="http://org.springframework.mock.web" class="external-link" rel="nofollow">org.springframework.mock.web</a> 패키지에는 web context, controller 및 filter를 테스트하는데 유용한 포괄적인 Servlet API Mock 객체 세트가 포함됨

- 이러한 Mock 객체 들은 Spring Web MVC framework에서 사용하도록 제공되어졌고 동적인 mock 객체(EasyMock) 이나 대체 Servlet API mock 객체(MockObjects) 보가 사용하고 편함

- Spring Framework 6.0 부터 Mock 객체는 Servlet 6.0 API를 기반으로 함

- Spring MVC 테스트 프레임워크는 Spring MVC용 통합 테스트 프레임워크를 제공하기 위해 모의 Serlvet API 객체를 기반으로 함. <a href="https://docs.spring.io/spring-framework/reference/testing/spring-mvc-test-framework.html" class="external-link" rel="nofollow">MockMVC</a> 참조

### Spring Web Reactive

- WebFlux 애플리케이션에서 사용하기 위한 ServerHttpRequest, ServerHttpResponse 모의 객체가 org.springframework.mock.http.server.reactive 에 포함

- org.springframework.mock.web.server 패키지는 mock request와 response 객체에 의존하는 ServerrWebExchange 를 포함

- MockServerHttpReqeust와 MockServerHttpResponse 동일한 추상 기본 클래스에서 서버별 구현으로 확장하고 동작을 공유 : 모의 Request은 일단 생성되면 변경할 수 없지만 ServetHttpRequest 의 mutate() 메소드를 사용하여 수정된 인스턴스(mock request)를 생성할 수 있음

- 모의 응답이 쓰기 계약을 올바르게 구현하고 쓰기 완료 핸들 을 반환하기 위해 (Mono\<Void\> ) 기본적으로 데이터를 버퍼링하고 테스트의 assertion 에 사용할 수 있도록 하는 cache(),.then()와 함께 Flux 사용함

- WebTestClient는 HTTP 서버없이 WebFlux 애플리케이션 테스트를 지원하기 위해 모의 요청 및 응답을 기반으로 함

- 클라이언트는 실행중인 서버에서 종단간(end-to-end) 테스트에도 사용 가능

## 단위 테스트 지원 클래스

- Spring 에서 단위 테스트 지원하는 클래스 분류

  - 일반 테스트 유틸리티

  - Spring MVC 테스트 유틸리티

### 일반 테스트 유틸리티

- org.springframework.test.util 패키지에 포함된 유틸리티는 단위 테스트나 통합 테스트에 사용됨

- AopTestUtils : AOP 관련 유틸리티 메소드 모음. 하나 이상의 Spring Proxy 뒤에 숨겨진 기본 대상 객체에 대한 참조를 얻을 수 있음.

- ReflectionTestUtils : 리플레션 기반 유틸리티 메소드 모음. 상수 값을 변경하거나 비필드를 설정하거나 public 비설정자 메소드를 호출하거나 등

  - private

- TestSocketUtils : 통합테스트 시나리오에서 사용하기 위한 localhost 의 사용가능한 TCP 포트를 찾기 위한 간단한 유틸리티 (localhost 외에 타 서버에 사용 가능하나 추천하지는 않음. 서버의 tcp 포트 검색 기능을 사용하는 걸 추천)

### Spring MVC 테스트 유틸리티

- <a href="http://org.springframework.test.web" class="external-link" rel="nofollow">org.springframework.test.web</a>에는 JUnit, TestNG 또는 Spring MVC ModelAndView개체를 다루는 단위 테스트를 위한 다른 테스트 프레임워크과 함께 사용할 수 있는 ModelAndViewAssert가 포함됨

- Spring MVC Controller 클래스를 POJO로 단위 테스트 하려면 Spring의 Servlet API mocks 에서 MockHttpServletRequest, MockHttpSession 등과 결합된 ModelAndViewAssert 사용

- Spring MVC 용 WebapplicationContext 구성과 함께 Spring MVC 및 REST 클래스의 철저한 통합 테스트를 위해 Spring MVC 테스트 프레임워크를 사용

<a href="https://docs/spring.io/spring-framework/reference/testing/integration.html" class="external-link" rel="nofollow">https://docs/spring.io/spring-framework/reference/testing/integration.html</a>

# 통합 테스트(Integration Testing)

- 애플리케이션을 서버에 배포하지 않거나, 다른 엔터프라이즈 인프라에 연결하지 않고도 일부 통합 테스트를 수행할 수 있어야 함

- 이렇게 하면 다음과 같은 것을 테스트할 수 있음

  - Spring IoC 컨테이너 Context 에 올바른 연결

  - JDBC나 ORM tool을 사용한 Data 엑세스. 부가적으로 SQL 문의 정확성, Hibernate 쿼리, JPA 엔터티 매핑도 포함

- Unit Test 보다 속도는 느리지만 어플리케이션을 배포할 필요도 , 서버에 의존할 필요도 없음

- Annotation 기반으로 test 진행

## 통합테스트의 목표

- 테스트간 Spring IoC 컨테이너 cashing을 관리

- 테스트 픽스처 인스턴스의 종속성 주입 제공

- 통합 테스트에 적합한 트랜잭션 관리 제공

- 통합 테스트를 작성하는데 도움이 되는 Spring 특정 기본 클래스 제공

### 컨텍스트 관리 및 캐싱

- Spring TestContext Framework는 Spring ApplicationContext 인스턴스와 WebApplicationContext 인스턴스의 일관된 로드와 해당 컨텍스트 캐싱 제공

- 로드된 컨텍스트의 캐싱에 대한 지원은 시작 시간이 문제가 될 수 있음 - 캐싱해야 할 대상들의 로드 시간으로 인해 테스트 실행이 느려질 수 있음

- 테스트 클래스는 일반적으로 어플리케이션을 구성하기 위해 XML에 대한 리소스 경로의 배열 또는 Groovy configuration metadata, component 클래스의 배열을 선언함 - 이러한 경로 및 클래스들은 web.xml 이나 운영 배포에 필요한 구성 파일들과 동일하다.

- 기본적으로, 로딩된고 구성된 applicationcontext는 매 테스트마다 재사용됨.

- 설정 비용은 오직 test suite 마다 한번 발생함. test suite 는 동일한 JVM에서 수행되는 모든 테스트를 의미

- 상세한 내용은 Context Management 와 Context Caching 참고

### Test Fixtures 의 종속성 주입(Dependency Injection)

- applicationcontext 로드할 때 테스트 클래스의 인스턴스에 DI를 사용하여 선택적으로 구성(테스트 시점에 DI를 사용하여 구성을 변경하거나 다른 객체로 대체할 수 있음

### Transaction 관리

- 실제 DB에 영향을 미치지 않도록 TestContext 프레임워크가 지원함

- TextContext Framework 참고

### 통합테스트를 위한 지원 클래스

- 통합 테스트를 작성을 단순화하는 여러 Abstract 지원 클래스 제공

  - ApplicatoinContext, 명시적 bean 검색 및 context의 상태를 전체적으로 테스트

  - A JdbcTemplate, 데이터베이스를 쿼리하는 SQL문을 실행하기 위해 사용.

# JDBC 테스트 지원

## JdbcTestUtils

- org.springframework.test.jdbc 에 JDBC 관련 유틸리티 기능 모음

- JdbcTestUtils 는 정적 유틸리티 메소드 제공

  - countRowsInTable(…) : 주어진 테이블의 행 수 계산

  - countRowsInTableWhere(…) : 제공된 Where 절을 사용하여 주어진 테이블의 행수 계산

  - deleteFromTables(…) : 지정된 테이블에서 모든 행 삭제

  - deleteFromTableWhere(…) ; 제공된 where 절을 사용하여 주어진 테이블에서 행 삭제

  - dropTables(..): 지정된 테이블 삭제

## 임베디드 데이터 베이스

- spring-jdbc 모듈은 통합 테스트에서 사용할 수 있는 데이터 베이스 구성 및 시작에 대한 지원 제공

- Embedded Database Support 및 Testing Data Access Logic With an Embedded Database 참조

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
