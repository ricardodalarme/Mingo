# Widget payload contract

One compact JSON document is written to the shared native store and read by both widget extensions. The app is the only
writer: `WidgetDataService.writePayload` sanitizes the model before serializing it, and sign-out overwrites the store with a
neutral payload. Native code never writes a payload and never asks the server for extra data. Each platform decodes the keys
it renders and ignores the optional keys it does not.

- iOS: App Group `group.dev.dalarme.mingo`, key `mingo_widget_payload`
- Android: `HomeWidgetPreferences`, key `mingo_widget_payload`
- Photo cache (Plus, paired only): `mingo_widget_photo_path`, with `mingo_widget_photo_updated_at`

## Keys

| Key | Type | What it carries | Privacy |
| --- | --- | --- | --- |
| `isSignedIn` | bool | Whether a session wrote this payload | Sign-out replaces the whole payload |
| `isPaired` | bool | Whether there is an active couple | Couple families show a neutral invite state otherwise |
| `hasPlus` | bool | Whether the couple photo family may run | Photos stay after v1; the gallery hides the family |
| `showNames` | bool | Names and initials are allowed | `partnerName`, `ownName` are cleared when false |
| `allowPartnerNotes` | bool | Partner notes are allowed | `partnerNote*` is cleared when false |
| `onLockScreen` | bool | Lock-screen family is allowed | The family itself never reads personal fields |
| `isOffline` | bool | Last write came from the cached payload | UI only; native does not show a special banner |
| `togetherSince` | date `YYYY-MM-DD` | Relationship start, local date | Counter and duration only |
| `relationshipPhase` | string | `dating`, `married`, `livingTogether`, ... | Counter subtitle only |
| `partnerName` | string? | Partner display name | Cleared when `showNames` is false or unpaired |
| `ownName` | string? | Viewer display name | Cleared when `showNames` is false |
| `nextDateTitle` | string? | Next important date title | Cleared when the date is in the past or unpaired |
| `nextDateOn` | date `YYYY-MM-DD`? | Next important date | Same as above |
| `unopenedCards` | int | Number of cards not opened | Zero when unpaired; never a score |
| `cardState` | string | `none`, `ready`, `sent` | `none` when unpaired |
| `cardSendDay` | int? | Notification card day, `0` = Sunday | Cleared when unpaired |
| `cardSendHour` | int? | Notification card hour | Cleared when unpaired |
| `partnerNote` | string? | Latest note the partner marked `forWidget` | Cleared when `allowPartnerNotes` is false or unpaired |
| `partnerNoteMedia` | string? | Optional media file id for that note | Same as `partnerNote` |
| `partnerNoteAt` | ISO 8601? | When the note arrived | Same as `partnerNote` |
| `partnerMood` | string? | Mood the partner chose to share | Only read from `shared_moods`; cleared when unpaired |
| `partnerMoodAt` | ISO 8601? | When the shared mood was updated | Cleared when `partnerMood` is absent |
| `partnerMissedAt` | ISO 8601? | Latest `miss_us` signal from the partner | Cleared when unpaired |
| `myMood` | string? | Viewer's latest mood | Private; never a partner field |
| `ritualTitle` | string? | Latest active ritual title | Shared in-app; no text from slips |
| `ritualSchedule` | string? | Formatted weekday and time | Same as `ritualTitle` |
| `dailyIdeaTitle` | string? | Daily idea title | Public content |
| `slipsCount` | int | Total slips the viewer saved | Personal; never compared |
| `slipsThisWeek` | int | Slips saved this week | Personal; powers "Minha semana" |
| `slipDays` | string[] | Dates (local) with a saved slip this week | Personal; only weekday marks are shown |
| `suggestionKey` | string? | Reserved for an in-app suggestion | Not rendered natively |
| `cachedPhotoPath` | string? | Local cached photo path | Cleared unless paired and Plus |
| `ownZone` | string? | Viewer IANA time zone | Only for the distance family |
| `partnerZone` | string? | Partner IANA time zone | Cleared when unpaired or equal to `ownZone` |
| `ownLocalTime` | `HH:mm`? | Viewer local time | Only for the distance family |
| `partnerLocalTime` | `HH:mm`? | Partner local time | Only for the distance family |
| `reunionTitle` | string? | Next reunion date title | Only for the distance family |
| `reunionOn` | date? | Next reunion date | Only for the distance family |
| `reunionDays` | int? | Days until the reunion | Only for the distance family |
| `updatedAt` | ISO 8601 | When the payload was written | Debugging only |

## Native families

| Dart `WidgetFamilyKind` | iOS `kind` | Android provider | Shape |
| --- | --- | --- | --- |
| `ownSmall` | `MingoOwnSmallWidget` | `MingoOwnSmallWidgetProvider` | 2×2 |
| `ownMedium` | `MingoOwnMediumWidget` | `MingoOwnMediumWidgetProvider` | 4×2 |
| `lockScreen` | `MingoLockScreenWidget` | — | accessory (iOS only) |
| `coupleCounter` | `MingoCoupleCounterWidget` | `MingoCoupleCounterWidgetProvider` | 2×2 / 4×2 |
| `couplePhotos` | `MingoCouplePhotosWidget` (not in the bundle) | `MingoCouplePhotosWidgetProvider` (not in the manifest) | deferred after v1; kept in the data layer |
| `partnerNote` | `MingoPartnerNoteWidget` | `MingoPartnerNoteWidgetProvider` | 2×2 / 4×2 |
| `partnerMood` | `MingoPartnerMoodWidget` | `MingoPartnerMoodWidgetProvider` | 2×2 |
| `longing` | `MingoLongingWidget` | `MingoLongingWidgetProvider` | 2×2 |
| `cardEncounter` | `MingoCardEncounterWidget` | `MingoCardEncounterWidgetProvider` | 2×2 / 4×2 |
| `distance` | `MingoDistanceWidget` | `MingoDistanceWidgetProvider` | 4×2 |

The small and medium personal widgets rotate through their content; the gallery previews each content variant but labels the
actual native family. The lock-screen family only exists on iOS; Android shows the honest explanation instead of a preview.

## Adding a key

1. Add it to `WidgetPayload`, `fromJson`, `sanitized`, `copyWith`, `toJson` and `props`.
2. Decide its privacy gate in `sanitized`; never clear it in native code.
3. Mirror it in `MingoWidgetPayload` (Swift) and `MingoWidgetPayload` (Kotlin); both decode optional keys.
4. Add a contract test in `test/features/widgets/data/models/widget_payload_contract_test.dart`.
5. Update this table.
