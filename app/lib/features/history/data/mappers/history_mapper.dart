import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/history/data/data_sources/remote/queries/generated/HistoryOverview.graphql.dart';
import 'package:app/features/history/data/mappers/history_enum_mapper.dart';
import 'package:app/features/history/data/models/history_models.dart';
import 'package:app/features/history/data/models/story_event_kind.dart';
import 'package:app/features/profile/data/mappers/avatar_kind_mapper.dart';
import 'package:app/features/profile/data/mappers/relationship_phase_mapper.dart';
import 'package:app/features/profile/data/mappers/relationship_status_mapper.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:app/features/profile/data/models/relationship_status.dart';
import 'package:clock/clock.dart';

/// Rows shown per list.
const int _pageSize = 50;

extension HistoryOverviewMapper on QueryHistoryOverview {
  HistoryOverview toModel({DateTime? now}) {
    final currentNow = now ?? clock.now();
    final selfProfile = profile;
    final settingsNode = settings;
    final selfId = selfProfile?.id ?? settingsNode?.userId ?? '';
    final selfName = (selfProfile?.displayName ?? '').trim();
    final couple = member?.couple;
    final coupleId = couple?.id;
    final partnerProfile = couple?.members
        .where((coupleMember) => coupleMember.userId != selfId)
        .firstOrNull
        ?.profile;
    final partnerNameRaw = (partnerProfile?.displayName ?? settingsNode?.partnerName ?? '').trim();
    final partnerName = partnerNameRaw.isEmpty ? null : partnerNameRaw;
    final isPaired = coupleId != null;

    final selfInitials = _initials(selfName, fallback: 'V');
    final partnerInitials = partnerName != null ? _initials(partnerName, fallback: '+') : null;
    final avatarKind = selfProfile?.avatarKind.toModel() ?? AvatarKind.initials;
    final phase = settingsNode?.phase?.toModel() ?? RelationshipPhase.dating;
    final relationshipStatus =
        settingsNode?.relationshipStatus.toModel() ?? RelationshipStatus.together;

    final storyNodes = storyEvents.take(_pageSize).toList();
    final memoryNodes = memories.take(_pageSize).toList();
    final dateNodes = [
      for (final node in importantDates.take(_pageSize))
        if (!node.hidden) node,
    ];

    final storyDates = _buildStoryDates(
      storyNodes: storyNodes,
      selfId: selfId,
      partnerName: partnerName,
      settingsTogetherSince: settingsNode?.togetherSince,
    );

    final hasMoreMemories = memories.length > _pageSize;
    final hasMoreHistory =
        storyEvents.length > _pageSize || hasMoreMemories || importantDates.length > _pageSize;

    final effectiveTogetherSince =
        settingsNode?.togetherSince ?? storyDates.dating.date ?? storyDates.met.date;

    final milestones = <HistoryMilestone>[];
    final places = <String>[];

    for (final node in storyNodes) {
      final isMine = node.authorId == selfId;
      milestones.add(
        HistoryMilestone(
          id: node.id,
          source: MilestoneSource.storyEvent,
          kind: node.kind.toMilestoneKind(),
          title: (node.title != null && node.title!.trim().isNotEmpty)
              ? node.title!.trim()
              : _defaultStoryEventTitle(node.kind.toMilestoneKind()),
          date: node.happenedOn,
          precision: node.datePrecision.toModel(),
          isShared: node.coupleId != null,
          isMine: isMine,
          authorName: isMine ? null : partnerName,
        ),
      );
    }

    for (final node in memoryNodes) {
      final isMine = node.authorId == selfId;
      final place = node.place?.trim();
      if (place != null && place.isNotEmpty) {
        places.add(place);
      }
      milestones.add(
        HistoryMilestone(
          id: node.id,
          source: MilestoneSource.memory,
          kind: node.origin.toMilestoneKind(place: place),
          title: node.title,
          body: node.body,
          place: (place == null || place.isEmpty) ? null : place,
          date: node.happenedOn,
          precision: node.datePrecision.toModel(),
          isShared: node.coupleId != null,
          isMine: isMine,
          authorName: isMine ? null : partnerName,
        ),
      );
    }

    DateTime? nextReunionDate;
    final todayUtc = DateTime.utc(currentNow.year, currentNow.month, currentNow.day);

    for (final node in dateNodes) {
      if (node.kind == EnumImportantDateKind_enum.birthday ||
          node.kind == EnumImportantDateKind_enum.holiday) {
        continue;
      }
      final isMine = node.authorId == selfId;
      final year = node.year;
      final resolvedDate = year == null ? null : DateTime(year, node.month, node.day);

      if (node.kind == EnumImportantDateKind_enum.reunion && resolvedDate != null) {
        final reunionUtc = DateTime.utc(resolvedDate.year, resolvedDate.month, resolvedDate.day);
        if (!reunionUtc.isBefore(todayUtc) &&
            (nextReunionDate == null || reunionUtc.isBefore(nextReunionDate))) {
          nextReunionDate = reunionUtc;
        }
      }

      milestones.add(
        HistoryMilestone(
          id: node.id,
          source: MilestoneSource.importantDate,
          kind: node.kind.toMilestoneKind(),
          title: node.title,
          date: resolvedDate,
          precision: year == null ? MilestoneDatePrecision.unknown : MilestoneDatePrecision.day,
          isShared: node.coupleId != null,
          isMine: isMine,
          authorName: isMine ? null : partnerName,
        ),
      );
    }

    milestones.sort(_compareMilestones);

    final recapNode = yearRecaps.firstOrNull;
    final yearRecap = recapNode == null
        ? null
        : HistoryYearRecap(
            year: recapNode.year ?? currentNow.year,
            memories: recapNode.memories ?? 0,
            firsts: recapNode.firsts ?? 0,
            slips: recapNode.slips ?? 0,
            cardsSent: recapNode.cardsSent ?? 0,
            ritualsDone: recapNode.ritualsDone ?? 0,
          );

    final numbers = HistoryNumbers.compute(
      togetherSince: effectiveTogetherSince,
      now: currentNow,
      places: places,
      yearRecap: yearRecap,
    );

    return HistoryOverview(
      selfId: selfId,
      selfName: selfName,
      selfInitials: selfInitials,
      partnerName: partnerName,
      partnerInitials: partnerInitials,
      isPaired: isPaired,
      coupleId: coupleId,
      avatarKind: avatarKind,
      phase: phase,
      relationshipStatus: relationshipStatus,
      togetherSince: effectiveTogetherSince,
      nextReunionDate: nextReunionDate,
      memoryCount: memoryNodes.length,
      hasMoreMemories: hasMoreMemories,
      hasMoreHistory: hasMoreHistory,
      milestones: milestones,
      storyDates: storyDates,
      numbers: numbers,
    );
  }
}

StoryDatesSummary _buildStoryDates({
  required List<QueryHistoryOverviewstoryEvents> storyNodes,
  required String selfId,
  required String? partnerName,
  required DateTime? settingsTogetherSince,
}) {
  StoryDateEntry entryFor(StoryEventKind kind) {
    QueryHistoryOverviewstoryEvents? match;
    for (final node in storyNodes) {
      if (node.kind != kind.toRemote()) continue;
      if (node.authorId == selfId) {
        match = node;
        break;
      }
      match ??= node;
    }
    if (match == null) return StoryDateEntry(kind: kind);
    final isMine = match.authorId == selfId;
    return StoryDateEntry(
      id: match.id,
      kind: kind,
      date: match.happenedOn,
      precision: match.datePrecision.toModel(),
      isShared: match.coupleId != null,
      isMine: isMine,
      authorName: isMine ? null : partnerName,
    );
  }

  var selfStart = settingsTogetherSince;
  DateTime? partnerStart;

  for (final node in storyNodes) {
    if (node.kind == EnumStoryEventKind_enum.dating || node.kind == EnumStoryEventKind_enum.met) {
      if (node.authorId == selfId) {
        selfStart ??= node.happenedOn;
      } else {
        partnerStart ??= node.happenedOn;
      }
    }
  }

  return StoryDatesSummary(
    met: entryFor(StoryEventKind.met),
    dating: entryFor(StoryEventKind.dating),
    engaged: entryFor(StoryEventKind.engaged),
    married: entryFor(StoryEventKind.married),
    selfStartDate: selfStart,
    partnerStartDate: partnerStart,
  );
}

int _compareMilestones(HistoryMilestone a, HistoryMilestone b) {
  final dateA = a.date;
  final dateB = b.date;
  if (dateA == null && dateB == null) return a.title.compareTo(b.title);
  if (dateA == null) return 1;
  if (dateB == null) return -1;
  return dateA.compareTo(dateB);
}

String _initials(String name, {required String fallback}) {
  final trimmed = name.trim();
  if (trimmed.isEmpty) return fallback;
  return trimmed.characters.first.toUpperCase();
}

String _defaultStoryEventTitle(MilestoneKind kind) => switch (kind) {
  MilestoneKind.met => 'Nos conhecemos',
  MilestoneKind.dating => 'Começamos a namorar',
  MilestoneKind.engaged => 'Noivamos',
  MilestoneKind.married => 'Casamos',
  _ => 'Marco',
};

extension _StringCharacters on String {
  Iterable<String> get characters sync* {
    for (final rune in runes) {
      yield String.fromCharCode(rune);
    }
  }
}
