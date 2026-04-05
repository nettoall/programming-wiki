<div id="page">

<div id="main" class="aui-page-panel">

<div id="main-header">

<div id="breadcrumb-section">

1.  [Programming](index.html)
2.  [Programming](Programming_98307.html)
3.  [Spring](Spring_120848385.html)
4.  [Spring Boot](Spring-Boot_223477765.html)

</div>

# <span id="title-text"> Programming : Spring Boot AOP </span>

</div>

<div id="content" class="view">

<div class="page-metadata">

Created by <span class="author"> Dongwook Han</span>, last modified on 4월 04, 2023

</div>

<div id="main-content" class="wiki-content group">

# 개요

- AOP : Aspect Oriented Programming

- 모든 클래스에 적용되는 공통적인 코드가 있을 때 별도의 클래스에 정의하고 모든 클래스에 반영하여 코드의 가독성 및 재사용성 향상

- 예를 들어 로깅, 보안, 트랜잭션 관리, 데이터 전송 등

- Cross-Cutting Concerns 라고도 함

## 목적

- Apspect Oriented Programming 이란

- Spring Boot 애플리케이션에서 AOP를 구현하는 중요성과 이점

- cross-cutting concern 과 AOP 개념과 무슨 관련이 있는지?

- Advice, PointCut, JoinPoint, Target, Proxy, Viewing 용어의 의미

- Spring 애플리케이션에서 AOP를 구현하는 다른 방법

- AspectJ란?

- advice 종류는 몇가지 인가

- After, After Returning, After Throwing advices 의 차이점

- @EnableAspectJAutoProxy, @Aspect, @PointCut, @Before, @After, @AfterReturning, @AfterThrowing, @Around annotation 사용하는 위치

- PointCut 표현의 예

- 특정 Annotation이 있는 메소드를 Pointcut 표현식이 선택하는 방법

- Spring Boot 애플리케이션에서 AOP를 구현하는 방법

# Cross-cutting concern

- 애플리케이션의 다른 부분에 영향을 미칠 수 있는 프로그램의 일부(뭔 소리냐?)

- 이름에서 알 수 있듯이, 전체 응용 프로그램에 영향을 미치는 문제, 응용 프로그램 전체에 적용할 수 있음

- 일반적으로 이러한 개념들을 엔터프라이즈 애플리케이션의 모든 계층에 포함시킨다.

- 예를 들어 로깅, 보안, 트랜잭션 관리, 데이터 전송, 오류 처리, 성능 모니터링, 캐싱, 사용자 지정 비즈니스 규칙 등

- 결과적으로 Corss-cutting 은 원시 업무 로직 코드로부터 부가 기능 코드를 분리하는 프로세스 이다.

- **원래 업무 로직에 부가적인 기능(로깅, 보안, 트랜잭션 관리 등등) 을 통합되어 있는 걸 분리시키는 것을 Cross-cutting 이라고 함.**

# AOP 란

- Aspect-oriented programming 은 cross-cutting concerns 의 분리를 도와 모듈성을 높이는제 중점을 둔 프로그래밍 패러다임이다.

- 원 코드 자체를 수정하지 않고 기존 코드에 추가 동작(이걸 advice 라 함)을 추가하여 이를 가능하게 함.

- 예로 ‘get’으로 시작되는 함수의 이름을 가진 모든 함수에 log 하라는 것과 같은 ‘pointcut’ 규정을 통해 코드가 변경되어야 하는 것을 별도로 지정하여 반영

- AOP는 Aspect-oriented 소프트웨어 개발의 기반을 형성

- AOP는 모듈성을 높이는데 도움이 되므로 모듈성을 제공한다는 점에서 OOP를 따른다.

- 그러나 AOP에서 모듈성 단위가 클래스 대신 Aspect가 된다는 차이가 있다.

# Spring AOP 란

- Spring 애플리케이션에서 Aspect-oriented programming 을 적용할 때 Sping AOP 라 함

- 주로 Spring AOP에서 트랜잭션관리, 로깅, 보안, 예외 처리 등에 이 개념을 사용

# AOP에서 Aspect 란

- 모든 코드를 두 개의 주요 부분으로 나누는 엔터프라이즈 애플리케이션 코드가 있다고 가정

- 한 부분은 기본 비즈니스 로직,

- 다른 부분은 cross-cutting concern은 로깅, 보안, 예외 처리 등과 같은 추가 기능을 통합하는 나머지 부분

- 여기서 프로그래밍 방식으로 추가 기능을 구현하기 위해 별도로 작성 하는 클래스를 aspect라 함

# advice

- Aspect의 실제 구현

- 추가기능을 구현하기 위해 Aspect 클래스 내부에 작성하는 메소드

# pointcut

- advice가 필요한 비즈니스 로직을 알려주는 표현

- pointcut은 어떤 advice에 적용할 것인지 알려주지 않음(구체적으로 콕 찍어서 알려주지 않는다인가?)

- 우리가 advice를 적용해야 하는 비즈니스 로직 메소드의 목록을 규정하는 표현식을 가지고 있음

- 간단히 말하자면 전체적으로 일종의 비즈니스 로직 메서드 선택기임

- 중요한 점은 Pointcut 표현식은 \*, . 두 가지 기호만 허용

# JoinPoint

- JoinPoint는 Pointcut과 advice를 결합

- 선택된 비즈니스 로직 메소드를 필요한 advice와 연결

# Target

- 아무런 advice도 없는 평범한 비즈니스 클래스

- 이 클래스가 advice가 필요한 Target 임

# Proxy

- viewing의 최종 출력

- 실제로 advice가 혼합된 비즈니스 메서드가 호출될 때 proxy object가 생성됨

# Viewing

- 비즈니스 로직 메서드와 필요한 advice를 혼합하는 프로세스

# Spring 애플리케이션에서 AOP를 구현하는 다른 방법

- Spring 애플리케이션에서 AOP를 구현하는 두가지 방법

  1.  XML 기반 구성 사용

      1.  XML를 사용하여 AOP 개념을 구현

      2.  현재는 거의 사용 안 함

  2.  AspectJ Annotations 사용

      1.  annotation을 사용

      2.  AspectJ는 PARC에서 자바 프로그래밍 언어용으로 만든 확장기능인 aspect-oriented programming 라이브러리

      3.  AOP를 위한 매우 대중적이로 널리 사용되는 효과적인 표준

# Advice 의 종류

- 다섯가지 유형의 advice

## Before Advice

- 비즈니스 메소드 실행전에 실행

- Advice 실행이 완료되면 메서드 실행이 자동으로 실행됨

## After Advice

- 비즈니스 메소드 실행후 실행

- 메서드 실행이 완료되면 어드바이스 실행이 자동으로 실행

## Around Advice

- 두 부분으로 실행

- 비즈니스 메소드 실행전에 실행

- 비즈니스 메소드 실행 후에 실행

## After Returning Advie

- 메소드가 성공적으로 실행되는 경우에만 비즈니스 메소드 실행 후에 실행

## After Throwing Advice

- 메소드가 성공적으로 실행되지 않은 경우에만 비즈니스 메소드 실행 후에 실행

- 동일한 유형의 advice 또는 단일 비즈니스 메소드에 연결된 다른 유형의 adivce를 얼마든지 가질 수 있음

# After, After Returning, After Throwing Advices 차이점

- After Advice는 비즈니스 메소드 실행 후에 강제로 실행됨

- After Returing와 After Throwing 은 비즈니스 메소드 실행 후에 조건에 따라 실행되거나 실행되지 않을 수 있음

- After Returning은 비즈니스 메소드가 성공적으로 실행되었을 때만 실행

- After Throwing은 비즈니스 메소드가 실행 실패시에만 실행됨

# AOP에서 사용되는 annotation 들

## @Aspect

- 클래스 위에 @Aspect를 적용하여 Aspect 클래스임을 나타냄

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Aspect
  public class InvoiceAspect{}
  ```

  </div>

  </div>

## @Pointcut

- Apect 클래스의 메소드 위에 적용

- 비즈니스 메소드위의 {} 에 표현식 정의

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Pointcut("execution(public void com.dev.spring.aop.service.InvoiceBusinessService.saveInvoice())")
  public void p1(){}
  ```

  </div>

  </div>

## @Before

- @Before annotation이 있는 메소드는 Before Advice를 나타내며 비즈니스 메소드 실행전에 실행

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Before("p1()")
  public void beginTransaction(){
    System.out.println("Transaction Begin");
  }
  ```

  </div>

  </div>

## @After

- @After annotation이 달린 메소드는 After Advice를 나타내며, 비즈니스 메소드 실행 후에 실행

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @After("p1()")
  public void completeTransaction(){
    System.out.println("Transaction complete !!");
  }
  ```

  </div>

  </div>

## @AfterReturning

- After Returning Advice를 나타내며, 비즈니스 메소드가 성공적으로 실행되었을 때만 실행됨

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @AfterReturning("p1()")
  public void commitTransaction(){
    System.out.println("Transaction committed!");
  }
  ```

  </div>

  </div>

## @AfterThrowing

- After Throwing Advice를 나타내며, 비즈니스 메소드가 실패하였을 때만 실행됨

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @AfterThrowing("p1()")
  public void rollbackTransaction(){
    System.out.println("Transaction rolled back!!");
  }
  ```

  </div>

  </div>

## @Around

- Around Adve를 나타내며 두 부분으로 실행됨

- 비즈니스 실행 전에 실행 및 비즈니스 실행 후에 실행됨

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Around("p1()")
  public void testAroundAdvice(ProceedingJoinPoint pj) throws Throwable {
    System.out.println("executing Before part of business method");
    pj.proceed(); // the code will call business method
    System.out.println("Executing After part of business method");
  }
  ```

  </div>

  </div>

# Pointcut 표현식 예제

- \*, .의 두 기호만 허용

- 다양한 조합을 구성하여 사용

- Pointcut 표현식 구문 예는 ReturnType Packege.ClassName,MethodName(ParameterTypes)

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  () // 파라미터가 없는 경우
  (..) //  모든 수, 또는 유형의 매개변수

  public Integer com.dev.dao.InvoiceDao.saveInvoice(Invoice) 
  => InvoiceDao 클래스 안의 Invoce 유형의 파라미터를 가진 saveInvoice() 메소드 

  public Integer com.dev.dao.InvoiceDao.saveInvoice()
  ==> InvoiceDao 클래스 안의 파라미터가 없는 saveIvoice() 메소드 

  public Integer com.dev.dao.InvoiceDao.*()
  ==> InoiceDao 클래스 안의 Integer를 반환하는 모든 메소드

  public * com.dev.dao.InvoiceDao.*()
  => InvoiceDao 클래스 안에 있는 모든 메소드

  public * com.dev.dao.InvoiceDao.*(..)
  => InvoiceDao 클래스 안에 파라미터가 없거나 있는 모든 메소드

  public * com.dev.dao.*.*(..)
  ==> com.dev.dao 패키지 안에 있는 모든 클래스의 모든 메소드
  ```

  </div>

  </div>

# pointcut 표현식을 복습하기 위한 연습

- com.dev.invoice.controller의 패키지 아래에 4개의 메소드가 존재한다고 가정

  - public Integer saveInvoice(Invoice inv){…}

  - public void deleteInvoice(Integer id){…}

  - public void updateInvoice(Invoice inv){…}

  - public Invoice getInvoice(Integer id){…}

- public \* \*() 표현식에 맞는 메소드는? 파라미터가 없는 메소드가 없으므로 없음

- public void \*(..) 표현식에 맞는 메소드는? deleteInvoice() 와 updateInvoice()

- public \* \*(Invoice) 표현식에 맞는 메소드는 ? saveInvoice() 와 getInvoice()가 해당됨

# Spring Boot 애플리케이션에서 AOP 구현

## 단계1. AOP 연습 프로젝트 생성

- Spring Boot Starter Porject 생성

- dependency spring-boot-starter-aop

## 단계2. SpringBootApplication 에 @EnableAspectJAutoProxy 정의

- Spring Boot main 클래스에 @EnableAspectJAutoProxy 정의(SpringBoot2AopApplication.java)

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.spring.aop;

  import org.springframework.boot.SpringApplication;
  import org.springframework.boot.autoconfigure.SpringBootApplication;
  import org.springframework.context.annotation.EnableAspectJAutoProxy;

  @SpringBootApplication
  @EnableAspectJAutoProxy
  public class SpringBoot2AopApplication {

      public static void main(String[] args) {
          SpringApplication.run(SpringBoot2AopApplication.class, args);
      }
  }
  ```

  </div>

  </div>

## 단계3. 비즈니스 서비스 클래스 구현

- InvoiceBusiness 클래스 구현. (InvoiceBusinessService.java)

- 클래스의 메소드는 advice 정의(InvoiceBusinessService.java)

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.spring.aop.service;

  import java.util.Random;

  import org.springframework.stereotype.Component;


  @Component
  public class InvoiceBusinessService {

      public void saveInvoice() {
          System.out.println("From saveInvoice()");
          if(new Random().nextInt(15)<=10) {
              throw new RuntimeException("Exception occured");
          }
      }
      
      public String helloInvoice() {
          return "FROM helloInvoice()";
      }
      
      public void testMethodforAroundAdvice() {
          System.out.println("Business Method is getting Executed !");
      }
      
  }
  ```

  </div>

  </div>

## 단계4. 비즈니스 메소더를 호출 및 실행할 runner 클래스 생성

- advice가 어떻게 작동되는지 테스트하기 위해 비즈니스 메소드를 호출하는 runner 클래스 생성(InvoiceRunner.java)

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.spring.aop;

  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.boot.CommandLineRunner;
  import org.springframework.stereotype.Component;

  import com.dev.spring.aop.service.InvoiceBusinessService;

  @Component
  public class InvoiceRunner implements CommandLineRunner {

      @Autowired
      private InvoiceBusinessService service;
      
      @Override
      public void run(String... args) throws Exception {
          
          service.helloInvoice();
          service.testMethodforAroundAdvice();
          service.saveInvoice();
          
      }

  }
  ```

  </div>

  </div>

## 단계5. Aspect 클래스와 메소드 구현

- InvoiceAspect.java 클래스 및 메소드 구현(InvoiceAspect.java)

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.spring.aop.aspect;

  import org.aspectj.lang.ProceedingJoinPoint;
  import org.aspectj.lang.annotation.After;
  import org.aspectj.lang.annotation.AfterReturning;
  import org.aspectj.lang.annotation.AfterThrowing;
  import org.aspectj.lang.annotation.Around;
  import org.aspectj.lang.annotation.Aspect;
  import org.aspectj.lang.annotation.Before;
  import org.aspectj.lang.annotation.Pointcut;
  import org.springframework.stereotype.Component;

  @Aspect
  @Component
  public class InvoiceAspect {
      
      @Pointcut("execution(public void com.dev.spring.aop.service.InvoiceBusinessService.saveInvoice())")
      public void p1() {
          
      }
      
      @Pointcut("execution(public String com.dev.spring.aop.service.InvoiceBusinessService.helloInvoice())")
      public void p2() {
          
      }
      
      
      @Pointcut("execution(* com.dev.spring.aop.service.InvoiceBusinessService.testMethodforAroundAdvice())")
      public void p4() {
          
      }

      @Before("p1()")
      public void beginTransaction() {
          System.out.println("Transaction begins !");
      }
      
      @After("p1()")
      public void completeTransaction() {
          System.out.println("Transaction completes !");
      }
      
      @AfterReturning("p1()")
      public void commitTransaction() {
          System.out.println("Transaction committed !");
      }
      
      @AfterThrowing("p1()")
      public void rollbackTransaction() {
          System.out.println("Transaction rolled back !");
      }
      
      @AfterReturning(value="p2()", returning = "obj")
      public void getAdviceReturnValue(Object obj) {
          System.out.println("Returning Value is : "+obj);
      }
      
      @AfterThrowing(value="p1()", throwing = "th")
      public void rollbackTransactionGetMessage(Throwable th) {
          System.out.println("Transaction rolled back ! Message from method : "+th);
      }
      
      
      @Around("p4()")
      public void testAroundAdvice(ProceedingJoinPoint pj) throws Throwable {
          
          System.out.println("Executing Before part of business method");
          
          pj.proceed();  // this code will call business method
          
          System.out.println("Executing After part of business method");
      }
  }
  ```

  </div>

  </div>

## 단계6. AOP Concepts 테스팅

- Spring Boot Application 실행

# Pointcut 표현식은 특정 annotation이 있는 메소드를 선택 방법

- Pointcut은 특정 annotation이 있는 비즈니스 메소드를 선택할 수도 있음

- 하나의 annotation을 정의하고 이를 비즈니스 메소드에 정의

- advice를 적용하기 위해 해당 메소드를 선택하는 pointcut 표현식을 작성

- annotation이 달린 비즈니스 메소드와 연결하기 위한 join 생성

- Runner 클래스에서 이 비즈니스 메소드를 호출

## 단계1. annotation 정의

- TestAnnotation.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.spring.aop.annotation;

  import java.lang.annotation.ElementType;
  import java.lang.annotation.Retention;
  import java.lang.annotation.RetentionPolicy;
  import java.lang.annotation.Target;

  @Target(ElementType.METHOD)
  @Retention(RetentionPolicy.RUNTIME)
  public @interface TestAnnotation {

  }
  ```

  </div>

  </div>

## 단계2. annotation을 정의한 비즈니스 메소드 구현

- testMethodWithAnnotation()

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @TestAnnotation
  public void testMethodWithAnnotation() {
      System.out.println("FROM testMethodWithAnnotation()");
  }
  ```

  </div>

  </div>

## 단계3. pointcut과 advice 구현

- Pointcut & Advice

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Pointcut("@annotation(com.dev.spring.aop.annotation.TestAnnotation)")
  public void p3() {
          
  }

  @Before("p3()")
  public void testAnnotatedMethod() {
      System.out.println(" From testAnnotatedMethod()");
  }
  ```

  </div>

  </div>

## 단계4. Runner 클래스 정의

- InvoiceRunner.java

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Component
  public class InvoiceRunner implements CommandLineRunner {

      @Autowired
      private InvoiceBusinessService service;
      
      @Override
      public void run(String... args) throws Exception {
          
          service.testMethodWithAnnotation();
          
      }

  }
  ```

  </div>

  </div>

## 단계5. Annotated method에 Advice 테스팅

- Spring Boot Applicatoin 실행

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
