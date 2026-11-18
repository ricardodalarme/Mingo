# Home widgets

Eleven home widgets ship with the app, one per function, on iOS (WidgetKit) and Android (Jetpack Glance). There is nothing to
configure: what a home widget shows is what the server already lets the person read (a note only appears when the partner marked
it for the home widget, a mood only when the partner shared it). The gallery in the app only shows the home widgets and teaches how to
add one; its previews are images and do nothing when tapped.

## Contract

The app is the only writer. `HomeWidgetDataService.writePayload` sanitizes a `HomeWidgetPayload` and stores it as one JSON string; the
widgets only read it and never reach the network. The payload carries facts (dates, IANA zones, enum names, times as `HH:mm`),
never display text, so each platform formats dates, plurals, relative times and mood names in the system language.

- iOS: App Group `group.dev.dalarme.mingo`, key `mingo_widget_payload`
- Android: `HomeWidgetPreferences`, key `mingo_widget_payload`
- Sign-out overwrites the store with the signed-out payload.

| Key | Type | Meaning |
| --- | --- | --- |
| `isSignedIn`, `isPaired` | bool | Session and couple state; partner fields are cleared when unpaired |
| `updatedAt` | ISO 8601 | When the payload was written |
| `theme` | `rose`, `blue`, `neutral` | The person's app theme, used as the widget accent |
| `ownName`, `partnerName` | string? | Display names, for the initials |
| `togetherSince` | `YYYY-MM-DD`? | Relationship start |
| `milestones` | `{title, on}[]` | The two latest shared story events |
| `nextDateTitle`, `nextDateOn` | string?, date? | Next important date; cleared once past |
| `cardState` | `none`, `ready`, `sent` | Where the Sunday card stands |
| `cardSendDay`, `cardSendHour` | int? | When the card goes out (`0` is Sunday) |
| `partnerNote`, `partnerNoteAt` | string?, ISO 8601? | The latest note the partner marked for the widget |
| `partnerMood`, `partnerMoodAt` | mood name?, ISO 8601? | The mood the partner shared |
| `partnerMissedAt` | ISO 8601? | The latest "missing you" from the partner |
| `ritualTitle`, `ritualWeekday`, `ritualTime` | string?, 1 to 7?, `HH:mm`? | The latest active ritual |
| `dailyIdeaTitle` | string? | The idea of the day |
| `slipsThisWeek`, `slipDays` | int, date[] | The person's own slips this week |
| `ownZone`, `partnerZone` | IANA zone? | Both clocks; `partnerZone` is cleared when equal to `ownZone` |
| `reunionTitle`, `reunionOn` | string?, date? | Next time the couple meets |

## Widgets

| `HomeWidgetKind` | iOS `kind` | Android receiver | Sizes | Works alone |
| --- | --- | --- | --- | --- |
| `counter` | `MingoCounterWidget` | `MingoCounterWidgetReceiver` | small, medium | yes |
| `partnerMood` | `MingoPartnerMoodWidget` | `MingoPartnerMoodWidgetReceiver` | small | no |
| `longing` | `MingoLongingWidget` | `MingoLongingWidgetReceiver` | small | no |
| `ritual` | `MingoRitualWidget` | `MingoRitualWidgetReceiver` | small | yes |
| `partnerNote` | `MingoPartnerNoteWidget` | `MingoPartnerNoteWidgetReceiver` | small, medium | no |
| `card` | `MingoCardWidget` | `MingoCardWidgetReceiver` | small, medium | yes |
| `distance` | `MingoDistanceWidget` | `MingoDistanceWidgetReceiver` | medium | no |
| `slip` | `MingoSlipWidget` | `MingoSlipWidgetReceiver` | small | yes |
| `nextDate` | `MingoNextDateWidget` | `MingoNextDateWidgetReceiver` | small, medium | yes |
| `week` | `MingoWeekWidget` | `MingoWeekWidgetReceiver` | medium | yes |
| `idea` | `MingoIdeaWidget` | `MingoIdeaWidgetReceiver` | medium | yes |

Names derive from the kind (`HomeWidgetKindNativeNames`), so a new kind needs its Swift widget, its Kotlin widget and receiver, and
its manifest entry.

## Native code

- iOS: `app/ios/MingoWidgets/`. `Core/` holds the payload, palette, formatting, shared views and the typed `MingoLink`; `Widgets/`
  has one file per widget. Text lives in `Resources/Localizable.xcstrings` (`en`, `pt-BR`) and is used through Xcode's generated
  symbols (`Text(.counterEyebrow)`); mood faces are template SVGs in `Assets.xcassets`. The extension targets iOS 17.
- Android: `app/android/app/src/main/kotlin/dev/dalarme/mingo/widgets/`. `core/` holds the payload, palette, bitmaps, formatting
  and base class; one file per widget with its receiver. Text lives in `res/values/mingo_widgets.xml` and `res/values-pt/`
  (plurals included) and is read through `R.string` and `R.plurals`. `MingoHomeWidgetPreviews` publishes generated previews.

## Adding a key

1. Add it to `HomeWidgetPayload` (`fromJson`, `sanitized`, `toJson`, `props`) and decide its privacy rule in `sanitized`.
2. Mirror it in `MingoPayload` (Swift) and `MingoPayload` (Kotlin).
3. Add it to the contract test in `test/features/home_widgets/data/models/home_widget_payload_contract_test.dart` and to the table above.
