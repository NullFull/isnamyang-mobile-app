# 남양유없 모바일

플러터로 개발된 Android/iOS 남양유없 앱입니다.


## 유의사항
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

아이폰의 경우에는 개발자 계정이 있다면 개발용 빌드는 빌드 및 테스트는 가능하나 릴리즈 빌드는 릴리즈 용 계정에 초대되어야 빌드가 가능합니다.

## 사용 오픈소스 라이브러리
  - barcode_scan: https://pub.dev/packages/barcode_scan
  - http: https://pub.dev/packages/http
  - permission_handler: https://pub.dev/packages/permission_handler
