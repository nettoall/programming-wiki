<div id="page">

<div id="main" class="aui-page-panel">

<div id="main-header">

<div id="breadcrumb-section">

1.  [Programming](README.md)
2.  [Programming](Programming_98307.md)
3.  [Spring](Spring_120848385.md)
4.  [Spring Boot](Spring-Boot_223477765.md)
5.  [Spring Boot Caching](Spring-Boot-Caching_393740291.md)

</div>

# <span id="title-text"> Programming : Spring Boot with Redis </span>

</div>

<div id="content" class="view">

<div class="page-metadata">

Created by <span class="author"> Dongwook Han</span>, last modified on 4월 28, 2023

</div>

<div id="main-content" class="wiki-content group">

<style>[data-colorid=ni8qmcq1vj]{color:#bf2600} html[data-color-mode=dark] [data-colorid=ni8qmcq1vj]{color:#ff6640}[data-colorid=upw5h6t031]{color:#bf2600} html[data-color-mode=dark] [data-colorid=upw5h6t031]{color:#ff6640}</style>자주, 애플리케이션이 예상했던 만큼 제대로 작동하지 않는 단계에 도달합니다. 다른 여러 솔루션 외에도 DB 호출을 더 빠르게 만드는 캐싱 기술도 찾는다. 이를 가능하게 하기 위해 Redis Cache 기술을 도입했습니다. Redis 캐시는 DB에서 데이터에 액세스하는 동안 네트워크 호출 수를 최소화하여 도움을 줍니다. 말할 필요도 없이 이 기사의 주제는 '스프링 부트 애플리케이션에서 Redis Cache를 구현하는 방법'입니다.

Spring Boot는 'Spring Data Redis' dependency를 통해 이 기능을 지원합니다. 또한 Spring Boot 애플리케이션에서 Redis Cache가 작동하도록 하려면 Redis 서버를 다운로드해야 합니다. 또한 Cache 외에도 Redis는 데이터베이스 및 Message Broker로도 사용할 수 있습니다. 그러나 실시간 애플리케이션에서 Redis는 데이터베이스 및 메시지 브로커에 비해 캐시 관리자로 널리 사용됩니다. '스프링 부트 애플리케이션에서 Redis 캐시를 구현하는 방법' 기사와 관련 개념에 대해 논의를 시작하겠습니다

## 이 장에서 기대하는 것들

Once you go through the complete article, you will be able to answer the following questions:

1.  Redis란?

2.  Redis 는 무엇을 위해 사용되는가?

3.  Redis Cache란?

4.  애플리케이션에서 Redic Cache를 사용하는 이점

5.  애플리케이션에서 Redis Cahce는 어떻게 동작하는지?

6.  Redis Database란?

7.  Redis Server란?

8.  Redis Server 다운받기

9.  애플리케이션에서 Redis Cache를 활성화시키는 중요한 annotation?

10. 언제 @Cachinng annotation을 사용하는지

11. annotation을 사용하여 조건부 caching을 구현하는 방법

12. Spring Boot 에서 REST 애플리케이션을 구현하는 방법

13. Spring Boot 애플리케이션에서 Redis Cache를 구현하는 방법

14. Redis Cache를 구현한 후에 애플리케이션 테스트 하기

15. 마지막으로 Redis CLI와 사용하는 방법

## Redis란

Redis는 고성능, 복제 및 고유한 데이터 모델을 제공하는 오픈 소스(BSD 라이선스) 메모리 내 원격 데이터 구조 저장소(데이터베이스)입니다. Redis의 완전한 형태는 원격 디렉토리 서버입니다. 또한 여러 형태로 사용할 수 있습니다. Redis는 문자열, 해시, 목록, 세트, ​​범위 쿼리가 있는 정렬된 세트, 비트맵, 하이퍼로그 로그, 지리 공간 인덱스 및 스트림과 같은 **데이터 구조를 제공**합니다.

대부분의 프로그래밍 언어에서 Redis를 사용할 수 있습니다. Redis는 ANSI C로 작성되었으며 외부 종속성 없이 Linux, \*BSD, OS X와 ​​같은 대부분의 POSIX 시스템에서 작동합니다. Linux와 OS X는 Redis가 가장 많이 개발되고 테스트되는 두 운영 체제입니다.

## 무엇을 위해 Redis가 사용되는지?

- 다음과 같은 형태로 Redis를 사용

  1.  **In-Momory Database** : In-Memory 데이터베이스로서 데이터 베이스 작업을 수행하기 위해 일부 빈 메모리를 확보한다. 또한 No-SQL 데이터 베이스 처럼 수행되면 테이블, 시퀀스, join 개념이 없다. 데이터를 String, Hash 명령\*\*\*, List, Set 등의 형태로 저장할 수 있다. In-Built (내장) 서비스를 사용할 수 있음

  2.  **Cache** : 애플리케이션 성능을 증가시기키 위해 Redis를 Cache로 사용

  3.  **Message Broker(MQ)** : 또 다른 Redis의 사용은 Message Broker로 사용. 실시간 애플리케이션에서 Redis는 데이터베이스 및 메시지 브로커에 비해 Cache 관리자로 유명함. Cache 관리자로서 네트워크 호출을 줄이고 애플리케이션의 성능을 향상시킨다.

## Redis Cache란?

Redis Cache를 Redis에서 제공하는 캐시 관리 기능에 불과. Redis는 일반적으로 애플리케이션의 더 나은 성능을 느낄 수 있도록 반복적으로 엑세스 하는 데이터를 메모리에 저장하는 캐시로 사용된다. Redis Cache는 데이터를 보관할 기간, 먼저 제거할 데이터, 다른 bright caching models 과 같은 다양한 기능을 제공

## Redis Cache의 장점

다른 모든 캐싱 기술과 마찬가지로 Redis Cache는 애플리케이션의 네트워크 호출 수를 최소화하여 애플리케이션 전체의 성능을 향상시킵니다. 애플리케이션에서 DB로의 요청 하나는 하나의 네트워크 호출과 유사합니다. 데이터베이스가 더 많은 호출을 처리하는 것처럼 애플리케이션에 캐싱 메커니즘을 적용함으로 더 나은 확장성을 달성할 수 있다.

- In-memory data store

- 유연한 데이터 구조 : Strings, Lists, Sets, Sorted Sets, Hashes, Bitmaps, HyperLoglogs

- 간단하고 사용하기 쉬움

- 고가용성 및 확장성

- 복제하거나 유지하기 쉬웁

- 높은 확장성

## 애플리케이션에서 Redis Cache가 동작하는 방법

애플리케이션을 통해 DB 검색 작업을 수행하면 Redis Cache는 결과를 캐시에 저장합니다.

또한 동일한 검색 작업을 수행하면 캐시 자체에서 결과를 반환하고 데이터베이스에 대한 두 번째 호출을 무시합니다.

마찬가지로 DB 업데이트 작업을 수행하면 Redis Cache도 해당 캐시의 결과를 업데이트했습니다. 말할 필요도 없이 삭제 작업을 위해 그에 따라 캐시에서 데이터를 삭제했습니다. 이렇게 하면 잘못된 데이터를 얻을 가능성이 없습니다.

## Redis Database란?

Redis 데이터베이스는 디스크에 지속되는 메모리 데이터베이스입니다. Redis Database를 사용할 때 데이터베이스로 사용하기 위해 디스크의 메모리를 점유한다는 의미입니다. 데이터 모델은 키-값이지만 문자열, 목록, 집합, 정렬된 집합, 해시, 스트림, HyperLogLog, 비트맵 등과 같은 여러 종류의 값을 지원합니다.

## Redis Server란?

Redis의 완전한 형태는 **RE**mote **DI**ctionary **S**erver입니다. 데이터베이스, 캐시, Message Broker 등 어떤 형태로든 Redis를 사용하려면 시스템에 Redis 서버를 다운로드해야 합니다. 업계 사람들은 그냥 Redis 서버라고 부릅니다.

## How to download Redis Server?

1.  Redis를 Windows에 다운로드하려면 아래 링크 중 하나를 방문

    - <a href="https://github.com/microsoftarchive/redis/releases/tag/win-3.2.100" class="external-link" rel="nofollow">Download Redis Server</a>  :  version 3.2.100

    - <a href="https://github.com/tporadowski/redis/releases" class="external-link" rel="nofollow">Download Redis Server</a>  :  version 5.0.10

2.  Redis-x64-5.0.10.zip을 클릭하고 폴더에 압축을 풉니다

3.  Redis-x64-5.0.10' 폴더 아래에 redis-server.exe가 있습니다.

4.  Redis 서버를 시작하려면 '**redis-server.exe'를 두 번 클릭**하여 Redis 서버를 시작합니다.

## 애플리케이션에서 Redis Cache 를 활성하기 위한 중요한 Annotation

일반적으로 애플리케이션에서 Redis Cache 기능을 구현하기 위해 적용하는 네 가지 중요한 주석이 있습니다. 그것들은 아래와 같습니다:

### @EnableCaching 

애플리케이션에 캐싱 기능이 필요하다는 것을 Spring Container에 알리기 위해 애플리케이션의 Main 클래스(스타터 클래스)에 이 annotation을 적용합니다.

### @Cacheable 

@Cacheable은 **DB에서 데이터를 가져오고(검색) Redis Cache에 저장하는 데 사용**됩니다. DB에서 데이터를 **가져오는(검색하는) 메소드에 적용**합니다. @Cacheable은 캐시에 데이터를 추가하거나 업데이트하는 메서드의 반환 값이 필요합니다.

@Cacheable 주석은 속성을 사용할 수 있도록 합니다. 예를 들어 값 또는 cacheNames 특성을 사용하여 캐시 이름을 제공할 수 있습니다. 캐시의 각 항목을 고유하게 식별하는 주석의 키 속성을 정의할 수도 있습니다. 키를 지정하지 않으면 Spring은 기본 메커니즘을 사용하여 키를 생성합니다. 또한 condition 속성을 사용하여 주석에 조건을 적용할 수도 있습니다.

### @CachePut 

**DB에 데이터 업데이트가 있을 때** Redis Cache의 데이터를 업데이트하기 위해 @CachePut을 사용합니다. DB에서 수정하는 메소드에 적용합니다.

### @CacheEvict 

우리는 @CacheEvict를 사용하여 **DB에서 데이터를 제거**하는 동안 Redis Cache에서 데이터를 제거합니다. DB에서 데이터를 삭제하는 메소드에 적용합니다. void 메서드와 함께 사용할 수 있습니다.

## Spring Boot 애플리케이션에서 Redis Cacche를 구현하는 방법

Spring Boot를 사용하여 Redis Cache를 구현하려면 CRUD 작업을 수행할 하나의 작은 애플리케이션을 생성해야 합니다. 그런 다음 검색, 업데이트 및 삭제 작업에 Redis Cache 기능을 적용합니다. 그러나 생성 작업에 캐시 기능을 적용하면 아무런 이점이 없으므로 적용하지 않아야 합니다. 'Spring Boot에서 Redis Cache를 구현하는 방법' 작업을 아래와 같이 단계별로 시작하겠습니다.

# 사용 사례 세부 정보

REST를 사용하여 CRUD 애플리케이션을 생성합니다. 여기에서 엔터티 클래스가 Invoice.java라고 가정합니다. 완전한 REST 애플리케이션을 생성하기 위해 업계 모범 사례에 따라 컨트롤러, 서비스 및 리포지토리 계층을 갖게 됩니다. 인보이스 REST 애플리케이션 개발을 완료하면 Redis Cache의 이점을 얻기 위해 특정 메소드에 주석을 추가로 적용할 것입니다. 이것은 애플리케이션에서 Redis Cache를 구현하는 단계별 접근 방식입니다. 그러나 각 파일의 전체 코드를 제공할 예정입니다.

## 단계1. Spring Boot project 생성

- Dependency : Spring Web

- Spring Data JPA

- MySQL Driver

- Spring Data Redis

- Lombok

- Spring Boot DevTools

## 단계2. application.properties 수정

- 다음과 같이 application.properties 수정

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/testdb
spring.datasource.username=admin
spring.datasource.password=admin123

spring.jpa.database-platform=org.hibernate.dialect.MySQL8Dialect
spring.jpa.show-sql=true
spring.jpa.hibernate.ddl-auto=update

spring.cache.type=redis
spring.cache.redis.cache-null-values=true
#spring.cache.redis.time-to-live=40000
```

</div>

</div>

- application.yml

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  spring:
    datasource:
      driver-class-name: com.mysql.cj.jdbc.Driver
      url: jdbc:mysql://localhost:3306/testdb
      username: admin
      password: admin123
    jpa:
      database-platform: org.hibernate.dialect.MySQL8Dialect
      show-sql: true
      hibernate:
        ddl-auto: update
    cache:
      type: redis
      redis:
        cache-null-values: true
    mvc:
      pathmatch:
        matching-strategy: ant_path_matcher
  ```

  </div>

  </div>

## 단계3. Starter 클래스에 @EnableCaching annotation 추가

- @EnableCaching 은 Caching 기능의 이점을 얻기 위해 필요

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication
@EnableCaching
public class RedisAsaCacheWithSpringBootApplication {

   public static void main(String[] args) {
      SpringApplication.run(RedisAsaCacheWithSpringBootApplication.class, args);
   }
}
```

</div>

</div>

## 단계4. Invoice.java Entity 클래스 생성

- Lombok annotation을 가진 entity 클래스를 생성. 추가적으로 하나의 SerialVersionUID를 생성한다.

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Invoice implements Serializable{

    private static final long serialVersionUID = -4439114469417994311L;

    @Id
    @GeneratedValue
    private Integer invId;
    private String invName;
    private Double invAmount;
}
```

</div>

</div>

## 단계5. InvoiceRepository.java Repository interface 생성

- JpaRepository\<Invoice, Interger\>를 상속받아 구현한 InvoiceRepository.java interface 구현

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.dev.springboot.redis.model.Invoice;

@Repository
public interface InvoiceRepository extends JpaRepository<Invoice, Integer> {

}
```

</div>

</div>

## 단계6. 사용자 정의 예외처리 InvoiceNotFoundException.java 구현

- Exception을 처리하는 클래스 구현

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class InvoiceNotFoundException extends RuntimeException {

   private static final long serialVersionUID = 7428051251365675318L;

   public InvoiceNotFoundException(String message) {
      super(message);
   }
}
```

</div>

</div>

## 단계7&8. InvoiceService, InvoiceServiceImpl.java 구현

- service 계층을 구현하기 위해 service interface와 구현 클래스를 구현.

**Service Interface:**

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
import com.dev.springboot.redis.model.Invoice;
import java.util.List;

public interface InvoiceService {

    public Invoice saveInvoice(Invoice inv);
    public Invoice updateInvoice(Invoice inv, Integer invId);
    public void deleteInvoice(Integer invId);
    public Invoice getOneInvoice(Integer invId);
    public List<Invoice> getAllInvoices();
}
```

</div>

</div>

**Service Implementation Class:**

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.dev.springboot.redis.exception.InvoiceNotFoundException;
import com.dev.springboot.redis.model.Invoice;
import com.dev.springboot.redis.repo.InvoiceRepository;

@Service
public class InvoiceServiceImpl implements InvoiceService {

    @Autowired
    private InvoiceRepository invoiceRepo;

    @Override
    public Invoice saveInvoice(Invoice inv) {

        return invoiceRepo.save(inv);
    }

    @Override
    @CachePut(value="Invoice", key="#invId")
    public Invoice updateInvoice(Invoice inv, Integer invId) {
       Invoice invoice = invoiceRepo.findById(invId)
            .orElseThrow(() -> new InvoiceNotFoundException("Invoice Not Found"));
       invoice.setInvAmount(inv.getInvAmount());
       invoice.setInvName(inv.getInvName());
       return invoiceRepo.save(invoice);
    }

    @Override
    @CacheEvict(value="Invoice", key="#invId")
    // @CacheEvict(value="Invoice", allEntries=true) //in case there are multiple records to delete
    public void deleteInvoice(Integer invId) {
       Invoice invoice = invoiceRepo.findById(invId)
           .orElseThrow(() -> new InvoiceNotFoundException("Invoice Not Found"));
       invoiceRepo.delete(invoice);
    }

    @Override
    @Cacheable(value="Invoice", key="#invId")
    public Invoice getOneInvoice(Integer invId) {
       Invoice invoice = invoiceRepo.findById(invId)
         .orElseThrow(() -> new InvoiceNotFoundException("Invoice Not Found"));
       return invoice;
    }

    @Override
    @Cacheable(value="Invoice")
    public List<Invoice> getAllInvoices() {
       return invoiceRepo.findAll();
    }
}
```

</div>

</div>

## 단계9. RestController 클래스 구현

- REST 호출과 결과를 가져오는 RestController 구현

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.dev.springboot.redis.model.Invoice;
import com.dev.springboot.redis.service.InvoiceService;

@RestController
@RequestMapping("/invoice")
public class InvoiceController {

    @Autowired
    InvoiceService invoiceService;

    @PostMapping("/saveInv")
    public Invoice saveInvoice(@RequestBody Invoice inv) {
       return invoiceService.saveInvoice(inv);
    }

    @GetMapping("/allInv") 
    public ResponseEntity<List<Invoice>> getAllInvoices(){
       return ResponseEntity.ok(invoiceService.getAllInvoices());
    }

    @GetMapping("/getOne/{id}")
    public Invoice getOneInvoice(@PathVariable Integer id) {
       return invoiceService.getOneInvoice(id);
    }

    @PutMapping("/modify/{id}")
    public Invoice updateInvoice(@RequestBody Invoice inv, @PathVariable Integer id) {
       return invoiceService.updateInvoice(inv, id);
    }

    @DeleteMapping("/delete/{id}")
    public String deleteInvoice(@PathVariable Integer id) {
       invoiceService.deleteInvoice(id);
       return "Employee with id: "+id+ " Deleted !";
    }
}
```

</div>

</div>

## RedisCache 테스트하기

1.  Redis Server 시작

2.  Spring Boot 애플리케이션 시작

3.  REST Client를 사용하여 Rest Call 호출. RestTemplate 나 Postman 을 사용하여 테스트

4.  swagger-ui 를 테스트 중 . **<span colorid="ni8qmcq1vj">allInv 에서 모두 데이터를 가져오지 못하고 있음 </span>**

# Caching annotation을 언제 사용하는지

- 특정 메서드에 여러 caching annotation을 적용하고 싶다고 가정.

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
@CacheEvict("Invoice") 
@CacheEvict(value="Invoice", key="#invId")
public void deleteInvoice(Integer invId) {
    ....
}
```

</div>

</div>

- Java는 주어진 메서드에 대해 동일한 유형의 여러 annotation을 정의하는 것을 허용하지 않기 때문에 **<span colorid="upw5h6t031">컴파일 오류 발생</span>** (@CacheEvict("Invoice") , @CacheEvict(value="Invoice, key=”#invld”) )

- 이 경우에는 @Caching annotation을 사용해야 함

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
@Caching(
  evict = {@CacheEvict("Invoice"), @CacheEvict(value="Invoice", key="#invId")
}) 
public void deleteInvoice(Integer invId) {
     ....
}
```

</div>

</div>

- 마찬가지로 다른 유형의 annotation이 있는 경우, 가독성을 높이기 위해 @Caching annotation을 사용하여 그룹화 할 수 있음(@CacheEvict(…), @CachePut(value=...))

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
@CacheEvict(value = "usersList", allEntries = true)
@CachePut(value = "user", key = "#user.getUserId()")
public User updateUser(User user) {
    ....
}
```

</div>

</div>

- 다른 유형의 여러 Caching annotation을 다음과 같이 그룹화

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
@Caching(
   evict = {@CacheEvict(value = "usersList", allEntries = true)},
   put   = {@CachePut(value = "user", key = "#user.getUserId()")}
) 
public User updateUser(User user) {
   ....
}
```

</div>

</div>

## How to Implement Conditional **Caching using Annotations?**

If we have some requirement when we need to cache data only on a particular condition, we can parameterize our annotation with two parameters: ‘condition’ and ‘unless’. They accept a <a href="https://docs.spring.io/spring-framework/docs/4.3.10.RELEASE/spring-framework-reference/html/expressions.md" class="external-link" rel="nofollow">SpEL expression</a> and ensures that the results are cached based on evaluating that expression. This kind of conditional caching can be useful for managing large amount of results. For example, let’s observe one example from each parameter.

Below Example demonstrates the concept of ‘condition’ parameter.

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
@CachePut(value="invoices", condition="#invoice.amount>=2496") 
public String getInvoice(Invoice invoice) {
    ...
}
```

</div>

</div>

Now, let’s see the concept of ‘unless’ parameter from the example below:

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
@CachePut(value="invoices", unless="#result.length()<24") 
public String getInvoice(Invoice invoice) {
    ...
}
```

</div>

</div>

- ‘condition' 과 ‘unless’ 매배견수는 모든 caching annotaton과 사용할 수 있음

# Redis CLI 사용하는 법

- Redis CLI를 사용하는 법

  1.  Redis Service 설치 경로로 이동 ('Redis-x64-5.0.10' 으로 이동)

  2.  'Redis-x64-5.0.10' 폴더에서 redis-cli.exe 확인

  3.  redis-cli.exe 실행

  4.  새로운 windows 창이 ‘127.0.0.1:6379\>’ 메시지와 함께 열림

  5.  명령어 입력하여 결과 확인

# Redis CLI 명령어

1.  모든 key 정보 가져오기 : **KEYS \***

2.  간단한 key value pair 설정 : **SET mykey “Hello\nWorld”**

3.  value 가져오기 : **GET mykey**

4.  모든 DB에서 모든 key 제거 : **FLUSHALL**

5.  DB \# 4의 모든 key 제거 : **-n 4 FLUSHDB**

Redis CLI 명령어 참고 : <a href="https://redis.io/docs/manual/cli/" class="external-link" rel="nofollow">Redis CLI manual</a>.

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
