<div id="page">

<div id="main" class="aui-page-panel">

<div id="main-header">

<div id="breadcrumb-section">

1.  [Programming](index.html)
2.  [Programming](Programming_98307.html)
3.  [Spring](Spring_120848385.html)
4.  [정리](430342186.html)

</div>

# <span id="title-text"> Programming : ApplicationEvent </span>

</div>

<div id="content" class="view">

<div class="page-metadata">

Created by <span class="author"> Dongwook Han</span> on 3월 15, 2024

</div>

<div id="main-content" class="wiki-content group">

<div class="confluence-information-macro confluence-information-macro-information">

<span class="aui-icon aui-icon-small aui-iconfont-info confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

</div>

</div>

## 용도

- 어플리케이션 내 사용자에게 통보를 해줘야 할 작업 완료

- 특정 작업이 수행시 로깅 작업 등(배포 작업 로깅 등)

## 사용법

- 구조

  - publicsher - subscriber 구조

### ApplicationListener 사용

- ApplicationContext에 ApplicationListener를 등록하여 ApplicationEvent를 수신받도록 처리

#### 실습 예제

- 샘플1

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  public static void main(String[] args ) {
    ConfigurableApplicationContext context = SpringApplication.run(OrcaApplication.class, args);
    
    // context에 ApplicationListener 에 등록
    context.addApplicationListener(new ApplicationListener<ApplicationEvent>() {
      @Override
      public void onApplicationEvent(ApplicationEvent event) {
        System.out.prinltn("event listen");
      }
    });
  }

  // 람다식으로 정의
  context.addApplicationListener(event -> System.out.println("event listen"));

  // ApplicationEvent Publish context의 publishEven 메소드 사용
  context.publishEvent(new ApplicationEvent(context){
  });
  ```

  </div>

  </div>

### @EventListener annotation 사용하여 정의

#### 사용법

- @EventListener(ApplicationReadyEvent.class) 를 정의 : 사용할 Object를 정의

- 예제

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @EventListener(ApplicatoinReadyEvent.class)
  public void init() {
    System.out.println("event listener");
  }
  ```

  </div>

  </div>

- @EventListener 예제

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @EventListener(ApplicatoinReadyEvent.class)
  public void init() {
    System.out.println("ddd");
  }
  ```

  </div>

  </div>

### Event

- ApplicatoinReadyEvent와 같이 미리 정의된 event 사용

  - org.springframework.boot.context.evet 패키지에 정의됨

- 그외 event

  - ApplicationContextInitializedEvent : SpringApplication 시작, ApplicationContext 준비, ApplicationContextInitializer 호출 - Bean 로딩전까지의 event 알림

  - ApplicationEnvironmentPreparedEvent : SpringApplication 시작, Environment(profile, property) 처음으로 인지 및 변경이 가능할 때 이벤트 알림

  - ApplicationFailedEvent : SpringApplication 시작이 실패시

  - ApplicationPreparedEvent : SpringApplication 시작, ApplicationContext가 완전히 준비되었을 때 (but not refreshed)

  - ApplicationReadyEvent : Application이 서비스 요청에 응할 수 있을 때

  - ApplicationStartedEvent : ApplicationContext가 refresh 되었으나 Application와 command line runner가 호출되기 전에 publish

  - ApplicationStartingEvent : SpringApplication이 시작되지마자, Environment와 ApplicationContext가 사용 가능하기전, ApplicationListener가 등록된 이후

### 사용자 정의 event 구현

- 샘플 예제

  1.  event Object 정의

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      @Gettter
      @Settger
      @Builder
      public class NewsEvent {
        private int num;
        private String title;
        private String content;
      }
      ```

      </div>

      </div>

  2.  Event Listener 등록

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      @Configuration
      @Slf4j
      public class RegisterEvent {
        @EventListener
        public void publishEvent(newsEvent event) {
          log.info("news : " + event.getNum() + event.getTitle());
        }
      }
      ```

      </div>

      </div>

  3.  publisher 정의

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      @Component
      public class NewsEventPublisher {
        @Autowired
        ApplicationEventPublisher applicationEventPublisher;
        
        public void publish(NewsEvent event) {
          applicationEventPublisher.publisherEvent(event);
        }
      }
      ```

      </div>

      </div>

  4.  publisher 호출

      <div class="code panel pdl" style="border-width: 1px;">

      <div class="codeContent panelContent pdl">

      ``` syntaxhighlighter-pre
      @Autowired
      NewsEventPublisher newsEventPublisher;

      @GetMapping("/...")
      public String greeting(...) {
        NewsEvent newsEvent = NewsEvent.builder()
           .num(1)
           .title("속보")
           .content("대설주의보")
           .build()
        newsEventPublisher.publish(newsEvent);
        ...
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
