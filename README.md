# Marsky Runner

Flutter ve Flame ile geliştirilmiş, Mars'ta geçen sade bir endless runner oyunu. MARSKY Flutter & Flame case çalışması için hazırlanmıştır.

## Nasıl oynanır

Ekranın herhangi bir yerine dokununca astronot zıplar. Sağdan gelen kayalara ve kristallere çarpmadan olabildiğince uzun süre hayatta kal. Skor, hayatta kalınan süreye göre artar (saniyede 10 puan). En yüksek skor cihazda saklanır.

## Çalıştırma

Flutter 3.47 (stable) ve Dart 3.13 ile test edilmiştir.

```bash
flutter pub get
flutter run
```

Testleri çalıştırmak için:

```bash
flutter test
```

## Proje yapısı

```
lib/
├── main.dart                  Uygulamayı başlatır, kayıtlı high score'u yükler
├── app.dart                   MaterialApp ve BlocProvider
├── data/
│   └── high_score_repository.dart   High score'un cihazda saklanması
├── state/
│   └── high_score_cubit.dart        High score state'i
├── game/                      Flame tarafı (oyun mekaniği)
│   ├── runner_game.dart       Oyun durumları ve component'lerin bir araya gelmesi
│   ├── game_config.dart       Ortak oyun sabitleri
│   ├── game_assets.dart       Asset isimleri ve preload listesi
│   └── components/
│       ├── background.dart    Parallax arka plan
│       ├── player.dart        Zıplama, yerçekimi, çarpışma
│       ├── obstacle.dart      Engel türleri ve hareketi
│       └── score_text.dart    Oyun içi skor gösterimi
└── ui/                        Flutter tarafı (menüler)
    ├── game_screen.dart       GameWidget ve overlay tanımları
    ├── menu_panel.dart        Menülerin ortak görünümü
    └── overlays/              Ana Menü, Pause butonu, Pause ve Game Over
```

`game/` klasöründeki her şey Flame ile, `ui/` klasöründeki her şey Flutter widget'larıyla yapılmıştır. Oyun mekaniği hiçbir yerde widget kullanmaz.

## Gereksinimler nasıl karşılandı

**Flame ve Component System:** Player (`SpriteAnimationComponent`), engeller (`SpriteComponent`), arka plan (`ParallaxComponent`) ve skor (`TextComponent`) ayrı component'lerdir. Her component kendi davranışından sorumludur; `RunnerGame` sadece bunları bir araya getirir ve oyun durumlarını yönetir.

**Kontrol:** Oyuna eklenen `TapCallbacks` ile ekranın her yerine yapılan dokunuş algılanır. Çift zıplama engellenmiştir.

**Engeller:** Flame'in `SpawnComponent.periodRange` component'i ile rastgele aralıklarla (1–2,2 sn) üç farklı engel türü doğar. Ekrandan çıkan engeller `removeFromParent()` ile kaldırılır.

**Çarpışma:** Flame'in `HasCollisionDetection`, `RectangleHitbox` ve `CollisionCallbacks` yapıları kullanılmıştır. Engellerin hitbox'ları `passive` olduğu için sadece player ile engeller arasındaki çarpışmalar kontrol edilir; engeller birbiriyle kontrol edilmez. Player'ın hitbox'ı, görseldeki boşlukların çarpışma sayılmaması için görselden biraz küçüktür.

**Skor:** Hayatta kalınan süreye bağlıdır ve Flame'in `TextComponent`'i ile çizilir. Metin sadece skor değiştiğinde güncellenir.

**Oyun durumları:** Ana Menü, Oyun İçi, Pause ve Game Over durumları `GameState` enum'u ile tutulur. Menüler Flame'in overlay sistemiyle gösterilir. Pause ve Game Over'da oyun `pauseEngine()` ile tamamen durur. Uygulama arka plana alındığında oyun otomatik olarak Pause'a geçer.

**State management:** Oyun dışı UI state'i olan high score, `flutter_bloc` paketindeki `HighScoreCubit` ile yönetilir ve `shared_preferences` ile kalıcı olarak saklanır. Oyun Cubit'i doğrudan tanımaz; oyun bitince kendisine verilen `onGameOver` fonksiyonunu çağırır. Oyunun kendi iç durumu (`GameState`) oyun döngüsüne ait olduğu için Flame tarafında tutulmuştur.

**Asset yönetimi:** Tüm görseller `images.loadAll`, sesler `FlameAudio.createPool` ile oyun başlamadan önce bir kez yüklenir. Component'ler görselleri önbellekten alır. Sesler `AudioPool` ile çalınır, böylece her seste yeni oynatıcı oluşturulmaz; havuzlar oyun kaldırılırken serbest bırakılır.

**Performans notları:** Farklı ekran boyutlarında aynı oynanış için sabit çözünürlüklü kamera (800x450) kullanılır. Oyun döngüsünde yeni nesne oluşturulmaz; tüm hareketler `dt` ile çarpılarak FPS'den bağımsız yapılır. `GameWidget.controlled` sayesinde widget rebuild'lerinde oyun yeniden oluşturulmaz.

## Testler

`test/` klasöründe high score kuralları (`HighScoreCubit`) ve player'ın zıplama fiziği için unit testler bulunur. Cubit testlerinde gerçek depolama yerine sahte bir repository kullanılır.

## Asset'ler

Görseller ve ses efektleri bu proje için hazırlanmıştır.
