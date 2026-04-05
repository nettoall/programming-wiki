<div id="page">

<div id="main" class="aui-page-panel">

<div id="main-header">

<div id="breadcrumb-section">

1.  [Programming](README.md)
2.  [Programming](Programming_98307.md)
3.  [Spring](Spring_120848385.md)
4.  [Spring Boot](Spring-Boot_223477765.md)

</div>

# <span id="title-text"> Programming : Spring Boot Project Interfration with Apache Kafka </span>

</div>

<div id="content" class="view">

<div class="page-metadata">

Created by <span class="author"> Dongwook Han</span>, last modified on 4월 02, 2023

</div>

<div id="main-content" class="wiki-content group">

- 많은 최신 시스템에서는 데이터가 사용 가능한 즉시 대상 목적(targeted purpose)을 위해 데이터가 처리되어야 함

- 예로 로깅 또는 모니터링 시스템, 문제가 발생하는 즉시 데이터가 필요

- 더 빠르고 강력한 데이터 전달에 대한 요구사항이 높음

- Apache Kafka는 데이터를 생성하는 애플리케이션과 데이터를 소비하는 애플리케이션 간에 데이터를 전송하는 중재자 역할을 수행

# JMS 한계(Java Message Service)

- 자바 언어에 의존적. 따라서 모든 참가자 : Producer와 Consumer가 자바 애플리케이션이어야 한다.

- TCP Protocol에서 동작. 다른 Protocol을 지원 안 함

- 메시지가 용량이 매우 크면, MOM(단 하나의 Message Broker Software) 가 매우 느리게 작동

- Producer와 Consumer가 여러개인 경우, 확장을 지원 안 함. 따라서 여러 MOM 인스턴스를 생성하지 못함

- MOM이 다운되거나 MOM이 응답하지 않으면 데이터가 손실될 가능성이 있음(싱글 인스턴스이기 때문에 Producer가 MOM에 메시지를 전달하고나서 MOM이 죽으면 Consumer는 메시지를 받지 못함)

- JMS는 Producer 수가 적고 Consumer의 수가 적은 경우와 같은 소규모 애플리케이션에 가장 적합

# Apache Kafka

- Java 및 Scala로 작성된 Apache Software Foundation에서 개발한 오픈소스 소프트웨어 플랫폼

- 실시간 데이터 피드를 처리하기 위한 통합된 높은 처리량과 낮은 대기 시간 플랫폼을 제공

- Kafka는 Kafka Connect를 통해 외부 시스템에 연결할 수 있고 Java stream 처리 라이브러리인 Kafka Streams 를 제공

- Apache Kafka는 실시간으로 레코드 Streams를 publish, subsribe to, sotre 그리고 처리할 수 있는 분산 데이터 streaming 플랫폼임

- 여러 소스의 데이터 스트림을 ㅊ처리하고 여러 소비자에게 전달되도록 설계됨

- 엄청난 양의 데이터를 A,B 지점뿐만 아니라 A부터 Z 지점까지 어디든 이동시킴

- 하루에 1조 4천억개의 메시지를 처리하기 위해 Linkedin에서 내부 시스템으로 시작

# Kafka APIs

- Kafka에는 Java 및 Scala 용으로 다음과 같은 5가지 핵심 API 가 있음

  1.  topics, brokers, 그리고 다른 kafka 객체를 관리하고 검사하는 **Admin API**

  2.  이벤트 스트림을 하나 이상의 Kafka topics를 publish 하는 **Producer API**

  3.  하나 이상의 topic을 subscript 하거나 생성된 이벤트 스트림을 처리하는 **Consumer API**

  4.  Kafka **Streams API**는 **Stream 처리 애플리케이션과 microservice를 구현**. 변환을 포함한 이벤트 스트림 처리, 집계 및 조인과 같은 상태저장 작업, Windowing, 이벤트 시간 기반 처리 등의 **상위 수준의 기능을 제공**. 하나 이상의 topic으로의 출력을 생성하기 위해 하나 이상의 topic 에서 입력을 읽어 input streams를 output stream으로 효과적으로 변환(마지막 라인 이해가…)

  5.  Kafka **Connect API**는 외부 시스템와 애플리케이션에서 이벤트 스트림을 소비하고 생산하는 재사용가능한 데이터 **import/export connectors를 만들고 실행시켜 Kafka와 통합할 수 있도록 한다.**

# Kafka 목적

- Kafka는 Java 언어로 구현되지만, Spark, Sccala, Hadoop, BigData 등과 같은 다양한 기술및 개념과의 통합을 지원

- **클러스터 설계로 인해** Kafka는 여러 **복잡한 시스템 간의 데이터 전송을 지원**

- **REST 호출**을 통해 non-java 기술과의 통합도 지원

- **TCP,FTP, HTTP** 등을 사용해 코드 작성할 수 있으므로 프로토콜 독립적

- Kafka는 여러 메시지 borker 지원. **broker software의 수평적 확장 가능**

- Kafka는 Zookeeper 의 지원을 받아 **로드 발랜싱 처리**(like 마이크로서비스의 Netflix Eureka와 같이)

# Kafka의 여러 구성 요소

- 경우에 따라 전체 Kafka 시스템은 여러 요소/노드/서버 로 구성될 수 있으므로 Kafka 클러스터라고도 함

- Kafka의 네가지 주요 구성 요소

## Producer

- 하나 이상의 Kafka Topic에 메시지 작성, 최적화, publish 하는 데이터 소스 역할

- Kafka producers는 파티셔닝을 통해 brokers 간에 데이터 직렬화, 압축, 로드 발랜싱 처리 수행

## Topic

- 데이터가 스트리밍하는 채널을 나타냄

- Producers는 메시지를 topic에 publish 하고 Consumer는 topic으로 부터 subscript하여 message를 읽는다.

- Topic는 메시지를 구성하고 구조화함

- 특정 유형의 메시지는 특정 topic에 publish 됨. Kafka cluster에서 고유한 이름으로 지정됨

- 생성할 수 있는 Tocpic의 수에 대한 제한은 없음

## Broker

- Node에서 실행되는 Software 구성요소

- 대부분 Kafka Cluster 에서 실행되고 있는 서버로 정의함

- 즉, Kafka Cluster는 여러 broker로 구성됨(WAN과 같이 일종의 구성망과 같은 개념?)

- 일반적으로 여러 broker가 Kafka 클러스터를 구성하고 로드 밸런싱과 안정적인 중복성 및 장애 조치를 수행

- Broker들은 관리와 조정을 위해 Apache ZooKeeper를 사용

- 각 broker 인스턴스는 읽기 및 쓰기 수량을 처리할 수 있는 능력을 가짐

- 각 broker는 고유한 ID를 가지며 하나 이상의 topic 로그 파티션을 담당

## Consumer

- Consumer는 subscribe 하는 tocpi으로부터 메시지를 읽음

- Consumper는 consumer group에 소속됨

- 특정 Consumer group에 소속된 각 consumer는 subscribe 한 각 topic의 파티션의 하위 집합을 읽을 책임이 있음 (subscribe 한 건 꼭 수신받아야 한다?)

- KafKa Cluster의 데이터는 여러 Broker에 분산됨. Kafka cluster 에는 동일한 데이터의 여러 복사본이 있음: replicas. 이 메커니즘은 Kafka를 더욱 안정적으로 만듬

- 한 broker에서 오류가 발생하면 다른 broker가 손상된 구성 요소의 기능을 수행. 따라서 정보 손실의 가능성이 없음

# Zookeeper 란

- 구성 정보 제공, 동기화, 이름 지정 레지스트리(naming registry) 및 대규모 클러스터에 대한 기타 그룹 서비스와 같은 중앙 집중식 서비스를 분산 시스템에서 제공

- Kafka는 Zookeeper를 사용하여 Kafka cluster의 노드 상태를 추적

# Kafka에서 Zookeeper의 역할

- 분산 시스템에서 작업하는 동안 작업을 조정하는 방법이 있어야 합니다.

- 우리의 맥락에서 Kafka는 ZooKeeper를 사용하여 작업을 조정하는 분산 시스템입니다.

- 그러나 Elasticsearch 및 mongoDB와 같은 작업 조정을 위한 자체 내장 메커니즘이 있는 다른 기술이 있습니다. (zookeeper와 같은 역할을 한다? 아님 kafka보다 더 낫다?)

  1.  Apache Kafka로 작업할 때 ZooKeeper의 주요 역할은 Kafka cluster 의 노드 상태를 추적하고 kafka topic 와 메시지 목록을 유지관리하는 것

  2.  실제로 ZooKeeper 는 borker들과 cluster topology를 조정

  3.  ZooKeeper는 구성 정보에 대해 일관된 파일 시스템 역할을 수행. 구성정보에 모든 Kafka broker 목록이 포함됨. broker가 다운되거나 파티션이 다운되거나 새로운 broker가 기동되거나, 새로운 파티션이 가동될 때 Kafka에 알림

  4.  ZooKeeper가 각 클라이언트가 읽고 쓸 수 있는 데이터 양을 엑세스

  5.  Kafka는 ZooKeeper를 사용하여 특정 Consumer Group이 특정 topic과 파티션에 대해 Consum한 메시지의 offset을 저장

- 파티션에 포함된 메시지에는 offset 이라는 고유 ID 번호가 할당됨

- offset의 역할은 파티션 내의 모든 메시지를 고유하게 식별하는 것

# Kafka 설치

## Kafka 다운로드

- Kafka 2.6.0 설치(<a href="https://kafka.apache.org/" class="external-link" data-card-appearance="inline" rel="nofollow">https://kafka.apache.org/</a> ), 2023.04 현재 3.4.0 이 최신

- Kafka 3.1.0 부터 Java 17 지원

- kafka_2.12-2.6.0.tgz를 다운받으라는데 앞에 2.12는 scala 버전임

## Kafka 설치

- kafka_2.13-2.6.0.tgz 파일을 압축 해제 (최종 위치 : F:\dev_tool\kafka\kafka_2.13-2.6.0)

# Apach Kafka Spring Boot Example

## 단계1. Spring Boot 프로젝트 생성

- dependency : Spring Web, Spring For Apache Kafka, Spring Boot DevTools.

## 단계2. SpringBootApplication에 @EnableKafka 어노테이션 추가

<div class="code panel pdl" style="border-width: 1px;">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
package com.dev.spring.kafka;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.kafka.annotation.EnableKafka;

@SpringBootApplication
@EnableKafka
public class SpringBoot2ApacheKafkaTestApplication {

      public static void main(String[] args) {
         SpringApplication.run(SpringBoot2ApacheKafkaTestApplication.class, args);
      }
}
```

</div>

</div>

## 단계3. MessageRepository 클래스 구현

- MessageRepository 클래스 구현

- 추후 목록과 메시지에 대해 정의할 예정

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.spring.kafka.message.repository;

  import java.util.ArrayList;
  import java.util.List;
  import org.springframework.stereotype.Component;

  @Component
  public class MessageRepository {

         private List<String> list = new ArrayList<>();

         public void addMessage(String message) {
            list.add(message);
         }

         public String getAllMessages() {
            return list.toString();
         }
  }
  ```

  </div>

  </div>

## 단계4. MessageProducer 클래스 구현

- 메시지를 생산하고 Topic에 전송하는 MessageProducer 클래스 구현

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.spring.kafka.sender;

  import org.slf4j.Logger;
  import org.slf4j.LoggerFactory;
  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.beans.factory.annotation.Value;
  import org.springframework.kafka.core.KafkaTemplate;
  import org.springframework.stereotype.Component;

  @Component
  public class MessageProducer {

  private Logger log =LoggerFactory.getLogger(MessageProducer.class);

        @Autowired 
        private KafkaTemplate<String, String> kafkaTemplate;

        @Value("${myapp.kafka.topic}")
        private String topic;

        public void sendMessage(String message) {
           log.info("MESSAGE SENT FROM PRODUCER END -> " + message);
           kafkaTemplate.send(topic, message);
        }
  }
  ```

  </div>

  </div>

## 단계5. MessageConsumer 클래스 구현

- Topic으로부터 Message를 Consume 하는 MessageConsumer 구현

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.spring.kafka.consumer;

  import org.slf4j.Logger;
  import org.slf4j.LoggerFactory;
  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.kafka.annotation.KafkaListener;
  import org.springframework.stereotype.Component;
  import com.dev.spring.kafka.message.repository.MessageRepository;

  @Component
  public class MessageConsumer {

        private Logger log = LoggerFactory.getLogger(MessageConsumer.class);

        @Autowired
        private MessageRepository messageRepo;

        @KafkaListener(topics = "${myapp.kafka.topic}", groupId = "xyz")
        public void consume(String message) {
           log.info("MESSAGE RECEIVED AT CONSUMER END -> " + message);
           messageRepo.addMessage(message);
        }
  }
  ```

  </div>

  </div>

## 단계6. KafkaRestController를 @RestController로 선언

- 웹 브라우저의 메시지를 Producer에 대한 입력으로 사용할 RestController 선언

- Kafka에 메시지를 보내 Rest 호출을 통해 처리

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  package com.dev.spring.kafka.controller;

  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.web.bind.annotation.GetMapping;
  import org.springframework.web.bind.annotation.RequestParam;
  import org.springframework.web.bind.annotation.RestController;
  import com.dev.spring.kafka.message.repository.MessageRepository;
  import com.dev.spring.kafka.sender.MessageProducer;

  @RestController
  public class KafkaRestController {

        @Autowired
        private MessageProducer producer;

        @Autowired
        private MessageRepository messageRepo;

        //Send message to kafka
        @GetMapping("/send")
        public String sendMsg(
        @RequestParam("msg") String message) {
            producer.sendMessage(message);
            return "" +"'+message +'" + " sent successfully!";
        }

        //Read all messages
        @GetMapping("/getAll")
        public String getAllMessages() {
           return messageRepo.getAllMessages() ;
        }
  }
  ```

  </div>

  </div>

## 단계7. application.yml 파일 생성

- src/main/resources 에 application.properties 제거하고 application.yml 생성

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  server:
    port: 9090

  spring:
    kafka:
      producer:
        bootstrap-servers: localhost:9092
        key-serializer: org.apache.kafka.common.serialization.StringSerializer
        value-serializer: org.apache.kafka.common.serialization.StringSerializer
                    
      consumer:
        bootstrap-servers: localhost:9092
        key-deserializer: org.apache.kafka.common.serialization.StringDeserializer
        value-deserializer: org.apache.kafka.common.serialization.StringDeserializer
          
  myapp:
      kafka:
        topic: myKafkaTest
  ```

  </div>

  </div>

# 테스트

1.  Start Zookeeper

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    cmd> cd F:\dev_tool\kafka\kafka_2.13-2.6.0
    cmd> .\bin\windows\zookeeper-server-start.bat .\config\zookeeper.properties
    ```

    </div>

    </div>

2.  Start Kafka setup

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    cmd> cd F:\dev_tool\kafka\kafka_2.13-2.6.0Create a Topic
    cmd> .\bin\windows\kafka-server-start.bat .\config\server.properties
    ```

    </div>

    </div>

3.  Topic 생성

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    cmd> .\bin\windows\kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic myKafkaTest
    ```

    </div>

    </div>

4.  Run Spring Boot Application

5.  애플리케이션 시작 후, Browser에 다음 URL 입력하여 테스트

    - <a href="http://localhost:9090/send?msg=I" class="external-link" rel="nofollow">http://localhost:9090/send?msg=I</a> like

    - <a href="http://localhost:9090/send?msg=I" class="external-link" rel="nofollow">http://localhost:9090/send?msg=to work on</a>

    - <a href="http://localhost:9090/send?msg=I" class="external-link" rel="nofollow">http://localhost:9090/send?msg=Kafka</a>

    - <a href="http://localhost:9090/send?msg=I" class="external-link" rel="nofollow">http://localhost:9090/send?msg=</a>with Spring Boot

    - http://localhost:9090/getAll

6.  console에 입력한 메시지가 있는지 확인

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
