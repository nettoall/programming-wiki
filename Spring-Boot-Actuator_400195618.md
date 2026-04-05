<div id="page">

<div id="main" class="aui-page-panel">

<div id="main-header">

<div id="breadcrumb-section">

1.  [Programming](README.md)
2.  [Programming](Programming_98307.md)
3.  [Spring](Spring_120848385.md)
4.  [Spring Boot](Spring-Boot_223477765.md)

</div>

# <span id="title-text"> Programming : Spring Boot Actuator </span>

</div>

<div id="content" class="view">

<div class="page-metadata">

Created by <span class="author"> Dongwook Han</span> on 6월 23, 2023

</div>

<div id="main-content" class="wiki-content group">

# 정의

- Spring Boot Application 을 Production(운영이라 하자)으로 넘길 때 이를 모니터링하고 관리하기 좋은 몇가지 추가 기능 제공

- HTTP end point 나 JMX 중 하나를 선택해서 Application을 관리하고 모니터링 제공

- Auditing, health check, 메트릭 수집도 자동으로 적용됨

# Production-ready Features

- Spring Boot의 Production-ready features 는 전부 Spring-boot-actuator 모듈에 포함됨

- Spring-boot-starter-actuator 를 추가하여 활성화하는게 좋음

- Actuator : 무언가를 움직이거나 제어하기 위한 기계적인 장치를 지칭

- Maven

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  <dependencies>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-actuator</artifactId>
    </dependency>
  </dependencies>
  ```

  </div>

  </div>

- Gradle

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-actuator'
  }
  ```

  </div>

  </div>

# Endpoints

- 끝점, 서로 이어지는 종점

- Actuator endpoint를 사용하면 쉽게 애플리케이션을 모니터링하고 상호 작용 가능(Spring Boot Actuator 기능을 활성화하면 endpoint로 자동으로 서비스가 되는건가?)

- Spring Boot는 여러가지 endpoint를 내장, 자체 endpoint 추가도 가능

- 각 endpoint는 개별적으로 활성화/비활성화 가능

- HTTP나 JMX를 통해 노출

- 일반적으로 HTTP를 통한 노출 선택. endpoint id에 /actuator를 prefix로 달아서 URL에 매핑

  - ex) /actuator/health : health endpoing

- 지원하는 endpoints

<div class="table-wrap">

<table class="confluenceTable" data-layout="default" data-local-id="44aa364d-cda2-4474-b848-265bcbd20915">
<tbody>
<tr>
<th class="confluenceTh"><p><strong>ID</strong></p></th>
<th class="confluenceTh"><p><strong>Description</strong></p></th>
</tr>
&#10;<tr>
<td class="confluenceTd"><p>auditevents</p></td>
<td class="confluenceTd"><p>현재 application 에 대한 감사(audit) 이벤트들의 정보 노출</p>
<p>AuditEventRepository bean이 있어야 함</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>beans</p></td>
<td class="confluenceTd"><p>application에 있는 전체 Spring bean 표시</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>caches</p></td>
<td class="confluenceTd"><p>사용가능한 cache 노출</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>conditions</p></td>
<td class="confluenceTd"><p>설정과 자동 설정 클래스에서 평가한 조건들과 함께, 그 조건이 매칭되거나 매칭되지 않은 이유를 노출</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>configprops</p></td>
<td class="confluenceTd"><p>모든 @ConfigurationProperteis 에 있는 정보들을 표시</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>env</p></td>
<td class="confluenceTd"><p>Spring의 ConfigurableEnvironment에 있는 property를 표시</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>flyway</p></td>
<td class="confluenceTd"><p>적용시킨 모든 Flyway 데이터베이스 마이그레이션들을 표시. Flyway Bean이 하나 이상 필요</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>health</p></td>
<td class="confluenceTd"><p>application 상태 정보 표시</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>httptrace</p></td>
<td class="confluenceTd"><p>HTTP trace 정보 표시(기본적으로 HTTP request-response exchange를 마지막 100개까지 표시). HttpTraceRepository Bean이 필요</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>info</p></td>
<td class="confluenceTd"><p>application 정보를 보여주며 application 정보는 임의로 추가</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>integrationgraph</p></td>
<td class="confluenceTd"><p>Spring Integration graph를 표시. Spring-integration-core dependency가 필요</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>loggers</p></td>
<td class="confluenceTd"><p>application logger 설정을 조회하고 변경</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>liquibase</p></td>
<td class="confluenceTd"><p>적용시킨 모든 Liquibase 데이터베이스 마이그레이션을 표시 Liquibase Bean이 하나 이상 필요</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>metrics</p></td>
<td class="confluenceTd"><p>현재 application 의 metric 정보 표시</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>mappings</p></td>
<td class="confluenceTd"><p>모든 @RequestMapping path 정보 표시</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>quartz</p></td>
<td class="confluenceTd"><p>Quartz 스케줄러 Job 들에 대한 정보 표시</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>scheduledtasks</p></td>
<td class="confluenceTd"><p>application에 스케줄링된 task 표시</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>sessions</p></td>
<td class="confluenceTd"><p>Spring session 기반 세션 저장소에서 사용자 세션을 검색하고 삭제 가능. Spring Session을 사용하는 Servlet Web Application 이 필요</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>shutdown</p></td>
<td class="confluenceTd"><p>application을 gracefule하게 종료. 기본적으로 비활성화됨</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>startup</p></td>
<td class="confluenceTd"><p>ApplicationStartup으로 수집한 startup 단계 데이터를 표시. SpringApplicatin에 BufferApplicationStartup를 설정 필요</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>threaddump</p></td>
<td class="confluenceTd"><p>thread dump를 수행</p></td>
</tr>
</tbody>
</table>

</div>

- Web Application(Spring MVC, Spring Webflux, Jersey) 에서 이용가능한 Endpoints

<div class="table-wrap">

|  |  |
|----|----|
| **ID** | **Description** |
| heapdump | hprof 힙 덤프 파일 반환. HotSpot JVM 필요 |
| jolokia | HTTP를 통해 JMX 빈을 노출(클래스 패스에 Jolokia 가 있을 때 Webflux에선 사용할 수 없음) jolokia-core dependency 필요 |
| logfile | 로그 파일에 있는 내용들을 반환(<a href="http://loggin.file.name" class="external-link" rel="nofollow">loggin.file.name</a> 이나 logging.file.path 프로퍼티 설정시만) HTTP Range 헤더를 사용해서 로그 파일에 있는 내용 일분만 조회할 수도 있음 |
| prometheus | 메트릭을 프로메테우스 서버에서 스크랩할 수 있는 포맷으로 노출. micrometer-registry-prometheus dependecy 필요 |

</div>

## Endpoints 활성화

- 기본적으로 shutdown을 제외한 모든 endpoint 활성화

- 활성화할 endpoint를 설정하려면 management.endpoint.\<id\>.enabled 프로퍼티 사용

- 활성화 예제(properties)

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  management.endpoint.shutdown.enabled=true
  ```

  </div>

  </div>

- 옵트인 방식(각 endpoint 마다 수락을 하여) 활성화시 management.endpoins-enabeld-by-default 를 false 로 설정하고 개별 endpoint 의 enabled 프로퍼티를 통해 활성화 처리

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  management.endpoints.enabled-by-default=false
  management.endpoint.info.enabled=true
  ```

  </div>

  </div>

## Endpoints 노출

- endpoint에 민감한 정보가 있을 수 있기에 언제 노출시킬지 신중해야 함

- 각 endpoint 별로 기본 노출 정책을 정리한 테이블

<div class="table-wrap">

|                  |         |         |
|------------------|---------|---------|
| **ID**           | **JMX** | **Web** |
| auditevents      | Yes     | No      |
| beans            | Yes     | No      |
| caches           | Yes     | No      |
| conditions       | Yes     | No      |
| configprops      | Yes     | No      |
| env              | Yes     | No      |
| flyway           | Yes     | No      |
| health           | Yes     | Yes     |
| httptrace        | Yes     | No      |
| info             | Yes     | No      |
| integrationgraph | Yes     | No      |
| loggers          | Yes     | No      |
| liquibase        | Yes     | No      |
| metrics          | Yes     | No      |
| mappings         | Yes     | No      |
| quartz           | Yes     | No      |
| scheduledtasks   | Yes     | No      |
| sessions         | Yes     | No      |
| shutdown         | Yes     | No      |
| startup          | Yes     | No      |
| threaddump       | Yes     | No      |
| heapdump         | N/A     | No      |
| jolokia          | N/A     | No      |
| logfile          | N/A     | No      |
| prometheus       | N/A     | No      |

</div>

- 노출할 Endpoint를 변경하려면 properties 에 include, exclude 사용하려 설정

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  management.endpoints.jmx.exposure.exclude=
  management.endpoints.jmx.exposure.include = health, info
  management.endpoints.web.exposure.exclude=env.beans
  management.endpoints.web.exposure.include=*
  ```

  </div>

  </div>

- exclude가 include 보다 우선순위가 높음

## Securing HTTP Endpoints

- Spring Security가 있을 때 기본적으로 Spring Security의 Content-negotiation 전략을 통해 endpoing 보호

- HTTP endpoint 보안 설정을 커스텀하려면 RequestMatcher 객체를 사용하여 설정

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Configuration(proxyBeanMethods = false)
  public class MySecurityConfiguration {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
      http.requestMatcher(EndpointRequest.toAnyEndpoint())
          .authorizeRequests((requests) -> 
              requests.anyRequest().hasRole("ENDPOINT_ADMIN"));
      http.httpBasic();
      return http.buile();
    }
  }
  ```

  </div>

  </div>

  - EndpoingRequest.toAnyEndpoint() 를 사용해 모든 endpoint 에 대한 요청을 매칭하고 ENDPOINT_ADMIN 권한이 있는지 확인

  - EndpointRequest에 있는 다른 matcher 메소드들도 활용하여 설정 가능

- endpoint에 인증없이 접근하도록 커스텀 시큐리티 설정 예제

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Configuration(proxyBeanMethods = false)
  public class MySecurityConfiguration {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
      http.requestMatcher(EndpointRequest.toAnyEndpoint())
          .authorizeRequests((requests) -> 
              requests.anyRequest().permitAll());
      return http.buile();
    }
  }
  ```

  </div>

  </div>

## Endpoints 구성

- endpoint 에선 파라미터를 받지 않는 읽기 작업에 대한 응답을 자동으로 캐시함

- endpoint가 응답을 캐시하고 있을 시간을 설정하려면 cache.time-to-live 프로퍼티 사용

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  management.endpoint.beans.cache.time-to-live=10s
  ```

  </div>

  </div>

## Hypermedia for Actuator Web Endpoints

- 모든 endpoints의 링크를 가진 'discovery page” 추가됨

- discoverty page 비활성화 설정

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  management.endpoint.web.discoverty.enabled=false
  ```

  </div>

  </div>

- 커스텀 management context path를 설정하면 discovery page는 자동으로 /actuator 에서 management context root 로 이동.

## CORS 지원

- Cross-Origin resource sharing은 W3C 사양 중 하나로 어떤 종류의 cross-domain 요청을 승인할지를 유연하게 지정

- Spring MVC나 Spring Webflux 사용시 Actuator의 Web Endpoint 에서도 이런 시나리오 지원하도록 설정

- CORS 지원은 기본적으로 비활성화

- 예제 설정 ( <a href="http://example.com" class="external-link" rel="nofollow">example.com</a> 도메인에서 GET, POST 호출 허용)

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  management.endpoint.web.cors.allowed-origins=https;//example.com
  management.endpoint.web.cors.allowed-methods=GET,POST
  ```

  </div>

  </div>

## 커스텀 Endpoints 구현하기

- @Endpoint annotation을 선언한 @Bean 을 추가하면 @ReadOperaion 이나 @WriteOperation, @DeleteOperation annotation이 달린 메소드들은 모두 자동으로 JMX 를 통해 노출되며, Web Applicatoin 에서 HTTP를 통해서도 노출됨

- HTTP를 통한 Endpoint 노출은 Jersey, Spring MVC, Spring Webflux를 통해 가능

- 예제 코드

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @ReadOperation
  public CustomData getData(){
    return new CustomData("test", 5);
  }
  ```

  </div>

  </div>

- @JmxEndpoint 나 @WebEndpoint 를 사용해서 기술 전용 endpoint 작성

- @EndpointWebExtension, @EndpointJmxExtension 을 사용하면 기술 전용 extension 작성 가능

- Web Framework 전용 기능에 접근시 @Controller, @RestController Endpoint 구현 가능

### 입력 받기

- Endpoint operation은 파라미터를 통해 입력 받음

- Web 으로 노출시 URL의 쿼리 파라미터와 JSON Request Body 에서 가져옴

- JMX로 노출시 MBean operation의 파라미터에 매핑

- 기본적으로 파라미터는 필수

- @javax.annotation.Nullable, @org.springframework.lang.Nullable annotation을 사용하여 파라미터 생략 가능

- 예제

  - json request body

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    {
      "name":"test",
      "counter": 42
    }
    ```

    </div>

    </div>

  - Endpoint 정의

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    @WriteOperation
    public void updateData(Sring name, int counter) {
      // injects "test" and 42
    }
    ```

    </div>

    </div>

#### 입력 타입 변환

- Endpoint operation 메소드에 전달된 파라미터는 자동으로 타입 변환

- JMX나 HTTP 요청을 통해 받은 입력은 operation 메소드를 호출하기 전에 @EndpointConverter 로 지정한 converter 나 GenericConverter bean과 ApplicationConversionService 인스턴스를 사용해서 필요한 타입으로 변환

## 커스텀 Web Endpoints

- @Endpoint, @WebEndpoint, @EndpointWebExtension 에 있는 작업을 자동으로 Jersey나 Spring MVC, Spring Webflux를 사용해서 HTTP로 노출됨

### Web Endpoint Request Predicates

- 웹으로 노출한 endpoint에 있는 모든 작업에는 request predicate가 자동으로 생성

### Path

- predicate path는 endpoint id와 web 에 노출한 endpoint의 base path 로 결정

- default base path 는 /actuator , id가 sessions 인 endpoint에선 /actuator/sessions 를 predicate path 로 사용

- Operation method 에 있는 파라미터 하나 이상에 @Selector 를 선언하면 path를 좀더 커스텀 가능

- 이런 파라미터는 path predicate에 path 변수로 추가됨

- 변수 값을 endpoint 작업을 호출 할 때 operation 메소드에 전달됨

- 나머지 path 요소를 모두 잡아내려면 마지막 파라미터에 @Selector(match=ALL_REMAINING) 을 추가하고 String\[\] 으로 변환할 수 있는 타입으로 만들면 됨

### HTTP method

- predicate의 HTTP 메소드는 Operation 타입에 따라 결정

<div class="table-wrap">

|                  |                 |
|------------------|-----------------|
| **Operation**    | **HTTP method** |
| @ReadOperation   | GET             |
| @WriteOperation  | POST            |
| @DeleteOperation | DELETE          |

</div>

</div>

</div>

</div>

<div id="footer" role="contentinfo">

<div class="section footer-body">

Document generated by Confluence on 4월 05, 2026 17:57



</div>

</div>

</div>
