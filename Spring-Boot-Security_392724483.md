<div id="page">

<div id="main" class="aui-page-panel">

<div id="main-header">

<div id="breadcrumb-section">

1.  [Programming](index.html)
2.  [Programming](Programming_98307.html)
3.  [Spring](Spring_120848385.html)
4.  [Spring Boot](Spring-Boot_223477765.html)

</div>

# <span id="title-text"> Programming : Spring Boot Security </span>

</div>

<div id="content" class="view">

<div class="page-metadata">

Created by <span class="author"> Dongwook Han</span>, last modified on 11월 24, 2023

</div>

<div id="main-content" class="wiki-content group">

- <a href="https://www.techgeeknext.com/spring-boot-security/basic_authentication_web_security" class="external-link" rel="nofollow">https://www.techgeeknext.com/spring-boot-security/basic_authentication_web_security</a>

# Spring Security Architecture

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><span class="image placeholder confluence-embedded-image image-center" original-image-src="attachments/392724483/414220296.png?width=760" original-image-title="" width="760" loading="lazy" image-src="attachments/392724483/414220296.png" data-height="410" data-width="825" unresolved-comment-count="0" linked-resource-id="414220296" linked-resource-version="1" linked-resource-type="attachment" linked-resource-default-alias="security01.png" base-url="https://never4got10.atlassian.net/wiki" linked-resource-content-type="image/png" linked-resource-container-id="392724483" linked-resource-container-version="11" media-id="0ceda5b1-b850-40f7-bc65-d76359e76380" media-type="file"></span></span>

- doFilter() : filter 들이 수행됨

- AbstractPreAuthenticatedProcessingFilter : Filter 중 인증을 담당하는 attemptAuthentication 호출

  - attemptAuthentication 메소드는 UsernamePasswordAuthenticationFilter에 구현됨

  - 인증 실패 여부에 따라 AuthenticationSuccessHandler, AuthenticationFailureHandler 중 호출

  - 인증 성공시 UsernamePasswordAuthenticationToken 세션에 저장

- AuthenticationManager interface

- ProviderManager (AuthenticationManager 구현) : AuthenticationProvider interface를 상속받아 구현한 클래스 중 설정된 인증처리 방식의 클래스를 찾아 실행 시킴 - 구현 메소드 이름 authenticate()

  - 예 ) id.password 인증처리 클래스 : AbstractUserDetailsAuthenticationProvider - DB 로 구현 DaoAuthenticationProvider

  - DaoAuthenticatoinProvider와 UserDetailsService 간의 관계를 규정하는 뭔가가 있음(?) - 뭔가가 뭐임????

  - 개발자는 UserDetailsService interface를 상속받은 콘트리트 클래스를 구현해야함

## SecurityContextHolder

- Spring Security에서 인증한 대상에 대한 상세 정보 저장

- Spring Security는 SecurityContextHolder에 어떻게 값을 넣는지는 상관 안 함

- SecurityContext 소유

- SecurityContextHolder가 설정되어 있으면 사용자가 인증 됐음으로 인식

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><span class="image placeholder confluence-embedded-image image-center" original-image-src="attachments/392724483/414351372.png?width=602" original-image-title="" width="602" loading="lazy" image-src="attachments/392724483/414351372.png" data-height="342" data-width="602" unresolved-comment-count="0" linked-resource-id="414351372" linked-resource-version="1" linked-resource-type="attachment" linked-resource-default-alias="SecurityContextHolder.png" base-url="https://never4got10.atlassian.net/wiki" linked-resource-content-type="image/png" linked-resource-container-id="392724483" linked-resource-container-version="11" media-id="1a2de213-f374-4d53-8448-6ac7a8678868" media-type="file"></span></span>

- 코드 예제

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  SecurityContext context = SecurityContextHolder.createEmptyContext();
  Authentication authentication = new TestingAuthenticationToken("username","password", "ROLE_USER");
  context.setAuthentication(authentication);

  SecurityContextHolder.setContext(context);
  ```

  </div>

  </div>

- Thread 경합을 피하려면 SecurityContextHolder.getContext().setAuthentication(authentication)을 사용하지 않는 것을 권장 =\> 새로운 SecurityContext을 생성하여 SecurityContextHolder.setContext() 에 설정

### SecurityContextHolder는 기본적으로 ThreadLocal을 사용하여 정보 저장

- 같은 Thread를 사용하면 항상 SecurityContext에 접근 가능

- Application의 Thread 처리 방식에 따라 ThreadLocal이 전혀 적합하지 않을 때도 있음

  - Standalone application은 SecurityContextHolder.MODE_GLOBAL 전략 사용

  - 인증 처리를 마친 thread가 생성한 security context를 다른 thread 에서도 사용해야 하면 SecurityContextHolder.MODE_INHERITABLETHREADLOCAL 적용

  - default 전략은 SecurityContextHolder.MODE_THREADLOCAL 임

- 전략 변경 방법 : 시스템 property 설정 or SecurityContextHolder의 static 메소드 사용

## SecurityContext

- 현재 인증한 사용자의 Authentication을 가지고 있음

## Authentication

- 사용자가 제공한 인증용 Credential이나 SecurityContext에 있는 현재 사용자의 credentials을 제공하며 AuthenticationManager의 입력으로 사용

  - principal : 사용자의 식별, 사용자의 이름/비밀번호로 인증 할 때 보통 UserDetails 인스턴스

  - credentials: 주로 비밀번호

  - authorities : 사용자에게 부여한 권한은 GrantedAuthority로 추상화. role 이나 scope가 있음

## GrantedAuthority

- Authentication에서 접근 주체(principal)에 부여한 권한

- Authentication.getAuthorites()로 접근 : Collection 리턴

- role 정보를 얻을 수 있음

## AuthenticatoinManager

- Spring Security의 필터가 인증을 어떻게 수행할지를 정의하는 API

- Spring Security filters를 사용하여 인증 처리를 하지 않을 경우 AuthenticationManager 사용할 필요 없음

- AuthenticationManager는 인터페이스로 구현체로 ProviderManager 사용

## ProviderManager

- 가장 많이 사용하는 AuthenticationManager 구현체

- 인증 동작을 AuthenticationProvider(List)에 위임

- 설정해 준 AuthenticationProvider 가 전부 인증하지 못하면 throw ProviderNotFoundException

- 인증 매커니즘이 다른 ProviderManager를 멀티로 사용 가능

- 인증에 성공하면 Authentication 객체에 있는 민감한 credential 정보 지원 → application 에서 성능 향상을 위해 사용자 객체 cache 사용시 문제 발생

## Authentication Manager(인증 매커니즘)

- 자주 쓰는 인증 매커니즘

  - Username and Password

  - OAuth 2.0 Login : OpenID Connect를 사용한 OAuth2.0 로그인과 비표준 OAuth2.0 로그인 (i.e GitHub)

  - SAML 2.0 Login

  - Central Authentication Server(CAS) : Central Authentication Server 지원

  - Remember Me : 세션이 만료된 사용자를 기억하는 방법

  - JAAS Authentication : JAAS를 사용한 인증

  - OpenID : OpenID인증(OpenID Connect와 혼동하지 말 것)

  - 사전 인증 시나리오 : 인증은 SiteMinder나 Java EE Security같은 외부 매커니즘으로 처리하면서 Spring Security로 권한 인가와 주요 취약점 공격을 방어

  - X509 Authentication

  - DAO 인증

  - JWT 토큰 인증 등

- 인증 매커니즘이 다른 ProviderManager 사용 가능 - 공통 인증을 사용할 경우 하나의 AuthenticationManager를 공유함

## AuthenticationEntryPoint

- 클라이언트에 credential 요청할 때 사용

  - 클라이언트가 리소스를 요청할 때 미리 ID/PW 같은 credential 전송시, credential을 요청하는 HTTP 응답 불필요

  - 클라이언트가 접근 권한이 없는 리소스에 인증되지 않은 요청 보낼 시, 인증을 위해 **<u>AuthenticationEntryPoint가 클라이언트에 로그인 페이지나 WWW-Authenticate 헤더로 HTTP 응답 전송</u>**

## AbstractAuthennticationProcessingFilter

- 인증에 사용할 Filter의 Base Filter

- credential을 인증할 수 없으면 Spring Security는 AuthenticationEntryPoint로 credential을 요청

- 사용자가 credential을 제출하면 AbstractAuthenticationProcessingFiler에서 Authentication 생성

# Servlet 기반 Architecture

## Filter와 DelegatingFilterProxy

- DelegatingFilterProxy : Servlet Container와 Spring ApplicationContext를 연결 - Servlet이 Spring Bean을 참조할 수 있게 해줌

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><span class="image placeholder confluence-embedded-image image-center" original-image-src="attachments/392724483/414253060.png?width=760" original-image-title="" width="760" loading="lazy" image-src="attachments/392724483/414253060.png" data-height="410" data-width="919" unresolved-comment-count="0" linked-resource-id="414253060" linked-resource-version="2" linked-resource-type="attachment" linked-resource-default-alias="security02.png" base-url="https://never4got10.atlassian.net/wiki" linked-resource-content-type="image/png" linked-resource-container-id="392724483" linked-resource-container-version="11" media-id="71495f0b-6012-458c-ae5d-cbaf82ea8d07" media-type="file"></span></span>

## FilterChainProxy

- Spring Security가 제공하는 특별한 Filter

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><span class="image placeholder confluence-embedded-image image-center" original-image-src="attachments/392724483/414449667.png?width=760" original-image-title="" width="760" loading="lazy" image-src="attachments/392724483/414449667.png" data-height="410" data-width="829" unresolved-comment-count="0" linked-resource-id="414449667" linked-resource-version="2" linked-resource-type="attachment" linked-resource-default-alias="security03.png" base-url="https://never4got10.atlassian.net/wiki" linked-resource-content-type="image/png" linked-resource-container-id="392724483" linked-resource-container-version="11" media-id="fcb1dfcd-1ddf-40ad-8b75-7ca935103159" media-type="file"></span></span>

## SecurityFilterChain

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><span class="image placeholder confluence-embedded-image image-center" original-image-src="attachments/392724483/414220303.png?width=760" original-image-title="" width="760" loading="lazy" image-src="attachments/392724483/414220303.png" data-height="410" data-width="904" unresolved-comment-count="0" linked-resource-id="414220303" linked-resource-version="2" linked-resource-type="attachment" linked-resource-default-alias="security04.png" base-url="https://never4got10.atlassian.net/wiki" linked-resource-content-type="image/png" linked-resource-container-id="392724483" linked-resource-container-version="11" media-id="30751030-ff1e-4b2c-91df-e4551ebf5b90" media-type="file"></span></span>

# SecurityFilters

- SecurityFilterChain API를 통해 FilterChainProxy에 추가

- Filter의 순서 중요

- 순서 참고용

  - ChannelProcessingFilter

  - ConcurrentSessionFilter

  - WebAsyncManagerintegrationFilter

  - SecurityContextPersistenceFilter : SecurityContextRepository에서 SecurityContext를 가져오거나 저장하는 역할

  - HeaderWriterFilter

  - CorsFilter

  - CsrfFilter

  - LogoutFilter : 설정된 로그아웃 URL로 오는 요청을 감시하며 로그아웃 처리

  - OAuth2AuthorizationRequestRedirectFilter

  - Saml2WebSsoAuthenticatoinRequestFilter

  - X509AuthenticationFilter

  - AbstractPreAuthenticatedProcessingFilter

  - CasAuthenticationFilter

  - OAuth2LoginAuthenticationFilter

  - Saml2WebSsoAuthenticationFilter

  - UsernamePasswordAuthenticationFilter : 인증 처리

  - ConcurrentSessionFilter

  - OpenIDAuthenticationFilter

  - DefaultLoginPageGeneratingFilter : 인증을 위한 로그인폼 URL 감시

  - DefaultLogoutPageGeneratingFilter

  - DigestAuthenticatoinFilter

  - BearerTokenAuthenticationFilter

  - BasicAuthenticationFilter : HTTP 기본 인증 헤더를 감시하여 처리

  - RequestCacheAwareFilter : 로그인 성공 후, 원래 요청 정보를 재구성하기 위해 사용

  - SecurityContextholderAwareRequestFilter

  - JaasApliIntegratoinFilter

  - RememberMeAuthenticatoinFilter

  - AnonymousAuthenticationFilter : 사용자 정보가 인증되지 않았다면 인증 토큰에 사용자를 익명 사용자로 나타냄

  - OAuth2AuthorizationCodeGrantFilter

  - SessionManagementFilter : 인증된 사용자와 관련된 모든 세션 추적

  - ExceptionTranslationiFilter : 예외를 위임하거나 전달하는 역할

  - FilterSecurityInterceptor : AccessDecisionManager로 권한 부여 처리를 위임하여 접근 제어 결정 처리

  - SwitchUserFilter

# Handler Security Exceptions

- ExceptionTranslationFilter는 FilterChainProxy에 하나의 보안 필터로 추가됨

- Security Exception 처리

  1.  ExceptionTranslationFilter는 FilterChain.doFileter(reqeust, response) 를 호출해서 어플리케이션이 나머지 로직을 실행

  2.  인증받지 않은 사용자였거나 AuthenticatoinException이 발생했다면 인증 시작

      1.  SecurityContextHolder 비움

      2.  RequestChache에 HttpServletReqeust 저장

      3.  AuthenticatoinEntryPoint는 클라이언트에 Credential을 요청할 때 사용: 로그인 페이지로 redirect, 또는 www-authenticate 헤더 전송

  3.  AccessDeniedException 이었으면 접근 거부하고 AccessDeniedHandler 에서 처리

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><span class="image placeholder confluence-embedded-image image-center" original-image-src="attachments/392724483/414253066.png?width=615" original-image-title="" width="615" loading="lazy" image-src="attachments/392724483/414253066.png" data-height="410" data-width="615" unresolved-comment-count="0" linked-resource-id="414253066" linked-resource-version="2" linked-resource-type="attachment" linked-resource-default-alias="security05.png" base-url="https://never4got10.atlassian.net/wiki" linked-resource-content-type="image/png" linked-resource-container-id="392724483" linked-resource-container-version="11" media-id="8c23d5c6-b031-4e09-b723-66d8babf8423" media-type="file"></span></span>

# Spring Boot 버전별 Security Configuration

- Spring Boot 2.6 이후(정확한 버전을 서베이 필요), WebSecurityConfigurerAdapter가 deprecated 됨

- 기존 WebSecurityConfigurerAdapter를 상속받아 configuration을 구현하는 방식에서 bean 선언 방식으로 변경

  - Spring boot 2.6 이전 코드

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    @Configuration
    @EnableWebSecurity
    public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
      @Override
      protected void configure(HttpServlet http) throws Exception {
        http
          .authorizeRequests()
            .antMatcher("/", "/home").permitAll()
            .antRequest().authenticated()
            .and()
          .formLogin()
            .loginPage("/login")
            .permitAll()
            .and
          .logout()
            .permitAll();
      }
    }
    ```

    </div>

    </div>

  - 이후 코드

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    @Configuration
    @EnableWebSecurity
    public class WebSecurityConfig {
      @Bean
      public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
          .authorizeHttpRequests((requests) -> requests
                                  .requestMatchers("/","/home").permitAll()
                                  .anyRequest().authenticated()
          )
          .formLogin((form) -> form
                       .loginPage("/login")
                       .permitAll()
          )
          .logout((logout) -> logout.permitAll());
          
          return http.build();
                       
      }
    }
    ```

    </div>

    </div>

- 주의 사항

  - WebSecurity와 HttpSecurity 설정할 때 주의해야 함

  - 예제

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    @Override
    public void configure(WebSecurity web) throws Exception{
      web.ignoring()
         .antMatchers("/resources/**");
    }

    @Override
    public void configure(HttpSecurity http) throws Exception {
      // WebSecurity에서 접근 허용 설정을 하면 이 설정은 적용 안 됨
      http.authorizedRequests()
         .antMatchers("/resources/**").hasRole("ADM")
         .anyRequest().authenticated();
    }
    ```

    </div>

    </div>

- Spring Security 설정을 할 때 다음 규정을 지켜야 함

  - 설정은 HttpSecurity 로 한다.

  - WebSecurity는 Spring Security 앞 단의 설정을 하는 객체

  - HttpSecurity가 설정한 Spring Security 설정을 Override 하지 않도록 WebSecurity 사용 주의

- HttpSecurity

  - 리소스(URL) 접근 권한 설정

  - 인증 전체 흐름에 필요한 Login, Logout 페이지 인증 완료 후 페이지 인증 실패시 이동 페이지 등 설정

  - 인증 로직을 커스터마이즈 하기 위한 필터 설정

  - 기타 csrf, 강제 https 등 거의 모든 설정

  - 예제 (리소스 권한 설정)

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    http.authorizeRequest()
         .antMatchers("/login/**", "/web-resources/**", "/actuator/**").permitAll()  // 설정한 리소스들의 접근을 인증절차 없이 허용
         .antMatchers("/admin/**").hasAnyRole("ADMIN")  // 인증 후 ADMIN 권한만 허용
         .antMatchers("/order/**").hasAnyRole("USER")
         .anyRequest().authenticated(); // 모든 리소스 의미. 앞에서 인증 설정한 것을 제외한 모든 리로스는 무조건 인증을 완료해야 접근 가능
    ```

    </div>

    </div>

  - 에제 (로그인 처리)

    <div class="code panel pdl" style="border-width: 1px;">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
    http.formLogin()  // 로그인 페이지와 기타 로그인 처리 및 성공/실패 처리를 하겠다는 선언
      .loginPage("/login-page")  // 디폴트 설정은 /login, spring이 제공하는 기본 페이지 호출됨
      .loginProcessingUrl("/login-process") //인증처리 URL 설정, 인증처리하는 필터 호출
      .defaultSuccessUrl("/main") // 로그인 성공시 이동하는 페이지, 디폴트 값 '/'
      .successHandler(new CustomAuthenticationSuccessHandler("/main"))  // 정상 인증 후 커스텀 핸들러
      .failureUrl("/login-fail")  // 실패시 이동 페이지
      .failureHandler(new CustomAuthenticationFailureHandler("/login-fail"))  // 실패시 커스텀 핸들러
    ```

    </div>

    </div>

  - 

참고 자료 : <a href="https://reflectoring.io/spring-security" class="external-link" rel="nofollow">https://reflectoring.io/spring-security</a> 예제는 spring 2.6 이후 예제로 추정

# Spring Security Cusomizing

## Custom Filter 등록

- Spring Security는 각각 역할에 맞는 필터들이 chain 형태로 구성되어 순서대로 실행

- 사용자가 특정 기능의 필터를 생성하여 등록 가능

### Filter 등록

- Id/pw 인증하는 UsernamePasswordAuthenticationFilter 대신 별도의 인증 처리 필터 등록 예

- 기존 필터 앞에 수행

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  http.addFilterBefore(new CustomAuthenticationProcessingFilter("/login-process"),
      UsernamePassword.AuthenticationFilter.class);
  ```

  </div>

  </div>

- 기존 필터 뒤에 수행

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  http.addFilterAfter(new CustomAuthenticationProcessingFilter("/login-process"),
      UsernamePassword.AuthenticationFilter.class);
  ```

  </div>

  </div>

- 지정된 필터의 순서에 커스텀 필터가 추가

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  http.addFilterAt(new CustomAuthenticationProcessingFilter("/login-process"),
      UsernamePassword.AuthenticationFilter.class);
  ```

  </div>

  </div>

  - 대체가 되는 개념이 아닌 바로 앞에 추가되는 개념

- 필터를 대체하는 개념보다는 인증처리되면 뒤에 인증 로직을 수행하지 않고 통과하기 때문에 대체하는 것처럼 보임(지금 예제는 인증에 관하여 처리하므로, 다른 기능일 경우도 동일)

### 커스텀 필터에 설정 추가

- 커스텀 필터에 인증 매니저 및 성공 실패 핸들러를 추가 및 설정할 수 있음

- 코드 예제

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Bean
  public CustomAuthenticatoinProcessingFilter customAuthenticationProcessingFilter() {
    CustomAuthenticationProcessingFilter filter = new CustomAuthenticatoinProcessingFilter("/login-process");
    filter.setAuthenticationManager(new CustomAuthenticationManager()); // 인증 매니저 추가
    filter.setAuthenticationFailureHandler(new CustomAuthenticationFailureHandler("/login"));
    filter.setAuthenticationSuccessHandler(new SimpleUrlAuthenticationSuccessHandler("/"));
  }

  @Override
  public void configure(HttpSecurity http) throws Exception {
    http.addFilterBefore(customAuthenticationProcessingFilter(), 
         UsernamePasswordAuthenticationFilter.class);
  }
  ```

  </div>

  </div>

- 커스텀 필터를 통한 인증 처리

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  public class CustomAuthenticationProcessingFilter extends AbstractAuthenticationProcessingFilter {
    public CustomAuthenticationnProcessingFilter(String defaultFilterProcessesUrl) {
      super(defaultFilterProcessesUrl);
    }
    
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
      String username = request.getParameter("username");
      String password = request.getParameter("password");
      
      return getAuthenticatoinManager()
          .authenticate(new UsernamePasswordAuthenticationToken(username, password));
    }
  }
  ```

  </div>

  </div>

- CustomAuthenticationManager 생성

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  public class CustomAuthenticationManager implements AuthenticationManager {
    @Autowired
    private UserDetailsService userDetailsService;
    
    /**
     * 사용자 인증 처리, 비번 일치, 존재하는 사용자 인지 등등 로직 처리
     */
    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
      UserDetails userDetails = userDetailsService.loadUserByUsername(authentication.getPrincipal());
      return new UsernamePasswordAuthenticationToken(userDetails.getUsername()
               , userDetails.getPassword()
               , userDetails.getAuthorities());
    }
  }
  ```

  </div>

  </div>

- UserDetails 구현

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  public class CustomUserDetilas implements UserDetails {
    private List<GrantedAuthority> authorities;
    private String password;
    
    ...
    public CustomUserDetails(User user) {
      this.authorities = user.getAuthorities();
      this.password = user.getPassword();
      ...
    }
    
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
      return authorities;
    }
    
    @Override
    public String getPassword() {
      return password;
    }
  }
  ```

  </div>

  </div>

- UserDetailsService 구현

  <div class="code panel pdl" style="border-width: 1px;">

  <div class="codeContent panelContent pdl">

  ``` syntaxhighlighter-pre
  @Service
  public class UserDetailsService implements UserDetailsService {
    @Autowired
    private UserRepository userRepository;
    
    @Override
    public UserDetails loadUserByUsername(String userId) throws BrmsBadCredentialsException {
      return CustomUserDetails(userRepository.findByUserId(userId));
    }
  }
  ```

  </div>

  </div>

- 인증성공/인증 실패 커스텀 핸들러

  - AuthenticationSuccessHandler/AuthenticatoinFailureHandler

## Spring Security dependency 추가시 일어나는 일들

- 서버가 기동되면 Spring Security 초기화 및 초안 설정 이루어짐

- 별도의 설정이나 구현을 하지 않아도 기본적인 웹 보안 기능이 적용

  1.  모든 요청은 이증이 되어야 자원에 접근 가능

  2.  인증 방식은 form-login 방식과 httpBasic 로그인 방식 제공

  3.  user 계정 제공(application.properties에 user 계정 패스워드 지정 가능)

- 사용자 정보(id/pw)을 application.properties에 정의해서 사용할 수 있음

  - spring.security.user.name=user

  - spring.security.user.password=user1234

- Spring Security 웹 보안 기능 초기화 및 설정

  - @EnableWebSecurity 를 WebSecurityConfigurerAdapter를 상속하는 설정 객체에 정의하면 SpringSecurityFilterChain에 등록됨

  - @EnableWebMvcSecurity : Spring MVC에서 웹 보안을 활성화하기 위한 annotation 핸들러 메소드에서 @AuthenticationPrincipla annotation에 붙은 매개 변수를 이용해 인증 처리 수행. 그리고 자동적으로 CSRF 토큰을 Spring의 form binding tag library를 사용해 추가하는 bean을 설정

## Authentication API/Authorize API

- Authentication API

  - HttpSecurity.formLogin()

  - HttpSecurity.logout()

  - csrf()

  - httpBasic()

  - Sessionmanagement(0

  - RememberMe()

  - ExceptionHandling()

  - addFilter()

- Authorize API

  - HttpSecurity.authorizeRequests().antMatcher(/admin)

  - hasRole(USER)

  - permitAll()

  - authenticated()

  - fullyAuthentications()

  - access(hasRole(USER))

  - denyAll()

</div>

<div class="pageSection group">

<div class="pageSectionHeader">

## Attachments:

</div>

<div class="greybox" align="left">

<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [spring_security_architecture.png](attachments/392724483/394657793.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [spring_security_01.png](attachments/392724483/394788865.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [spring_security_02.png](attachments/392724483/394657799.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [spring_security_03.png](attachments/392724483/394723331.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [spring_security_04.png](attachments/392724483/394625032.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [image-20230512-050938.png](attachments/392724483/394952709.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [security02.png](attachments/392724483/414318597.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [security05.png](attachments/392724483/414187530.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [security01.png](attachments/392724483/414220296.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [security04.png](attachments/392724483/414220310.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [security03.png](attachments/392724483/414253072.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [security02.png](attachments/392724483/414253060.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [security03.png](attachments/392724483/414449667.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [security04.png](attachments/392724483/414220303.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [security05.png](attachments/392724483/414253066.png) (image/png)\
<img src="./media/images/icons/bullet_blue.gif" width="8" height="8" /> [SecurityContextHolder.png](attachments/392724483/414351372.png) (image/png)\

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
