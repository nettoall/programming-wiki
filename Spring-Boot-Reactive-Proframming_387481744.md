<div id="page">

<div id="main" class="aui-page-panel">

<div id="main-header">

<div id="breadcrumb-section">

1.  [Programming](index.html)
2.  [Programming](Programming_98307.html)
3.  [Spring](Spring_120848385.html)
4.  [Spring Boot](Spring-Boot_223477765.html)

</div>

# <span id="title-text"> Programming : Spring Boot Reactive Proframming </span>

</div>

<div id="content" class="view">

<div class="page-metadata">

Created by <span class="author"> Dongwook Han</span>, last modified on 3월 30, 2023

</div>

<div id="main-content" class="wiki-content group">

# Spring WebFlux 로 Reactive CRUD REST API 개발

## 목적

- Reactive programming Spring Boot

- Spring WebFlux with MongoDB

- Spring Boot Reactive

- Reactive REST API

- Spring Webflux CRUD

## Reactive Programming 장점

- 리소스를 최적으로 활용할 수 있음

- 일반적인 REST API 사용하는 것보다 Reactive REST API 방식이 성능이 좋음

# Reactive Programming을 왜, 언제 하는지

- Spring Boot MVC 기반 웹 애플리케이션에서 모든 request는 내부적으로 thread 처리됨

- 이 thread는 응답을 받을 때까지 데이터베이스와 통신하며 blocking mode 임

- blocking mode인 thread는 더 이상 다른 request를 할당 못함

- reacive programming은 threads를 idle mode 로 유지하는 것보다 애플리케이션 리소스 활용을 최적화함

- 이벤트 루프를 구현하여 리소스 활용도를 정확하게 만들어줌

- thread 가 데이터베이스를 호출하고 SQL 쿼리를 처리하기 위해 이벤트 루프로 넘어가면 thread는 그 동안 해제됨

- 해제된 thread는 다른 요청을 병렬적으로 처리할 수 있음

- 그 후, 동일한 thread나 다른 thread가 응답을 제공

- Spring Boot Reactive Programming의 이점을 얻으려면 서버측에서 Spring WebFlux를 사용할 수 있음

- DB 측에서는 Mongo DB와 같은 Spring Boot Reactive Database를 사용 (Relational DB는 기본적으로 block 되므로 reactive programming 과 같이 사용하기 어려움)

- 현재로서는 MongoDB 등과 같은 NoSQL DB만 지원됨

- 또한 Spring REST 대신 Spring Reactive를 권장

- Spring Webflux 로 Reactive CRUD REST API 구현

# 이 장에서 기대하는 점

- Spring WebFlux를 사용하여 REST Producer API 및 Consumer API를 구현

  1.  반응형 프로그래밍의 이점

  2.  반응형의 의미

  3.  Spring WebFlux 란

  4.  왜 Spring WebFlux 인지

  5.  Reactive Stack과 Servlet Stack 의 차이

  6.  Reactive를 지원하기 위한 최소 소프트웨어

  7.  Reactive 에서 database와 통합하는 방법

  8.  R2DBC 란

  9.  Spring WebFlux로 Reactive CRUD REST API 개발하는 방법

  10. Spring WebFlux CRUD 예제 실습

  11. WebClient를 사용하여 Reactive Client/Consumer 애플리케이션 구축

# 프로그래밍에서 Reactive 란

- non-blocking 은 blocking 대신 반응적이며 이전 작업이 완료되거나 데이터를 사용할 수 있게 되었을 때 즉시 알림에 반응하는 것을 의미

- 실제로 reactive 라는 용어는 마우스 이벤트에 반응하는 UI 컨트롤러 또는 I/O 이벤트에 반응하는 네트워크 구성 요소 등과 같이 변화에 반응하도록 구축된 프로그래밍 모델을 의미

# Spring WebFlux 란

- Spring Framework에 포함된 기본 웹 프레임워크 인 Spring Web MVC는 내부적으로 Servlet API와 Servlet container를 사용

- 유사하게 Reactive-stack web 프레임워크 지원하는 Spring WebFlux는 나중에 Spring 5.0에 추가됨

- Spring WebFlux는 Netty, Undertow 그리고 Servlet 3.1 이상 컨테이너 같은 서버에서 동작하고 완전히 non-blocking 임

- 두 프레임워크는 각각 spring-webmvc와 Spring-webflux라는 동종의 소스 모듈 이름을 가지고 있음

- 애플리케이션은 둘 중의 하나의 모듈을 사용할 수 있음

- 때로는 둘 다 사용. reactive Web Client 를 사용하는 Spring MVC Controller 같이 완벽한 조합이 되기도 함

# 왜 Spring WebFlux 을 생성하는지

- 최소 thread 수로 동시성을 처리하고 최소 하드웨어 자원으로 확장할 수 있으며 non-blocking web stack를 지원할 수 있는 프레임워크에 대한 요구가 있었음. 다른 말로 하면 reactive-stack web framework 에 대한 요구가 있었음

- 그외에도 함수형 프로그래밍을 촉진할 필요가 있었음.

- 말할 필요도 없이 Java 8의 람다 표현식은 java에서 함수형 프로그래밍에 대한 기회를 창출하였음

- 또한 프로그래밍적으로 Java 8 은 Spring WebFlux가 annotated controller 에 기능적인 web endpoing를 제공할 수 있게 하였다.

# Reactive Stack과 Servlet Stack 의 차이

<div class="table-wrap">

|  |  |
|----|----|
| **Servlet Stack** | **Reactive Stack** |
| Spring의 Web 애플리케이션 모듈은 Spring-webmvc | Spring의 Web 애플리케이션 모듈은 spring-webflux |
| Spring MVC 은 Servlet API 기반 | Spring WebFlux 는 멀티 코어, 차세대 프로세스 활용에 기반 |
| 동기식 차단 I/O 아키텍처 사용 | non-blocking framework |
| Thread model 당 하나의 요청 | 엄청난 수의 동시 연결을 처리할 수 있는 기능 |
| 기본적으로 서블릿 컨테이너 사용 | 기본적으로 Servlet 3.1+ 컨테이너 및 Netty 사용 |
| JDBC,JPA, NoSQL과 같은 Spring Data Repository 사용 | Mongo, Redis, Couchbase, R2DBC와 같은 Spring Data Reactive Repositories 사용 |
| 프로그래밍 모델은 Servlet API 사용 | 프로그래밍 모델은 Reactive Streams 어댑터 사용 |
| Spring의 Security 모듈은 Spring Security Reactive | Spring의 Security 모듈은 Spring Security |

</div>

# Reactive를 지원하기 위해 최소한의 Software

- Spring Web Flux를 지원하기 위해 Spring 5.x

- Servlet 3.1+

- 비동기식 non-blocking 공간에 잘 구축된 Netty 서버 사용(Spring Boot uses Neey Sever by default as it is well-established in the asynchronous, non-blocking space.

# Reactive 방식에서는 데이터베이스 통합이 어떻게 이루어지는 지

- 반응형 방식에서의 데이터베이스를 통한 데이터 엑세스 와 처리는 똑같이 중요

- MongoDB, Redis 그리고 Cassandra와 같은 NoSQL 데이터베이스는 모두 Spring Data의 일부로 native reactive support를 제공 (Spring-data-mongodb 같이 지원한다는 말)

- Microsoft SQL Server, MySQL, H2, Postgres 그리고 Google Spanner 와 같은 많은 관계형 데이터베이스는 R2DBC를 통해 reactivve 지원을 제공

## R2DBC 란

- R2DBC 는 Reactive Relational Database Connectiviry의 약자로 Reactive 애플리케이션 Stack 에서 관계형 데이터베이스와의 통합을 제공

- NoSQL 데이터 베이스만 Spring Data 에서 지원

- R2DBC는 reactive driver 를 사용하여 관계형 데이타베이스와 통합하는 인큐베이터 역할을 함

- Spring Data R2DBC는 인기 있는 Spring 추상화 및 R2DBC를 위한 저장소 지원을 적용

- Reactive Application Stack 에서 관계형 데이터베이스를 사용하는 Spring 기반의 애플리케이션을 쉽게 구현할 수 있는 방법을 제공

# Spring WebFlux에서 Reactive CRUD REST API 구현하기

## 프로젝트에 사용할 software

- Dependent Starter : Spring Reactive Web, Spring Data Reactive Mongo DB, Lombok, Spring Boot DevTools

- MongoDB 3.6.20 2008R2Plus SSL : mongo db 설치 <a href="https://javatechonline.com/how-to-install-mongo-db-in-your-system/" class="external-link" data-card-appearance="inline" rel="nofollow">https://javatechonline.com/how-to-install-mongo-db-in-your-system/</a> , mongoDB Tutorial <a href="https://javatechonline.com/spring-boot-mongodb-tutorial/" class="external-link" data-card-appearance="inline" rel="nofollow">https://javatechonline.com/spring-boot-mongodb-tutorial/</a>

- JDK8 or later

## 단계1. 프로젝트 생성

- Mongo DB 설치

- 개발 툴로 프로젝트 생성

## 단계2. application.properties 의 database 속성 수정

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
# application.properties
----------------------------------------
spring.data.mongodb.host=localhost
spring.data.mongodb.port=27017
spring.data.mongodb.database=reactivedb
```

</div>

</div>

## 단계3. Invoice Entity 생성 과 Repository interface 구현

- Invoice.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  // Invoice.java
  ----------------------------------------------------------------
  package com.dev.springboot.reactive.model;

  import org.springframework.data.annotation.Id;
  import org.springframework.data.mongodb.core.mapping.Document;
  import lombok.Data;

  @Data
  @Document
  public class Invoice {

      @Id
      private Integer id;
      private String name;
      private String number;
      private Double amount;
  }
  ```

  </div>

  </div>

- InvoiceRepository.java

## 단계4. Service interface 와 implementation class 구현

- InvoiceService.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.springboot.reactive.service;

  import com.dev.springboot.reactive.model.Invoice;

  import reactor.core.publisher.Flux;
  import reactor.core.publisher.Mono;

  public interface IInvoiceService {

      public Mono<Invoice> saveInvoice(Invoice invoice);
      
      public Flux<Invoice> findAllInvoices();
      
      public Mono<Invoice> getOneInvoice(Integer id);
      
      public Mono<Void> deleteInvoice(Integer id);
  }
  ```

  </div>

  </div>

- InvoiceServiceImpl.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.springboot.reactive.service;

  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.stereotype.Service;

  import com.dev.springboot.reactive.model.Invoice;
  import com.dev.springboot.reactive.repo.InvoiceRepository;

  import reactor.core.publisher.Flux;
  import reactor.core.publisher.Mono;

  @Service
  public class InvoiceServiceImpl implements IInvoiceService {

      @Autowired
      private InvoiceRepository repo;
      
      public Mono<Invoice> saveInvoice(Invoice invoice){
          return repo.save(invoice);
          //for Mono<String> return type
           //return Mono.just("saved successfully");
      }
      
      public Flux<Invoice> findAllInvoices(){
          //return repo.findAll();
          return repo.findAll().switchIfEmpty(Flux.empty());
      }
      
      public Mono<Invoice> getOneInvoice(Integer id){
          return repo.findById(id).switchIfEmpty(Mono.empty());
      }
      
      public Mono<Void> deleteInvoice(Integer id){
          return repo.deleteById(id);
      }
  }
  ```

  </div>

  </div>

## 단계5. InvoiceController class 구현

- InvoiceController.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.springboot.reactive.controller;

  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.web.bind.annotation.DeleteMapping;
  import org.springframework.web.bind.annotation.GetMapping;
  import org.springframework.web.bind.annotation.PathVariable;
  import org.springframework.web.bind.annotation.PostMapping;
  import org.springframework.web.bind.annotation.RequestBody;
  import org.springframework.web.bind.annotation.RequestMapping;
  import org.springframework.web.bind.annotation.RestController;

  import com.dev.springboot.reactive.model.Invoice;
  import com.dev.springboot.reactive.service.IInvoiceService;

  import reactor.core.publisher.Flux;
  import reactor.core.publisher.Mono;

  @RestController
  @RequestMapping("/invoice")
  public class InvoiceRestController {

      @Autowired
      private IInvoiceService service;
      
      @PostMapping("/save")
      public Mono<Invoice> saveOneInvoice(@RequestBody Invoice invoice){
          return service.saveInvoice(invoice);
                  // for Mono<String>
                  // service.saveInvoice(invoice);
                  // return Mono.just("Invoice saved" + invoice.getId());
      }
      
      @GetMapping("/allInvoices")
      public Flux<Invoice> getAllInvoices(){
          return service.findAllInvoices();
      }
      
      @GetMapping("/get/{id}")
      public Mono<Invoice> getOneInvoice(@PathVariable Integer id){
          Mono<Invoice> invoice= service.getOneInvoice(id);
          return invoice;
      }
      
      @DeleteMapping("/delete/{id}")
      public Mono<String> deleteInvoice(@PathVariable Integer id){
          service.deleteInvoice(id);
          return Mono.just("Invoice with id: " +id+ " deleted !");
      }
  }
  ```

  </div>

  </div>

# Reactive REST API 테스트

- Mongo DB 인스턴스 시작

- POSTMAN 도구를 사용하여 API 테스트

# WebClient로 Reactive Client Application 구현하는 방법

- 일반 REST Producer의 경우 Consumer를 구현하기 위해 RestTemplate 사용

- Reactive REST Producer 로부터 정보를 얻기 위해 Reactive RestController 에 요청을 하고 Mono 또는 Flux로 최종 데이터를 가져오는 WebClient 사용

- WebClient 는 interface, DefaultWebClient 는 interface를 구현한 implementation class 임

## 가이드 라인

1.  Base URL 로 WebClient Object 를 생성

2.  Requet METHOD(GET/POST) 를 이용한 Controller method에 Path 제공

3.  존재하는 경우 입력(본문, 매개변수) 제공

4.  mono/flux 유형으로 데이터 검색 요청 생성

Model class 는 Producer Application과 동일한 모델 사용

## 단계 1. 프로젝트 생성

- SpringBoot2ReactiveClientApp 프로젝트 생성

- dependency starter : Spring Reactive Web, Lombok, Spring Boot DebTools

## 단계2. application.properties 에 server 속성 변경

## 단계3. Invoice 모델 생성

- Invoice.java

## 단계4. 각 기능별 Runner class 구현

- GetAllInvoicesRunner.java : 모든 Invoices 검색

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.springboot.reactive.runner;

  import org.springframework.boot.CommandLineRunner;
  import org.springframework.stereotype.Component;
  import org.springframework.web.reactive.function.client.WebClient;

  import com.dev.springboot.reactive.model.Invoice;

  import reactor.core.publisher.Flux;

  @Component
  public class GetAllInvoicesRunner implements CommandLineRunner {

      @Override
      public void run(String... args) throws Exception {
          
          WebClient client = WebClient.create("http://localhost:8080");
          Flux<Invoice> flux= client
                  .get()
                  .uri("/invoice/allInvoices")
                  .retrieve()
                  .bodyToFlux(Invoice.class);
          flux.doOnNext(System.out::println).blockLast();
      }

  }
  ```

  </div>

  </div>

- GetOneInvoiceRunner.java : 하나의 Invoice 조회

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.springboot.reactive.runner;

  import org.springframework.boot.CommandLineRunner;
  import org.springframework.stereotype.Component;
  import org.springframework.web.reactive.function.client.WebClient;

  import com.dev.springboot.reactive.model.Invoice;

  import reactor.core.publisher.Mono;

  @Component
  public class GetOneInvoiceRunner implements CommandLineRunner {

      @Override
      public void run(String... args) throws Exception {
          
          WebClient client = WebClient.create("http://localhost:8080");
          Mono<Invoice> mono= client
                  .get()
                  .uri("/invoice/get/3")
                  .retrieve()
                  .bodyToMono(Invoice.class);
          mono.subscribe(System.out::println);
      }

  }
  ```

  </div>

  </div>

- SaveOrUpdateInvoiceRunner.java : invoice 저장하거나 수정

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.springboot.reactive.runner;

  import org.springframework.boot.CommandLineRunner;
  import org.springframework.stereotype.Component;
  import org.springframework.web.reactive.function.client.WebClient;

  import com.dev.springboot.reactive.model.Invoice;

  import reactor.core.publisher.Mono;

  @Component
  public class SavrOrUpdateInvoiceRunner implements CommandLineRunner {

      @Override
      public void run(String... args) throws Exception {
          
          WebClient client = WebClient.create("http://localhost:8080");
          Mono<Invoice> mono= client
                  .post()
                  .uri("/invoice/save")
                  .body(Mono.just(new Invoice(1, "Invoice1", "INV001", 2345.75)),Invoice.class)
                  .retrieve().bodyToMono(Invoice.class);
          mono.subscribe(System.out::println);
      }

  }
  ```

  </div>

  </div>

- DeleteInvocieRunner.java : Invoice 삭제

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.springboot.reactive.runner;

  import org.springframework.boot.CommandLineRunner;
  import org.springframework.stereotype.Component;
  import org.springframework.web.reactive.function.client.WebClient;

  import reactor.core.publisher.Mono;

  @Component
  public class DeleteInvoiceRunner implements CommandLineRunner {

      @Override
      public void run(String... args) throws Exception {
          
          WebClient client = WebClient.create("http://localhost:8080");
          Mono<Void> mono= client
                  .delete()
                  .uri("/invoice/delete/3")
                  .retrieve()
                  .bodyToMono(Void.class);
          mono.subscribe(System.out::println);
          System.out.println("Invoice Deleted!");
      }

  }
  ```

  </div>

  </div>

# WebClient 심화

## 개요

- REST Client 로 최신 API와 동기,비동기, 그리고 streaming scenarios를 지원하는 WebClient

- Reactive RestController 에 대한 요청을 지원하고 Mono 또는 Flux로 최종 데이터를 가져옴

- WebClient는 Reactive Client Application을 정의하는데 사용하는 interface 임

## 사용 시점

- WebClient는 HTTP/1.1 프로토콜을 통해 작동하는 Reactive non-blocking REST Client 솔루션

- 동기/비동기 작업 모두 지원 → Servlet Stack 에서 실행되는 애플리케이션에서도 허용됨

- non-reactive 또는 Servlet Stack 에서 작업을 block 하여 결과를 얻을 수 있음. block() 메소드 호출

- reactive stack 에서는 block() 사용 권장 안함

## Spring Boot 에서의 WebClient

1.  Spring 5.x의 일부토 Spring WebFlux 모듈로 release됨. Spring 5.x는 기존 RestTEmplate client를 대체하는 새로운 WebClient API 도입

2.  Java 8 람다를 활용하는 함수 스타일 API를 지원

3.  동기식 및 비동기식 REST API 클라이언트, 기본적으로 비동기식임

4.  WebClient는 HTTP/1.1 프로토콜에서 작동되는 반응형, 논-블록, 고도의 동시적이면 리소스를 덜 집약적으로 사용하는 프레임워크를 가진 REST 클라이언트 솔루션임

5.  Servlet Stack과 Spring reactive stack 둘 다 지원

6.  기존 Spring 구성에 쉽게 통합 가능

## Spring Boot에 WebClient 추가하기

- Spring 기반 프로젝트에 dependency가 없을 경우 dependency 추가

- spring-boot-starter-webflux 추가

## WebClient 인스턴스 생성

- WebClient를 생성하는데는 세가지 방법이 있음

  1.  기본 설정과 함께 WebClient 생성

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      WebClient webClient = WebClient.create();
      ```

      </div>

      </div>

  2.  base URI와 함께 생성

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      WebClient webClient = WebClient.create("http://localhost:8080")
      ```

      </div>

      </div>

  3.  DefaultWebClientBuilder 클래스를 사용하여 생성

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      WebClient webClient = WebClient
                 .builder()
                 .baseUrl("http://localhost:8080")
                 .defaultCookie("Key", "Value")
                 .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                 .defaultUriVariables(Collections.singletonMap("url", "http://localhost:8080"))
                 .build();
      ```

      </div>

      </div>

- 마지막 옵션은 가장 고급 옵션이며 요구 사항에 따라 클라이언트 동작을 완전히 사용자 지정할 수 있음

## WebClient 에서 retrive() 와 exchange()

- retrive() 와 exchange() 의 차이점과 사용 방법

- response body에 관심이 있는 경우, retrieve() 메서드 사용

- 더 많은 제어와 response status, header, response body와 같은 모든 response 요소에 관심이 있을 경우 exchange() 사용

- exchange() 메서드는 response status와 header 가 있는 ClientResponse를 반환

- ClientResponse 인스턴스에서 reponse body를 가져올 수 있음

- retrieve() 메서드는 자동 오류 신호(ex: 4xx, 5xx)를 제공하지만 exchange() 메소드의 경우 자동오류 신호가 없으므로 상태 코드를 확인하고 그에 따라 처리

## WebClient를 사용하여 request를 보내기

- WebClient를 사용하여 요청을 보내는 데 가장 일반적으로 사용되는 기본 프로그래밍 구조를 이해해 보자

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  WebClient webClient = WebClient.create();
  WebClient.ResponseSpec responseSpec = webClient.get()
            .uri("//javatechonline.com")
            .retrieve();
  ```

  </div>

  </div>

  - WebClient의 create() 메소드를 호출하여 인스턴스 생성

  - WebClient 인스터스를 사용하여 http GET 요청 메소드와 URI를 설정하고 호출함

  - retrieve() 메소드를 호출하여 요청에 대해 ResponseSpec 가져옴

  - ResponseSpec 를 사용하여 응답 내용을 읽게 된다.

- 요청 자체를 차단하거나 기다리지 않은 비동기 작업

- 다음 예는 요청이 여전히 보류중이므로 아직 response의 세부 정보를 억세스 할 수 없음

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  String responseBody = responseSpec.bodyToMono(String.class).block();
  ```

  </div>

  </div>

- <u>Response body를 읽으려면 응답 내용에 대한 Mono/Flux를 가져와야 합니다.</u>

- <u>Response Body Content를 사용할 수 있으면 어떻게든 풀어야 합니다.</u>

- <u>응답을 풀기 위해 응답의 원시 본문을 포함하는 문자열을 제공하는 가장 간단한 형식을 사용</u>

- <u>그러나 여기에 다른 클래스를 전달하여 이 문서의 뒷부분에서 사용할 적절한 형식으로 콘텐츠를 자동으로 구문분석할 수 있음</u>

- 정확히 어떤 의미인지 헤갈림

# Spring Boot 에서 WebClient를 사용하여 REST Client Application 구현

## 가이드 라인

- 기본 URL을 사용하거나 uri() 메소드를 호출하여 WebClient 객체 생성

- Request METHOD(GET/POST)를 이용한 Controller method 에 Path 제공

- (본문,매개변수)가 존재하는 경우 입력 제공

- Mono/Flux 유형으로 데이터 검색 요청 생성

## 단계1….

~~앞의 예와 동일함~~

~~따라서 생략~~

## WebClient 를 사용하여 HTTP GET,POST,PUT,DELTE 작업 수행

### 단계1. end points 에 대한 모든 상수를 가지고 있는 클래스 생성

- InvoiceConstants.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  public class InvoiceConstants {

      public static final String ADD_INVOICE= "/invoice";

      public static final String GET_ALL_INVOICES = "/allInvoices";

      public static final String GET_INVOICE_BY_ID = "/get/3";

      public static final String GET_INVOICE_BY_NAME = "/invoiceName";

  }
  ```

  </div>

  </div>

### 단계2. 각 endpoint에 대한 모든 메소드를 가지고 있는 클래스 생성

- InvoiceRestClient.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  import java.util.List;

  import org.springframework.web.reactive.function.client.WebClient;
  import org.springframework.web.reactive.function.client.WebClientResponseException;
  import org.springframework.web.util.UriComponentsBuilder;

  import com.dev.springboot.reactive.model.Invoice;

  import lombok.extern.slf4j.Slf4j;

  import static com.dev.springboot.reactive.util.InvoiceConstants.ADD_INVOICE;
  import static com.dev.springboot.reactive.util.InvoiceConstants.GET_ALL_INVOICES;
  import static comp.dev.springboot.reactive.util.InvoiceConstants.GET_INVOICE_BY_ID;
  import static com.dev.springboot.reactive.util.InvoiceConstants.GET_INVOICE_BY_NAME;

  @Slf4j
  public class InvoiceRestClient {

     private WebClient webClient;

     public InvoiceRestClient(WebClient webclient) {
        this.webClient = webclient;
     }

     public List<Invoice> retrieveAllInvoices(){

        try {
            return webClient
             .get()                          //retrieving values, so get()
             .uri(GET_ALL_INVOICES)
             .retrieve()
             .bodyToFlux(Invoice.class)      //returning multiple values, so bodyToFlux
             .collectList()
             .block();                       //to make it synchronous call
        } catch (WebClientResponseException wcre) {
            log.error("Error Response Code is {} and Response Body is {}"
                    ,wcre.getRawStatusCode(), wcre.getResponseBodyAsString());
            log.error("Exception in method retrieveAllInvoices()",wcre);
            throw wcre;
        } catch (Exception ex) {
            log.error("Exception in method retrieveAllInvoices()",ex);
            throw ex;
        }
     }

     public Invoice retrieveInvoiceById(Integer id){

        try {
            return webClient
             .get()                              //retrieving values, so get()
             .uri(GET_INVOICE_BY_ID, id)
             .retrieve()
             .bodyToMono(Invoice.class)          //returning single value, so bodyToMono
             .block();                           // to make it synchronous call
        } catch (WebClientResponseException wcre) {
            log.error("Error Response Code is {} and Response Body is {}"
                ,wcre.getRawStatusCode(), wcre.getResponseBodyAsString());
            log.error("Exception in method retrieveInvoiceById()",wcre);
            throw wcre;
        } catch (Exception ex) {
            log.error("Exception in method retrieveInvoiceById()",ex);
            throw ex;
        }
     }

     public List<Invoice> retrieveInvoiceByName(String invoiceName){

      //URL with Query Parameter: http://localhost:8080/invoice/invoiceName?invoice_name=INV001

        String uri= UriComponentsBuilder
                     .fromUriString(GET_INVOICE_BY_NAME)
                     .queryParam("invoice_name", invoiceName)
                     .build().toUriString();

        try { 
            return webClient.get()
                    .uri(uri)
                    .retrieve()
                    .bodyToFlux(Invoice.class)
                    .collectList() 
                    .block();
        } catch (WebClientResponseException wcre) {
            log.error("Error Response Code is {} and Response Body is {}"
             ,wcre.getRawStatusCode(), wcre.getResponseBodyAsString());
            log.error("Exception in method retrieveInvoiceByName()",wcre);
            throw wcre;
        } catch (Exception ex) {
            log.error("Exception in method retrieveInvoiceByName()",ex);
            throw ex;
        }
     }

     public Invoice addInvoice(Invoice invoice) {

        try { 
            return webClient
                   .post()                    // adding Invoice is a post() request
                   .uri(ADD_INVOICE)
                   .bodyValue(invoice)
                   .retrieve() 
                   .bodyToMono(Invoice.class)
                   .block();
        } catch (WebClientResponseException wcre) {
            log.error("Error Response Code is {} and Response Body is {}"
               ,wcre.getRawStatusCode(), wcre.getResponseBodyAsString());
            log.error("Exception in method addInvoice()",wcre);
            throw wcre;
        } catch (Exception ex) {
            log.error("Exception in method addInvoice()",ex);
            throw ex;
        }
     }

     public Invoice updateInvoice(Invoice invoice, Integer id) {

        try { 
            return webClient
                    .put()
                    .uri(GET_INVOICE_BY_ID, id)
                    .bodyValue(invoice)
                    .retrieve()
                    .bodyToMono(Invoice.class)
                    .block();
        } catch (WebClientResponseException wcre) {
            log.error("Error Response Code is {} and Response Body is {}"
              ,wcre.getRawStatusCode(), wcre.getResponseBodyAsString());
            log.error("Exception in method updateInvoice()",wcre);
            throw wcre;
        } catch (Exception ex) {
            log.error("Exception in method updateInvoice()",ex);
            throw ex;
        } 
     }

     public String deleteInvoiceById(Integer id) {

        try { 
            return webClient
                    .delete() 
                    .uri(GET_INVOICE_BY_ID, id)
                    .retrieve()
                    .bodyToMono(String.class)
                    .block();
        } catch (WebClientResponseException wcre) {
            log.error("Error Response Code is {} and Response Body is {}"
              ,wcre.getRawStatusCode(), wcre.getResponseBodyAsString());
            log.error("Exception in method deleteInvoiceById()",wcre);
            throw wcre;
        } catch (Exception ex) {
            log.error("Exception in method deleteInvoiceById()",ex);
            throw ex;
        } 
     }
  }
  ```

  </div>

  </div>

- 여기서는 WebClient 인스턴스가 동기식 클라이언트처럼 동작해야 한다고 가정하여 각 메소드에 block() 사용

## WebClient를 이용한 복잡한 POST 요청 예

- 복잡한 POST 요청을 보낼 때가 있는데 아래 코드가 그런 예제임

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  import java.net.URI;
  import java.net.URISyntaxException;
  import org.springframework.http.MediaType;
  import org.springframework.util.LinkedMultiValueMap;
  import org.springframework.util.MultiValueMap;
  import org.springframework.web.reactive.function.BodyInserters;

  public String postFormData() throws URISyntaxException {

     MultiValueMap<String, String> bodyValues = new LinkedMultiValueMap<>();

     bodyValues.add("key1", "value1");
     bodyValues.add("key2", "value2");

     String response = webClient.post()
                       .uri(new URI("https://javatechonline.com/post"))
                       .header("Authorization", "SECRET_TOKEN")
                       .contentType(MediaType.APPLICATION_JSON)
                       .accept(MediaType.APPLICATION_JSON)
                       .body(BodyInserters.fromMultipartData(bodyValues))
                       .retrieve()
                       .bodyToMono(String.class)
                       .block();
     return response;
  }
  ```

  </div>

  </div>

- WebClient가 헤더와 복잡한 본문 부분을 구성하는 방법을 봄

- 다른 옵션을 사용하여 바디를 추가할 수 있음

- BodyInserter로 body()를 호출할 수 있음

- Flux로 body()를 호출할 수도 있음

- 또는 bodyValue(value)를 호출할 수도 있음

# 메모리 제한을 재설정하는 방법

- Sprig WebFlux 모듈은 메모리 내 데이터 버퍼링을 위한 기본 메모리 제한을 256kb로 구성

- 이 제한을 초과하면 DataBufferLimitException 발생

- 메노리 제한을 재조정하기 위해 application.properties에 속성을 구성

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  spring.codec.max-in-memory-size=10MB
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
