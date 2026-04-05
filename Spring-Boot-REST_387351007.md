<div id="page">

<div id="main" class="aui-page-panel">

<div id="main-header">

<div id="breadcrumb-section">

1.  [Programming](README.md)
2.  [Programming](Programming_98307.md)
3.  [Spring](Spring_120848385.md)
4.  [Spring Boot](Spring-Boot_223477765.md)

</div>

# <span id="title-text"> Programming : Spring Boot REST </span>

</div>

<div id="content" class="view">

<div class="page-metadata">

Created by <span class="author"> Dongwook Han</span>, last modified on 5월 07, 2023

</div>

<div id="main-content" class="wiki-content group">

- webservices를 통합 레이어로 사용하지 않고 엔터프라이즈 애플리케이션을 개발할 수 없다고 해도 과언이 아님

- 생산자 나 소비자 또는 둘 다의 형태로 웹 서비스 개발

- Producer는 Java로만 개발하기 때문에 매우 중요하다.

- 또한 데이터베이스 상호 작용 논리 구현을 완전히 제어

- Spring Boot를 사용하여 REST CRUD API를 개발하는 방법

- Consumer는 Angular Application, ReactJS Application, Android Device, IOS Device 및 기타 여러가지 또는 우리가 선호하는 Java 기반 RestTemplate일 수 있음

- Spring Boot을 사용하여 생산자 API를 개발하는 것임

- Spring BOOT를 이용한 REST CRUD API 개발 방법

# 목적

- Web services의 context 에서 REST와 REST API는 무엇인가

- 산업 수준의 프로젝트 디자인을 통합하는 Spring Boot REST 애플리케이션을 만드는 방법

- Java가 아닌 다른 애플리케이션에서도 사용할 수 있는 CRUD 작업을 개발하는 방법

- 예외 및 예외 처리기를 포함하여 버그 없는 CRUD 작업을 작성하는 방법

- REST 관련 annotation 사용하는 방법(@RestController, @RequestMapping ..)

- Spring Boot Data JPA repository interface로 작업하는 방법

- 모듈러 와 재사용가능한 코드를 작성하는 방법

- 향후 변경 요청을 염두에 두고 최소한의 변경으로 동적 코드를 구현하는 방법

- 상호 운용성을 얻기 위해 통합 계층을 개발하는 방법

- JSON 데이터를 제공 및 수신하여 REST 애플리케이션을 테스트하는 방법

- Spring Boot를 사용하여 REST CRUD API를 개발하는 방법 배움

# REST 란

- REST는 **Re**presentational **S**tate **T**ransfer의 약자

- 다른 서버 에서 동작하는 두 개의 다른 애플리케이션 간에 global 형식의 상태(data)를 전송한다.

- 데이터를 요청하는 쪽을 Consumer/Client

- 데이터를 제공하는 쪽을 Producer 애플리케이션

- REST는 일련의 규칙을 따라 webservices를 생성하는 아키텍처 스타일

- webservice는 여러 애플리케이션에 재사용 가능한 데이터를 제공하고 인터넷에서 상호 운용성을 제공

- Web services는 RESTfule Web services라 불리우는 REST 아키텍처 스타일을 준수한다.

# REST API 개발을 어떻게 정의할 것인가?

- Rest API를 개발하는 것은 상호 운용 가능한 애플리케이션 간에 데이터를 재사용할 수 있도록 특정 아키텍처 스타일로 클래스 및 메서드를 만드는 것

- REST API 개발 과정에서 RestController 및 각각의 CRUD 작업을 생성

## RestController

- front controller 역할을 하는 필수 클래스

- Body 및 Status를 ResponeEntity 객체로 반환하는 여러 메서드가 포함

- Body는 String, Object, Collections 형식의 데이터를 의미하고 Status는 HttpResponse Status(200, 404, 405,500 등) 을 의미

# REST 프로젝트 구현

- JDK8

- Mysql Database 8.0.19

## 프로젝트 생성

### Starter 선택

- Spring Boot version 2.3.3

- MySQL Driver

- Spring Data JPA

- Lombok

- Spring Web

- Spring Boot DevTools

### Database 생성

- DB Name : REST_INVOICE

- query : CREATE DATABASE REST_INVOICE

### application.properties 수정

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
#  DB Connection Properties
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/REST_INVOICE
spring.datasource.username=root
spring.datasource.password=devs

# JPA Properites
spring.jpa.show-sql=true
spring.jpa.hibernate.ddl-auto=update
spring.jpa.database-platform=org.hibernate.dialect.MySQL8Dialect
```

</div>

</div>

### 샘플 코드 구현

- Invoice.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.invoice.rest.entity;

  import javax.persistence.Entity;
  import javax.persistence.GeneratedValue;
  import javax.persistence.Id;

  import lombok.AllArgsConstructor;
  import lombok.Data;
  import lombok.NoArgsConstructor;

  @Data
  @NoArgsConstructor
  @AllArgsConstructor
  @Entity
  public class Invoice {
      
      @Id
      @GeneratedValue
      private Long id;
      private String name;
      private Double amount;
      private Double finalAmount;
      private String number;
      private String receivedDate;
      private String type;
      private String vendor;
      private String comments;
  }
  ```

  </div>

  </div>

  InvoiceRepository.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.invoice.rest.repo;

  import org.springframework.data.jpa.repository.JpaRepository;
  import org.springframework.data.jpa.repository.Modifying;
  import org.springframework.data.jpa.repository.Query;

  import com.dev.invoice.rest.entity.Invoice;

  public interface InvoiceRepository extends JpaRepository<Invoice, Long>{
      
      // Update is Non-Select Operation, so @Modifying is used
      @Modifying
      @Query("UPDATE Invoice SET number=:number WHERE id=:id")
      Integer updateInvoiceNumberById(String number,Long id);
  }
  ```

  </div>

  </div>

- InvoiceService.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.invoice.rest.service;

  import java.util.List;

  import com.dev.invoice.rest.entity.Invoice;

  public interface IInvoiceService {
      
      /**
       * Takes Invoice Object as input and returns PK generated
       */
      Long saveInvoice(Invoice inv);
      
      /**
       * Takes existing Invoice data as input and updates values
       */
      void updateInvoice(Invoice e);
      
      /**
       * Takes PK(ID) as input and deletes Invoice Object data
       */
      void deleteInvoice(Long id);    
      
      /**
       * Takes id as input and returns one row as one object
       */
      Invoice getOneInvoice(Long id);  //used in RestController
      
      /**
       * select all rows and provides result as a List<Invoice>
       */
      List<Invoice> getAllInvoices();
      
      /**
       * Takes Id as input,checks if record exists returns true, else false
       * 
       */
      boolean isInvoiceExist(Long id);
      
      /**
       * Takes 2 fields as input, updates Invoice data as provided where clause
       * like 'UPDATE Invoice SET number=:number WHERE id=:id'
       */
      Integer updateInvoiceNumberById(String number,Long id);
  }
  ```

  </div>

  </div>

- InvoiceServiceImpl.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.invoice.rest.service.impl;

  import java.util.List;
  import java.util.Optional;

  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.stereotype.Service;
  import org.springframework.transaction.annotation.Transactional;

  import com.dev.invoice.rest.entity.Invoice;
  import com.dev.invoice.rest.exception.InvoiceNotFoundException;
  import com.dev.invoice.rest.repo.InvoiceRepository;
  import com.dev.invoice.rest.service.</yoastmark>IInvoiceService;
  import com.dev.invoice.rest.util.InvoiceUtil;

  @Service 
  public class InvoiceServiceImpl implements IInvoiceService {
      
      @Autowired
      private InvoiceRepository repo;  
      
      @Autowired
      private InvoiceUtil util;
      
      @Override
      public Long saveInvoice(Invoice inv) {
          util.CalculateFinalAmountIncludingGST(inv);
          Long id = repo.save(inv).getId();
          return id;
      }

      @Override
      public void updateInvoice(Invoice inv) {
          util.CalculateFinalAmountIncludingGST(inv);
          repo.save(inv);
      }

      @Override
      public void deleteInvoice(Long id) {
          Invoice inv= getOneInvoice(id);
          repo.delete(inv);
      }
      
      public Optional<Invoice> getSingleInvoice(Long Id) {
          return repo.findById(Id);
      }

      @Override
      public Invoice getOneInvoice(Long id) {

          Invoice inv = repo.findById(id)
                  .orElseThrow(()->new InvoiceNotFoundException(
                          new StringBuffer().append("Product  '")
                          .append(id)
                          .append("' not exist")
                          .toString())
                          );
          return inv;
      }

      @Override
      public List<Invoice> getAllInvoices() {
          List<Invoice> list = repo.findAll();
          //JDK 1.8 List Sort (using Comparator)
                  list.sort((ob1,ob2)->ob1.getId().intValue()-ob2.getId().intValue());
                  //list.sort((ob1,ob2)->ob1.getAmount().compareTo(ob2.getAmount())); //ASC
                  //list.sort((ob1,ob2)->ob2.getAmount().compareTo(ob1.getAmount())); // DESC
          return list;
      }
      
      @Override
      public boolean isInvoiceExist(Long id) {
          
          return repo.existsById(id);
      }
      
      @Override
      @Transactional
      public Integer updateInvoiceNumberById(
              String number, Long id) 
      {
          if(!repo.existsById(id)) { 
              throw new InvoiceNotFoundException(
                      new StringBuffer()
                      .append("Invoice '")
                      .append(id)
                      .append("' not exist")
                      .toString());
          }
          return repo.updateInvoiceNumberById(number, id);
      }
      
  }
  ```

  </div>

  </div>

- ErrorType.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.invoice.rest.entity;

  import lombok.AllArgsConstructor;
  import lombok.Data;
  import lombok.NoArgsConstructor;

  @Data
  @NoArgsConstructor
  @AllArgsConstructor
  public class ErrorType {

      private String time;
      private String status;
      private String message;
      
  }
  ```

  </div>

  </div>

- InvoiceNotFoundException.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.invoice.rest.exception;

  //Custom Exception
  public class InvoiceNotFoundException extends RuntimeException{

      private static final long serialVersionUID = 1L;

      public InvoiceNotFoundException() {
          super();
      }
      
      public InvoiceNotFoundException(String message) {
          super(message);
      }
      
  }
  ```

  </div>

  </div>

- InvoiceErrorHandler.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.invoice.rest.exception.handler;

  import java.util.Date;

  import org.springframework.http.HttpStatus;
  import org.springframework.http.ResponseEntity;
  import org.springframework.web.bind.annotation.ExceptionHandler;
  import org.springframework.web.bind.annotation.RestControllerAdvice;

  import com.dev.invoice.rest.entity.ErrorType;
  import com.dev.invoice.rest.exception.InvoiceNotFoundException;

  //@ControllerAdvice
  @RestControllerAdvice
  public class InvoiceErrorHandler {
      /**
       * In case of InvoiceNotFoundException is thrown
       * from any controller method, this logic gets
       * executed which behaves like re-usable and
       * clear code (Code Modularity)
       * @param nfe
       * @return ResponseEntity
       */
      //@ResponseBody
      @ExceptionHandler(InvoiceNotFoundException.class)
      public ResponseEntity<ErrorType> handleNotFound(InvoiceNotFoundException nfe){
          
          return new ResponseEntity<ErrorType>(
                  new ErrorType(
                          new Date(System.currentTimeMillis()).toString(), 
                          "404- NOT FOUND", 
                          nfe.getMessage()), 
                  HttpStatus.</yoastmark>NOT_FOUND);
      }
  }
  ```

  </div>

  </div>

- InvoiceUtil.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.invoice.rest.util;

  import org.springframework.stereotype.Component;

  import com.dev.invoice.rest.entity.Invoice;

  @Component
  public class InvoiceUtil {
      
      public Invoice  CalculateFinalAmountIncludingGST (Invoice inv) {
          var amount=inv.getAmount();
          var gst= 0.1;
          var finalAmount=amount+(amount*gst);
          inv.setFinalAmount(finalAmount);
          return inv;
      }
      
      public void copyNonNullValues(Invoice req, Invoice db) {
          
          if(req.getName() !=null) {
              db.setName(req.getName());
          }
          
          if(req.getAmount() !=null) {
              db.setAmount(req.getAmount());
          }
          
          if(req.getNumber() !=null) {
              db.setNumber(req.getNumber());
          }
          
          if(req.getReceivedDate() !=null) {
              db.setReceivedDate(req.getReceivedDate());
          }
          
          if(req.getType() !=null) {
              db.setType(req.getType());
          }
          
          if(req.getVendor() !=null) {
              db.setVendor(req.getVendor());
          }
          
          if(req.getComments() !=null) {
              db.setComments(req.getComments());
          }
      }
  }
  ```

  </div>

  </div>

- InvoiceRestController.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.invoice.rest.controller;

  import java.util.List;

  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.http.HttpStatus;
  import org.springframework.http.ResponseEntity;
  import org.springframework.web.bind.annotation.CrossOrigin;
  import org.springframework.web.bind.annotation.DeleteMapping;
  import org.springframework.web.bind.annotation.GetMapping;
  import org.springframework.web.bind.annotation.PatchMapping;
  import org.springframework.web.bind.annotation.PathVariable;
  import org.springframework.web.bind.annotation.PostMapping;
  import org.springframework.web.bind.annotation.PutMapping;
  import org.springframework.web.bind.annotation.RequestBody;
  import org.springframework.web.bind.annotation.RequestMapping;
  import org.springframework.web.bind.annotation.RestController;

  import com.dev.invoice.rest.entity.Invoice;
  import com.dev.invoice.rest.exception.InvoiceNotFoundException;
  import com.dev.invoice.rest.service.IInvoiceService;
  import com.dev.invoice.rest.util.InvoiceUtil;

  @RestController
  @RequestMapping("/api")
  // @CrossOrigin(origins = "http://localhost:4200") //Required in case of Angular Client
  public class InvoiceRestController {
      
      @Autowired
      private IInvoiceService service;  
      
      @Autowired
      private InvoiceUtil util;
      
      /**
       * Takes Invoice Object as input and returns save Status as ResponseEntity<String>
       */
      @PostMapping("/invoices")
      public ResponseEntity<String> saveInvoice(@RequestBody Invoice inv){
          ResponseEntity<String> resp = null;
          try{
              Long id = service.saveInvoice(inv);
              resp= new ResponseEntity<String>(
                      "Invoice '"+id+"' created",HttpStatus.CREATED); //201-created
          } catch (Exception e) {
              e.printStackTrace();
              resp = new ResponseEntity<String>(
                      "Unable to save Invoice", 
                      HttpStatus.INTERNAL_SERVER_ERROR); //500-Internal Server Error
          }
          return resp;
      }
      
      /**
       * To retrieve all Invoices, returns data retrieval Status as ResponseEntity<?>
       */
      @GetMapping("/invoices")
      public ResponseEntity<?> getAllInvoices() {
          ResponseEntity<?> resp=null;
          try {
              List<Invoice> list= service.getAllInvoices();
              resp= new ResponseEntity<List<Invoice>>(list,HttpStatus.OK);
          } catch (Exception e) {
              e.printStackTrace();
              resp = new ResponseEntity<String>(
                      "Unable to get Invoice", 
                      HttpStatus.INTERNAL_SERVER_ERROR);
          }
          return resp;
      }
      
      /**
       * To retrieve one Invoice by providing id, returns Invoice object & Status as ResponseEntity<?>
       */
      @GetMapping("/invoices/{id}")
      public ResponseEntity<?> getOneInvoice(@PathVariable Long id){
          ResponseEntity<?> resp= null;
          try {
              Invoice inv= service.getOneInvoice(id);
              resp= new ResponseEntity<Invoice>(inv,HttpStatus.OK);
          }catch (InvoiceNotFoundException nfe) {
              throw nfe; 
          }catch (Exception e) {
              e.printStackTrace();
              resp = new ResponseEntity<String>(
                      "Unable to find Invoice", 
                      HttpStatus.INTERNAL_SERVER_ERROR);
          }
          return resp;
      }
      
      /**
       * To delete one Invoice by providing id, returns Status as ResponseEntity<String>
       */
      @DeleteMapping("/invoices/{id}")
      public ResponseEntity<String> deleteInvoice(@PathVariable Long id){
          
          ResponseEntity<String> resp= null;
          try {
              service.deleteInvoice(id);
              resp= new ResponseEntity<String> (
                      "Invoice '"+id+"' deleted",HttpStatus.OK);
              
          } catch (InvoiceNotFoundException nfe) {
              throw nfe;
          } catch (Exception e) {
              e.printStackTrace();
              resp= new ResponseEntity<String>(
                      "Unable to delete Invoice", HttpStatus.INTERNAL_SERVER_ERROR);
          }
          
          return resp;
      }
      
      /**
       * To modify one Invoice by providing id, updates Invoice object & returns Status as ResponseEntity<String>
       */
      @PutMapping("/invoices/{id}")
      public ResponseEntity<String> updateInvoice(@PathVariable Long id, @RequestBody Invoice invoice){
          
          ResponseEntity<String> resp = null;
          try {
              //db Object
              Invoice inv= service.getOneInvoice(id);
              //copy non-null values from request to Database object
              util.copyNonNullValues(invoice, inv);
              //finally update this object
              service.updateInvoice(inv);
              resp = new ResponseEntity<String>(
                      //"Invoice '"+id+"' Updated",
                      HttpStatus.RESET_CONTENT); //205- Reset-Content(PUT)
              
          } catch (InvoiceNotFoundException nfe) {
              throw nfe; // re-throw exception to handler
          } catch (Exception e) {
              e.printStackTrace();
              resp = new ResponseEntity<String>(
                      "Unable to Update Invoice", 
                      HttpStatus.INTERNAL_SERVER_ERROR); //500-ISE
          }
          return resp;
      }
      
      /**
       * To update one Invoice just like where clause condition, updates Invoice object & returns Status as ResponseEntity<String>
       */
      @PatchMapping("/invoices/{id}/{number}")
      public ResponseEntity<String> updateInvoiceNumberById(
              @PathVariable Long id,
              @PathVariable String number
              ) 
      {
          ResponseEntity<String> resp = null;
          try {
              service.updateInvoiceNumberById(number, id);
              resp = new ResponseEntity<String>(
                      "Invoice '"+number+"' Updated",
                      HttpStatus.PARTIAL_CONTENT); //206- Reset-Content(PUT)
              
          } catch(InvoiceNotFoundException pne) {
              throw pne; // re-throw exception to handler
          } catch (Exception e) {
              e.printStackTrace();
              resp = new ResponseEntity<String>(
                      "Unable to Update Invoice", 
                      HttpStatus.INTERNAL_SERVER_ERROR); //500-ISE
          }
          return resp;
      }
  }
  ```

  </div>

  </div>

### 애플리케이션 실행

- Tool에서 제공하는 실행방법으로 Spring Boot Application 실행

### 테스트하기

- REST 애플리케이션을 테스트하는 방법에는 여러가지가 있으며 그 중에 POSTMAN을 사용하여 테스트

- POSTMAN 프로그램 다운 <a href="https://www.postman.com/downloads/" class="external-link" data-card-appearance="inline" rel="nofollow">https://www.postman.com/downloads/</a>

#### testing saveInvoice() method

- service url : http://localhost:8080/api/invoices

- Postman 프로그램에서 method 는 POST 선택, URL에 service url 입력 후, BODY를 선택한 후 ‘Raw’ 클릭하고 JSON 선택

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  {
  "name":"Inv1",
  "amout";135.0,
  "number":"Inv02345",
  "receivedDate":"14-10-2020",
  "type":"normal",
  "vendor":"wed2",
  "comments":"on Hold"
  }
  ```

  </div>

  </div>

#### testing getAllInvoices() method

- url : http://loalhost:8080/api/invoices

- method : GET

- BODY : raw, JSON

#### Testing getOneInvoice() method

- url : http://localhost:8080/api/invoices/{id}

- method : GET

- BODY : raw, JSON

- id : 2

#### Testing updateInvoice() method

- url : http://localhost:8080/api/invoices/{id}

- method : PUT

- BODY : raw, JSON

- id : 2

#### Testing deleteInvoice() method

- url : <a href="http://localhost:8080/api/invoices/%7Bid%7D" class="external-link" rel="nofollow">http://localhost:8080/api/invoices/{id}</a>

- method : DELETE

- BODY : raw, JSON

- id : 2

#### Testing updateInvoiceNumberById() method

- url : <a href="http://localhost:8080/api/invoices/%7Bid%7D/%7Bnumber%7D" class="external-link" rel="nofollow">http://localhost:8080/api/invoices/{id}/{number}</a>

- method : PATH

- BODY : raw, JSON

- id : 1

- number : Inv02345

# REST API 에서 Boilerplate Code 줄이기

- Spring Data REST개념에서 RestController 및 해당 메서드를 작성할 필요가 없음

- Spring Data REST는 HATEOAS(Hypertext as the Engine of Application State) 를 사용하여 처리

- HATEOAS 프로젝트는 REST 표현을 쉽게 만다는게 사용할 수 있는 API 라이브러리

- Spring Data REST는 HATEOAS의 도움만으로만 REST 작업에 액세스할 수 있는 hyperlink 제공

- Resource의 일부 세부 정보가 요청되면 리스소의 세부정보 + 관련 리소스의 세부정보 + 리소스에서 수행할 수 있는 가능한 작업 제공(<u>HATEOAS 가 요청받은 것에 대해 세부정보,관련 정보, 가능한 작업 제공을 한 다는 뜻?</u>) : HATEOAS는 이러한 유형의 세부 정보를 제공

## Spring Data Rest

- 많은 수동 작업을 최소화하고 CRUD 기능의 기본 구현을 매우 쉽게 제공하는 개념

- Spring Data Project 위에 구축

## Spring Data Rest 사용하기

- pom.xml, gradle 에 ‘spring-boot-starter-data-rest’ 추가

## Spring Data Rest 개념 적용 위치

- CRUD 작업만 필요한 애플리케이션에서는 이 개념을 사용하여 REST API 생성

- 이 개념을 사용하여 상용구 코드를 줄일 수 있을 뿐만 아니라 Controller 및 메서드 레벨에서 annotation을 제거할 수 있음

## Spring Data Rest 생성 단계

### Spring Boot Starter project 생성

### Spring Boot Starter Project에 dependency 추가

- Spring Data JPA

- Spring Data REST : Rest Repository

- MySQL Driver

- Lombok

- Spring Boot DevTools

### Model/Entity Class 구현

- API 를 생성하기 위해 앞 장의 예제 Invoice의 entity 를 가져와 사용

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.invoice.rest.entity;

  import javax.persistence.Entity;
  import javax.persistence.GeneratedValue;
  import javax.persistence.Id;

  import lombok.Data;

  @Data
  @Entity
  public class Invoice {
      
      @Id
      @GeneratedValue
      private Long id;
      private String name;
      private Double amount;
      private Double finalAmount;
      private String number;
      private String receivedDate;
      private String type;
      private String vendor;
      private String comments;
  }
  ```

  </div>

  </div>

### Repository interface 구현

- CrudRepository를 상속받아 InvoiceRepository를 구현

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.invoice.rest.repo;

  import org.springframework.data.repository.CrudRepository;

  import com.dev.invoice.rest.entity.Invoice;

  public interface InvoiceRepository extends CrudRepository<Invoice, Long> {
      
  }
  ```

  </div>

  </div>

### application.properties 수정

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
#  DB Connection Properties
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/REST_INVOICE
spring.datasource.username=root
spring.datasource.password=devs

# JPA Properites
spring.jpa.show-sql=true
spring.jpa.hibernate.ddl-auto=update
spring.jpa.database-platform=org.hibernate.dialect.MySQL8Dialect
```

</div>

</div>

- RestController 생성 없이 Entity class와 Repository interface 만 생성하면 알아서 REST API 생성함

### Spring Data REST를 사용하는 REST API 테스팅

#### Browser 로 url (<a href="http://localhost:8080/" class="external-link" rel="nofollow">http://localhost:8080/</a>) 접속

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
{
     _links: {
         invoices: {
            href: "http://localhost:8080/invoices"
             },
      profile: {
            href: "http://localhost:8080/profile"
           }
       }
 }
```

</div>

</div>

- 위의 출력은 REST API 에 대한 URL 이 '<a href="http://localhost:8080/invoices" class="external-link" rel="nofollow">http://localhost:8080/invoices</a> 임을 나타냄

- 여기서 주목할 점은 http 경로에 Entity 이름(Invoice)를 가져와서 첫글짜 소문자로 변환하고 접미사 s 추가

#### CRUD 명령어에 대한 URL 생성

- Base URL = http://localhost:8080/invoices

- 모든 Invoice 조회 GET URL : http://localhost:8080/invoices

- 특정 Invoice 조회 GET URL : http://localhost:8080/invoices/{id}

- invoice 저장 POST URL : http://localhost:8080/invoices/{id}

- invoice 수정 PUT URL : http://localhost:8080/invoices/{id}

- invoice 삭제 DELETE URL : http://localhost:8080/invoices/{id}

#### 생성된 API에 대해 테스트

- 앞에서 설명했듯이 POSTMAN 으로 테스트 진행

# Spring Boot RestTemplate를 사용하여 REST Consumer API 구현

- 세 개의 알려진 계층, 프레젠테이션 계층, 서비스 계층 및 데이터 계층 외에도 통합 계층이 있을 수 있음

- 통합 계층은 일반적으로 webservices 개념과 함께 작동하며 서로 다른 두 애플리케이션을 연결하여 데이터를 교환. Producer/Provider 와 consumers

- 이 장에서는 RestTemplate 를 이용하여 REST Consumer API 구현에 대해 설명

## RestTemplate

- Spring Boot REST 프로젝트에서 사전 정의된 클래스

- Producer 애플리케이션의 모든 메소드 유형(GET,POST,PUT,DELETE 등) 에 대한 HTTP 호출을 만드는데 도움이 됨

- Spring Boot 에서는 이 클래스를 자동 구성하지 않음

- JSON/XML 을 Object로, Object를 JSON/XML 로 자동 변환

- 서버정보 IP, PORT, 경로, 메소드 유형, 입력 데이터 형식, 출력 데이터 형식 같은 producer Endpoint 세부 정보 필요

- RestTemplate은 모든 HTTP method 를 소비하는 exchange() 메소드를 제공

## getForObject() 와 getForEntity()간의 차이점

- getForObject(url, T.class) : 주어진 URL에 HTTP GET 메소드를 사용하여 Entity를 조회하고 T를 반환. Status,헤더 매개변수는 반환하지 않고 응답 본문만 반환

- getForEntity(url, T.class) : 주어진 URL에 HTTP GET 메소드를 사용하여 entity를 조회하고 ResponseEntity\<T\> 반환

## postForObject() 와 postForEntity()간의 차이점

- postForObject(url, request, T.class) : 주어진 URL에 HTTP POST 메서드를 사용하여 entity를 저장하고 T를 반환. 상태, 헤더 매개변수를 반환하지 않고 응답 본문만 반환

- postForEntity(url, request, T.class) : 주어진 URL에 HTTP POST 메서드를 사용하여 entity를 저장하고 ResponseEntity\<T\> 반환

## RestTemplate의 exchange() 메소드 사용

- exchange() 메소드는 모든 HTTP 메서드(GET/POST/PUT/DELETE/…) 호출을 지원

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  exchange(String url, Httpmethod method, HttpEntity<?> requestEntity, Class<T> responseType, Object... uriVariables):ResponnseEntity<T>
  ```

  </div>

  </div>

  - url : Producer application URL

  - HttpMethod : enum to provide method type

  - HttpEntity : Request Body + HttpHeaders

  - responseType : Class Type of response

  - Object-var/args : sending multiple pathVariables

## RestTemplate의 parameter

- URL

- Body of Requests

- Media Type : APPLICATION_JSON, APPLICATION_XML, APPLICATION_PDF 등

- Http Method Type

- Return type of producer method

- Path Variables

## RestTemplate 구현

- 앞의 예제 Invoice 를 사용

- RestTemplate 으로 각 메소드 정의

- Save Invoice

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  private void saveInv() {
    // 1. Producer application Url
    String url = "http://localhost:8080/api/invoices";
    // Send JSON data as Body
    String body = "{\"name\":\"INV11\",\"amout\":234.11,\"number\":\"INVOICE11\",\"receivedDate\":\"28-10-2020\",\"type\":\"Normal\",\"vendor\":\"ADHR001\",\"comments\",:\"On Hold\"}";
    // Http Header
    headers.setContextType(MediaType.APPLICATION_JSON);
    //requestEntity ; Body+Header
    HttpEntity<String> request = new HttpEntity<String>(body, headers);
    // 2. make HTTP call and store Respoonse (URL, ResponseType)
    // ResponseEntity<String> response = restTemplate.postForEntity(url, request, String.class);
    ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, request, String.class);
    // 3. Print details(body, status.. etc)
    logger.info("Response Body ; {}", response.getBody());
    logger.info("Status code value : {}", responsegetStatusCodeValue());
    logger.info("Status code : {}", response.getStatusCode().name());
  }
  ```

  </div>

  </div>

- get All Invoices

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  private void getAllInvoices() {
    String url = "http://localhost:8080/api/invoices";
    ResponseEntity<Invoice[]> response = restTemplate.getForEntity(url, Invoice[].class);
    // ResponseEntity<Invoice[]> response = restTemplate.exchange(url, HttpMethod.GET, null, Invoice[].class);
    Invoice[] invs = response.getBody();
    List<Invoice> list = Arrays.asList(invs);
    
    logger.info("Response Body ; {}", response.getBody());
    logger.info("Status code value : {}", responsegetStatusCodeValue());
    logger.info("Status code : {}", response.getStatusCode().name());
    logger.info("Headers {} : ", response.getHeaders());
  }
  ```

  </div>

  </div>

- get One Invoice

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  private void getOneInvoices() {
    String url = "http://localhost:8080/api/invoices/{id}";
    //ResponseEntity<Invoice[]> response = restTemplate.getForEntity(url, String.class);
    ResponseEntity<Invoice[]> response = restTemplate.exchange(url, HttpMethod.GET, null, String.class, 7);
    Invoice[] invs = response.getBody();
    List<Invoice> list = Arrays.asList(invs);
    
    logger.info("Response Body ; {}", response.getBody());
    logger.info("Status code value : {}", responsegetStatusCodeValue());
    logger.info("Status code : {}", response.getStatusCode().name());
  }
  ```

  </div>

  </div>

- update invoice

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  private void updateInvoice() {
          String url = "http://localhost:8080/api/invoices/{id}";
          String body = "{\"name\":\"INV13\",\"amount\":888}";
          // Request Header
          HttpHeaders headers = new HttpHeaders();
          headers.setContentType(MediaType.APPLICATION_JSON);
          // requestEntity = Body + header
          HttpEntity<String> requestEntity = new HttpEntity<String>(body, headers);
      //  restTemplate.put(url, requestEntity, 7);
          ResponseEntity<String> response= restTemplate.exchange(url, HttpMethod.PUT, requestEntity, String.class, 7);
          logger.info("Response Body : {}", response.getBody());
          logger.info("Status code value : {}", response.getStatusCodeValue());
          logger.info("Status code : {}",response.getStatusCode().name());
          logger.info("Response Headers : {}", response.getHeaders());
      }
  ```

  </div>

  </div>

- delete Invoice

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  private void deleteInvoice() {
          String url = "http://localhost:8080/api/invoices/{id}";
      //  restTemplate.delete(url, 6);
          ResponseEntity<String> response= restTemplate.exchange(url, HttpMethod.DELETE, null, String.class,5);
          logger.info("Response Body : {}", response.getBody());
          logger.info("Status code value : {}", response.getStatusCodeValue());
          logger.info("Status code : {}",response.getStatusCode().name());
          logger.info("Response Headers : {}", response.getHeaders());
      }
  ```

  </div>

  </div>

# 전체 소스

- Invoice Producer에 요청하는 전체 Consumer 코드를 구현

- SpringBootRestTemplateApplication.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.springboot.rest.template;

  import org.springframework.boot.SpringApplication;
  import org.springframework.boot.autoconfigure.SpringBootApplication;
  import org.springframework.context.annotation.Bean;
  import org.springframework.web.client.RestTemplate;

  @SpringBootApplication
  public class SpringBootRestTemplateApplication {

      public static void main(String[] args) {
          SpringApplication.run(SpringBootRestTemplateApplication.class, args);
      }
      
      @Bean
      public RestTemplate getRestTemplate() {
          return new RestTemplate();
      }
  }
  ```

  </div>

  </div>

- Invoice.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.springboot.rest.template.entity;

  import lombok.AllArgsConstructor;
  import lombok.Data;
  import lombok.NoArgsConstructor;

  @Data
  @NoArgsConstructor
  @AllArgsConstructor
  public class Invoice {
      
      private Long id;
      private String name;
      private Double amount;
      private Double finalAmount;
      private String number;
      private String receivedDate;
      private String type;
      private String vendor;
      private String comments;
      
  }
  ```

  </div>

  </div>

- RestTemplateRunner.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.springboot.rest.template.runner;

  import java.util.Arrays;
  import java.util.List;

  import org.slf4j.Logger;
  import org.slf4j.LoggerFactory;
  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.boot.CommandLineRunner;
  import org.springframework.http.HttpEntity;
  import org.springframework.http.HttpHeaders;
  import org.springframework.http.HttpMethod;
  import org.springframework.http.MediaType;
  import org.springframework.http.ResponseEntity;
  import org.springframework.stereotype.Component;
  import org.springframework.web.client.RestTemplate;

  import com.dev.springboot.rest.template.entity.Invoice;

  @Component
  public class RestTemplateRunner implements CommandLineRunner {

      private Logger logger = LoggerFactory.getLogger(RestTemplateRunner.class);
      
      @Autowired
      RestTemplate restTemplate;
      
      @Override
      public void run(String... args) throws Exception {
          saveInv();
  //      getAllInvoices();
  //      getOneInvoice();
  //      updateInvoice();
  //      deleteInvoice();
      }
      
      
      private void saveInv() {
          // 1. Producer application URL
          String url = "http://localhost:8080/api/invoices";
          // Send JSON data as Body
          String body = "{\"name\":\"INV11\", \"amount\":234.11,\"number\":\"INVOICE11\",\"receivedDate\":\"28-10-2020\",\"type\":\"Normal\",\"vendor\":\"ADHR001\",\"comments\" :\"On Hold\"}";
          // Http Header 
          HttpHeaders headers = new HttpHeaders();
          //Set Content Type
          headers.setContentType(MediaType.APPLICATION_JSON);
          //requestEntity : Body+Header
          HttpEntity<String> request = new HttpEntity<String> (body,headers);
          // 2. make HTTP call and store Response (URL,ResponseType)
      //  ResponseEntity<String> response =  restTemplate.postForEntity(url, request, String.class);
          ResponseEntity<String> response =  restTemplate.exchange(url, HttpMethod.POST,request, String.class);
          // 3. Print details(body,status..etc)
          logger.info("Response Body : {}", response.getBody());
          logger.info("Status code value : {}", response.getStatusCodeValue());
          logger.info("Status code : {}", response.getStatusCode().name());

      }
      
      private void getAllInvoices() {
          String url = "http://localhost:8080/api/invoices";
          ResponseEntity<Invoice[]> response = restTemplate.getForEntity(url,Invoice[].class);
      //  ResponseEntity<Invoice[]> response = restTemplate.exchange(url, HttpMethod.GET, null, Invoice[].class);
          Invoice[] invs = response.getBody();
          List<Invoice> list = Arrays.asList(invs);

          logger.info("Response Body : {}", list);
          logger.info("Status code value : {}", response.getStatusCodeValue());
          logger.info("Status code : {}", response.getStatusCode().name());
          logger.info("Headers {} :", response.getHeaders());
      }

      private void getOneInvoice() {
          String url = "http://localhost:8080/api/invoices/{id}";
      //  ResponseEntity<String> response= restTemplate.getForEntity(url, String.class, 9);
          ResponseEntity<String> response= restTemplate.exchange(url, HttpMethod.GET, null, String.class, 7);
          logger.info("Response Body : {}", response.getBody());
          logger.info("Status code value : {}", response.getStatusCodeValue());
          logger.info("Status code : {}",response.getStatusCode().name());
      }
      
      private void updateInvoice() {
          String url = "http://localhost:8080/api/invoices/{id}";
          String body = "{\"name\":\"INV13\",\"amount\":888}";
          // Request Header
          HttpHeaders headers = new HttpHeaders();
          headers.setContentType(MediaType.APPLICATION_JSON);
          // requestEntity = Body + header
          HttpEntity<String> requestEntity = new HttpEntity<String>(body, headers);
      //  restTemplate.put(url, requestEntity, 7);
          ResponseEntity<String> response= restTemplate.exchange(url, HttpMethod.PUT, requestEntity, String.class, 7);
          logger.info("Response Body : {}", response.getBody());
          logger.info("Status code value : {}", response.getStatusCodeValue());
          logger.info("Status code : {}",response.getStatusCode().name());
          logger.info("Response Headers : {}", response.getHeaders());
      }
      
      private void deleteInvoice() {
          String url = "http://localhost:8080/api/invoices/{id}";
      //  restTemplate.delete(url, 6);
          ResponseEntity<String> response= restTemplate.exchange(url, HttpMethod.DELETE, null, String.class,5);
          logger.info("Response Body : {}", response.getBody());
          logger.info("Status code value : {}", response.getStatusCodeValue());
          logger.info("Status code : {}",response.getStatusCode().name());
          logger.info("Response Headers : {}", response.getHeaders());
      }
      
  }
  ```

  </div>

  </div>

# ResponseEntity를 Java Object로 변환하기

## getForEntity 메소드를 사용하여 Object 배열로 반환

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
ResponseEntity<Invoice[]> response = restTemplate.getForEntity(url, Invoice[].class);

Invoice[] invs = response.getBody();
List<Invoice> list = Arrays.asList(invs);
System.out.println("Response Body : " +list);
```

</div>

</div>

## exchage() 메소드를 사용하여 Object 목록으로 반환

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
ResponseEntity<List<Invoice>> response = restTemplate.exchange(url, HttpMethod.GET, null, new ParameterizedTypeReference<List<Invoice>>() {});

List<Invoice> list = response.getBody();
System.out.println("Response Body : " +list);
```

</div>

</div>

## exchage() 메소드를 사용하여 Object 배열로 반환

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
ResponseEntity<Invoice[]> response = restTemplate.exchange(url, HttpMethod.GET, null, Invoice[].class);

Invoice[] invs = response.getBody();
List<Invoice> list = Arrays.asList(invs);
System.out.println("Response Body : " +list);
```

</div>

</div>

- RestTemplate API 정보 <a href="https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/client/RestTemplate.md" class="external-link" data-card-appearance="inline" rel="nofollow">https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/client/RestTemplate.md</a>

</div>

</div>

</div>

<div id="footer" role="contentinfo">

<div class="section footer-body">

Document generated by Confluence on 4월 05, 2026 17:57



</div>

</div>

</div>
