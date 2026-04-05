<div id="page">

<div id="main" class="aui-page-panel">

<div id="main-header">

<div id="breadcrumb-section">

1.  [Programming](README.md)
2.  [Programming](Programming_98307.md)
3.  [Spring](Spring_120848385.md)
4.  [Spring Boot](Spring-Boot_223477765.md)

</div>

# <span id="title-text"> Programming : Spring Boot Caching </span>

</div>

<div id="content" class="view">

<div class="page-metadata">

Created by <span class="author"> Dongwook Han</span>, last modified on 5월 01, 2023

</div>

<div id="main-content" class="wiki-content group">

# 정의

- `캐싱은 애플리케이션 성능을 향상시키는 방법입니다. 애플리케이션과 영구 데이터베이스 사이에 있는 일종의 임시 메모리입니다. 캐시 메모리 저장소는 데이터베이스 호출을 가능한 한 최소화하기 위해 이전에 데이터 항목을 사용했습니다.`

- `스프링 캐싱은 부하를 줄이고 애플리케이션 성능을 향상시키는 이점이 있습니다.`

## 장점

- `응용 프로그램에서 일반적으로 재사용되는 데이터의 캐싱은 응용 프로그램 속도를 향상시키는 데 유용한 기술입니다. 사용자가 데이터를 원할 때마다 비용이 많이 드는 백엔드를 호출하지 않도록 자주 요청되는 데이터를 메모리에 캐시합니다. 메모리에서의 데이터 액세스는 실제로 데이터베이스, 파일 시스템 또는 기타 서비스 호출과 같은 스토리지에서의 데이터 액세스보다 빠릅니다.`

## 캐쉬와 버퍼의 차이점

<div class="table-wrap">

|  |  |
|----|----|
| **Cache** | **Buffer** |
| `가장 최근에 사용된 기술을 사용합니다.` | `First-In-First-Out 기법을 사용합니다.` |
| `그것에는 긴 수명이 있습니다.` | `수명이 짧습니다.` |
| `페이지 캐시의 크기를 나타냅니다.` | `메모리 내 원시 블록 I/O 버퍼를 참조합니다.` |
| `캐시에서 읽습니다.` | `버퍼에 씁니다.` |
| `읽기 성능을 향상시킵니다.` | `쓰기 성능을 향상시킵니다.` |

</div>

## Spring Boot 사용 가능한 캐쉬

- JCache (JSR-107) (EhCache 3, Hazelcast, Infinispan, and others)

- EhCache 2.x

- Hazelcast

- Infinispan

- Couchbase

- Redis

- Caffeine

- Simple Cache

`캐싱 기능은 @EnableCaching을 사용하여 스프링 부트 애플리케이션에서 활성화됩니다.`

# 캐싱 정의

### @EnableCaching 

애플리케이션에 캐싱 기능이 필요하다는 것을 Spring Container에 알리기 위해 애플리케이션의 Main 클래스(스타터 클래스)에 이 annotation을 적용합니다.

`캐싱을 활성화하고 생성된 CacheManager 인스턴스가 없는 경우 생성합니다. 특정 제공자를 검색하고, 찾지 못한 경우 동시 HashMap을 사용하여 메모리 내 캐시를 설정합니다.`

### @Cacheable 

`메소드 레벨 어노테이션입니다. 메서드의 반환 값에 대한 캐시를 지정합니다. @Cacheable 주석은 결과를 캐시에 저장하는 작업을 처리합니다.`

### @CachePut 

`메소드 레벨 어노테이션입니다. 메서드 실행을 방해하지 않고 캐시를 업데이트하는 데 사용됩니다.`

`@Cacheable 및 @CachePut 어노테이션의 차이는 @Cacheable 어노테이션이 메서드 실행을 skip 하는 반면 @CachePut 어노테이션은 메서드를 실행하고 결과를 캐시한다는 점`

### @CacheEvict 

`메소드 레벨 어노테이션입니다. CacheEvict는 캐시에서 부실하거나 사용하지 않는 데이터를 삭제하는 데 사용됩니다.`

## @Caching

`메서드 수준 주석이며 여러 캐시 작업을 다시 그룹화해야 할 때 사용됩니다.`

## @CacheConfig

`클래스 수준 주석입니다. 전체 클래스에 대한 캐시를 저장하도록 Spring을 지정합니다.`

# 예제

## gradle 정의

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-cache'
    implementation 'org.springframework.boot:spring-boot-starter-web'
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
```

</div>

</div>

## 샘플 코드

- @EnableCaching : Spring Boot Application 에 정의

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @SpringBootApplication
  @EnableCaching
  public class CacheApplication {

      public static void main(String[] args) {
          SpringApplication.run(CacheApplication.class, args);
      }

  }
  ```

  </div>

  </div>

- @Cacheable

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Component
  public class EmployeeServiceImpl implements EmployeeService{
      private static final Logger LOGGER = LoggerFactory.getLogger(EmployeeServiceImpl.class);
      private List<Employee> employees = new ArrayList<>();
      
      @Override
      public List<Employee> getEmployees() {
          retrieveDataFromDatabase();
          LOGGER.info("---Getting employee data from database.----");
          return employees;
      }

      @Override
      @CustomEmployeeCachingAnnotation
      public Employee getEmployeeById(Integer employeeId) {
          retrieveDataFromDatabase();
          LOGGER.info("----Getting employee data from database----");
          return employees.get(employeeId);
      }

      private void createEmployeesData(List<Employee> employees) {
          employees.add(Employee.builder().id(1).name("User1").role("Admin").build());
          employees.add(Employee.builder().id(2).name("User2").role("User").build());
          employees.add(Employee.builder().id(3).name("User3").role("Supervisor").build());
      }

      private void retrieveDataFromDatabase(){
          try {
              createEmployeesData(employees);
              LOGGER.info("----Sleep for 4 Secs.. to mimic like it's a backend call----");
              Thread.sleep(1000*4);
          } catch(InterruptedException e){
              e.printStackTrace();
          }
      }
  }
  ```

  </div>

  </div>

  - `이 예에서 우리의 주요 목표는 실제 백엔드 서비스 호출을 복제하기 위해 응답을 의도적으로 지연시키는 서비스 계층의 데이터를 캐시하는 것입니다. 프로그램에서 시뮬레이션된 대기로 인해 첫 번째 히트에서 응답이 지연되지만 후속 호출은 훨씬 더 빠른 응답을 받습니다.`

  - `첫 번째 호출에서 Employee 값은 데이터베이스에서 검색되고 반환된 값은 캐시에 저장됩니다.`

- CustomConfig

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Retention(RetentionPolicy.RUNTIME)
  @Target(ElementType.METHOD)
  @Cacheable(cacheNames = "employee")
  public @interface CustomEmployeeCachingAnnotation {
  }
  ```

  </div>

  </div>

- @CachePut

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @CachePut(cacheNames="employee", key="#id") //updating cache  
  public Employee updateEmployee(int id, Employee employeeData)
  {
  //some code  
  }  
  ```

  </div>

  </div>

- @CacheEvict

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  //removing all entries of employee from the cache  
  @CacheEvict(value="employee", allEntries=true)
  public String getEmployee(int id)
  {
  //some code  
  } 

  @CacheEvict(key="#employee.name") 
  ```

  </div>

  </div>

- @Caching

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @CacheEvict("employees")
  @CacheEvict(value="item", key="#key")
  public List<Employee> getEmployees()() {...}
  ```

  </div>

  </div>

  - `메서드 수준 주석이며 여러 캐시 작업을 다시 그룹화해야 할 때 사용됩니다.`

  - `위 작업은 @Caching 주석을 사용하여 함께 넣을 수 있습니다. @Caching 주석은 여러 사용 사례를 함께 처리하는 솔루션을 제공합니다.`

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    @Caching(evict = { @CacheEvict("employees"),
    @CacheEvict(cacheNames="item", key="#key") })
    public List<Employee> getEmployees()() {...}
    ```

    </div>

    </div>

- @CacheConfig

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @CacheConfig(cacheNames={"employee"})
  public class EmployeeService
  {
  //some code  
  }  
  ```

  </div>

  </div>

  - `클래스 수준 주석입니다. 전체 클래스에 대한 캐시를 저장하도록 Spring을 지정합니다.`

# 테스트

- <a href="http://localhost:8080/get/employees" class="external-link" rel="nofollow">http://localhost:8080/get/employees</a> 로 테스트

- 일부러 createdata 로직에 4초간 sleep 하도록 하였는데, 두번째부터는 데이터가 아닌 cache에서 가져오게 되므로 지연 현상이 없음

- ServiceImpl의 List\<Employee\> getEmployees() 에 @Cacheable 어노테이션을 정의 안 하니 게속 데이터를 가져오면서 4초간 sleep 함 → @Cacheable 추가 후 테스트 처음 호출때 말고는 캐시에서 가져옴

</div>

</div>

</div>

<div id="footer" role="contentinfo">

<div class="section footer-body">

Document generated by Confluence on 4월 05, 2026 17:57



</div>

</div>

</div>
