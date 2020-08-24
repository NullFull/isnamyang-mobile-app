# 남양유없 모바일

플러터로 개발된 Android/iOS 남양유없 앱입니다.

## 개발 빌드
- 안드로이드: 터미널에서 프로젝트 루트 위치에서 `flutter build apk --split-per-abi --debug` 커맨드 실행 (--debug를 빼면 릴리즈 apk 빌드 실행됨, 실제 배포시에는 aab파일도 빌드 해야합니다.)
- 아이폰: 애플 개발자 계정이 등록된 XCode에서 `ios/Runner.xcworkspace`파일을 연 뒤 `Runner`->`Signing & Capabilities`에서 Team 항목을 애플 개발자 계정으로 설정 후 `Build`

## 릴리즈 빌드 유의사항
안드로이드 빌드의 경우에는 릴리즈 키가 있어야 배포용 빌드가 가능합니다.
이 저장소에는 보안을 위해 다음의 파일이 빠져있습니다.

- android/key.properties: jks 키파일 경로와 비밀번호
```
storePassword={비밀번호}
keyPassword={비밀번호}
keyAlias=isnamyang
storeFile={경로}/isnamyang.jks
```

- isnamyang.jks: 배포용 키파일 

위의 파일들은 슬랙 채널 `#남양유없` 채널에 배포하실 분이 요청해주세요.
파일들이 갖춰진 후 터미널, 프로젝트 루트에서 아래 커맨드를 실행합니다.
`flutter build appbundle`

아이폰의 경우에는 개발자 계정이 있다면 개발용 빌드는 빌드 및 테스트는 가능하나 릴리즈 빌드는 릴리즈 용 계정에 초대되어야 빌드가 가능합니다.

## 사용 오픈소스 라이브러리
  barcode_scan: https://pub.dev/packages/barcode_scan
  http: https://pub.dev/packages/http
  permission_handler: https://pub.dev/packages/permission_handler