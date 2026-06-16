# Timezone — a typed, comptime-baked IANA zone. Every offset transition, every
# type definition, the POSIX-footer extrapolation rule — all inlined as comptime
# `InlineArray` data, so the whole zone is part of the compiled binary. Zero
# runtime I/O at all; the library is fully self-contained.
#
# Each IANA zone lives in its own file under `chrono/timezones/<area>/<location>.mojo`
# as a single `comptime` constant. A zone shared by multiple countries (e.g.
# Asia/Bangkok used by TH/CX/KH/LA/VN) is defined ONCE and imported by every
# country that references it — Mojo's import system deduplicates at compile time.
#
# Facets: tier T0 (spine) | safety sound | quantum n/a.
# Honesty: data extracted from IANA TZif (2026b) at build time — the same
# numbers Python `zoneinfo` and every libc tz reader produce. The Timezone
# STRUCT is chrono's; the DATA is IANA's.

from std.collections.inline_array import InlineArray

from chrono.continent import Continent
from chrono._core.civil import (
    days_since_epoch_from_date,
    date_from_days_since_epoch,
    weekday_from_days_since_epoch,
    days_in_month,
)
from chrono._core.units import SECONDS_PER_DAY, DAYS_PER_WEEK


@always_inline
def _posix_day_of_month(year: Int, month: Int, week: Int, weekday: Int) -> Int:
    """POSIX Mm.w.d -> civil day of the month. Inlined here so Timezone.offset_at
    doesn't reach across modules."""
    var first_dow = weekday_from_days_since_epoch(
        days_since_epoch_from_date(year, month, 1)
    )
    var first_occurrence = 1 + (
        (weekday - first_dow + DAYS_PER_WEEK) % DAYS_PER_WEEK
    )
    var day = first_occurrence + DAYS_PER_WEEK * (week - 1)
    if day > days_in_month(year, month):
        day -= DAYS_PER_WEEK
    return day


@always_inline
def _posix_transition_utc(
    year: Int,
    month: Int,
    week: Int,
    weekday: Int,
    time_seconds: Int,
    offset_before: Int,
) -> Int64:
    """UTC epoch-seconds of a POSIX-rule transition."""
    var day = _posix_day_of_month(year, month, week, weekday)
    var local = Int64(
        days_since_epoch_from_date(year, month, day)
    ) * SECONDS_PER_DAY + Int64(time_seconds)
    return local - Int64(offset_before)


struct Timezone[transition_count: Int, type_count: Int](
    ImplicitlyCopyable, Movable
):
    """An IANA time-zone with `transition_count` historical offset changes and
    `type_count` distinct offset/DST pairs. Each transition picks one of the
    type entries; everything past the final transition is covered by the POSIX
    rule (`posix_has_rule`)."""

    var name: StaticString  # full IANA name, e.g. "Asia/Ho_Chi_Minh"
    var area: StaticString  # "Asia"
    var location: StaticString  # "Ho_Chi_Minh"
    var continent: Continent

    # Transition table: at instant >= transitions[i], the active type is type_indices[i].
    var transitions: InlineArray[Int64, Self.transition_count]
    var type_indices: InlineArray[UInt8, Self.transition_count]

    # Type table: distinct (offset, is_dst) pairs the transitions point into.
    var offsets: InlineArray[Int32, Self.type_count]
    var is_dst: InlineArray[UInt8, Self.type_count]

    # POSIX footer rule — governs instants past the final transition. Twelve
    # i32 fields: std/dst offsets (seconds east of UTC), then for each of the
    # start and end transition (4 fields each) the month (1..12), week (1..5,
    # `Mm.w.d` form per POSIX), day (0..6, 0 = Sunday), and time-of-day (seconds
    # past midnight in local time). `posix_has_rule` gates whether the rule is
    # applied; `posix_has_dst` distinguishes a single-offset POSIX zone from a
    # DST-cycling one.
    var posix_has_rule: Bool
    var posix_has_dst: Bool
    var posix_std_offset: Int32
    var posix_dst_offset: Int32
    var posix_start_month: Int32
    var posix_start_week: Int32
    var posix_start_day: Int32
    var posix_start_time: Int32
    var posix_end_month: Int32
    var posix_end_week: Int32
    var posix_end_day: Int32
    var posix_end_time: Int32

    @always_inline
    def __init__(
        out self,
        name: StaticString,
        area: StaticString,
        location: StaticString,
        continent: Continent,
        var transitions: InlineArray[Int64, Self.transition_count],
        var type_indices: InlineArray[UInt8, Self.transition_count],
        var offsets: InlineArray[Int32, Self.type_count],
        var is_dst: InlineArray[UInt8, Self.type_count],
        posix_has_rule: Bool = False,
        posix_has_dst: Bool = False,
        posix_std_offset: Int32 = 0,
        posix_dst_offset: Int32 = 0,
        posix_start_month: Int32 = 0,
        posix_start_week: Int32 = 0,
        posix_start_day: Int32 = 0,
        posix_start_time: Int32 = 0,
        posix_end_month: Int32 = 0,
        posix_end_week: Int32 = 0,
        posix_end_day: Int32 = 0,
        posix_end_time: Int32 = 0,
    ):
        self.name = name
        self.area = area
        self.location = location
        self.continent = continent
        self.transitions = transitions^
        self.type_indices = type_indices^
        self.offsets = offsets^
        self.is_dst = is_dst^
        self.posix_has_rule = posix_has_rule
        self.posix_has_dst = posix_has_dst
        self.posix_std_offset = posix_std_offset
        self.posix_dst_offset = posix_dst_offset
        self.posix_start_month = posix_start_month
        self.posix_start_week = posix_start_week
        self.posix_start_day = posix_start_day
        self.posix_start_time = posix_start_time
        self.posix_end_month = posix_end_month
        self.posix_end_week = posix_end_week
        self.posix_end_day = posix_end_day
        self.posix_end_time = posix_end_time

    def offset_at(self, epoch_seconds: Int64) -> Int32:
        """The east-of-UTC offset (seconds) effective at `epoch_seconds`.

        Past the last stored transition the POSIX footer rule governs (so
        post-2037 dates stay DST-correct). Before the first transition we
        return the first non-DST type (or type 0 if none qualifies).

        The `comptime if` splits the zero-transition zones (Etc/UTC,
        Etc/GMT*, …) onto their own code path — InlineArray[T, 0] doesn't
        type-check indexing, so the table-search branch must be elided."""
        comptime if Self.transition_count == 0:
            # No transitions at all — POSIX rule if present, else type-0 offset.
            if self.posix_has_rule:
                return self._posix_offset(epoch_seconds)
            return self.offsets[0] if Self.type_count > 0 else Int32(0)
        else:
            var n = Self.transition_count
            # POSIX footer governs the future. Use `>` (not `>=`): the final
            # stored transition itself is authoritative (the IANA generator
            # places that transition there for a reason), and POSIX only kicks
            # in past it. A POSIX rule that disagrees with the type at the
            # final transition is now visible as a mismatch instead of being
            # silently overridden.
            if self.posix_has_rule:
                if epoch_seconds > self.transitions[n - 1]:
                    return self._posix_offset(epoch_seconds)
            # Before the first transition: first non-DST type (LMT-ish).
            if epoch_seconds < self.transitions[0]:
                for i in range(Self.type_count):
                    if self.is_dst[i] == 0:
                        return self.offsets[i]
                return self.offsets[0]
            # Binary search for the transition at or before `epoch_seconds`.
            var lo = 0
            var hi = n - 1
            var idx = 0
            while lo <= hi:
                var mid = (lo + hi) // 2
                if self.transitions[mid] <= epoch_seconds:
                    idx = mid
                    lo = mid + 1
                else:
                    hi = mid - 1
            return self.offsets[Int(self.type_indices[idx])]

    def _posix_offset(self, epoch_seconds: Int64) -> Int32:
        """Apply the POSIX footer rule (caller checks posix_has_rule)."""
        if not self.posix_has_dst:
            return self.posix_std_offset
        var days = epoch_seconds // SECONDS_PER_DAY
        var year = date_from_days_since_epoch(Int(days)).year
        var start_utc = _posix_transition_utc(
            year,
            Int(self.posix_start_month),
            Int(self.posix_start_week),
            Int(self.posix_start_day),
            Int(self.posix_start_time),
            Int(self.posix_std_offset),
        )
        var end_utc = _posix_transition_utc(
            year,
            Int(self.posix_end_month),
            Int(self.posix_end_week),
            Int(self.posix_end_day),
            Int(self.posix_end_time),
            Int(self.posix_dst_offset),
        )
        if start_utc <= end_utc:
            # Northern hemisphere: DST is [start, end)
            if epoch_seconds >= start_utc and epoch_seconds < end_utc:
                return self.posix_dst_offset
            return self.posix_std_offset
        # Southern hemisphere: DST wraps the new year
        if epoch_seconds >= start_utc or epoch_seconds < end_utc:
            return self.posix_dst_offset
        return self.posix_std_offset

    def local_lookup(self, local_seconds: Int64, fold: Bool) -> Int32:
        """Resolve a LOCAL wall-clock time (epoch-seconds as if UTC) to its
        offset, with PEP 495 fold/gap disambiguation.

        Algorithm: enumerate every distinct offset the zone could be in
        (every historical type offset + the POSIX std/dst rule offsets) and
        check each via `offset_at(L - O) == O`. A valid O means some real
        instant exists whose wall-clock rendering through O equals L.

          0 valid  -> gap (wall-clock did not occur). Walk the transition
                      table for the spring-forward window that contains L
                      and return its pre-gap offset (fold=False) or
                      post-gap offset (fold=True). Falls back to ±1 day
                      sampling for the POSIX-future region, where POSIX
                      rules guarantee at most one transition per direction
                      per year so the bracket is safe.
          1 valid  -> unambiguous; return it.
          2 valid  -> fold (wall-clock occurred twice). Return the larger
                      offset (chronologically first, e.g. EDT before
                      fall-back) for fold=False, the smaller for fold=True.

        The candidate enumeration is independent of transition spacing —
        a zone with two transitions inside a 24-hour window resolves the
        same way as the common case. The previous ±1-day-bracket
        implementation had a latent miscompute in that edge case."""
        var first_valid: Int32 = 0
        var second_valid: Int32 = 0
        var found_count: Int = 0

        # Enumerate historical type offsets.
        comptime if Self.type_count > 0:
            for i in range(Self.type_count):
                var candidate = self.offsets[i]
                if (
                    self.offset_at(local_seconds - Int64(candidate))
                    == candidate
                ):
                    if found_count == 0:
                        first_valid = candidate
                        found_count = 1
                    elif candidate != first_valid and found_count == 1:
                        second_valid = candidate
                        found_count = 2

        # Enumerate POSIX-rule offsets (cover the post-final-transition region).
        if self.posix_has_rule:
            var p_std = self.posix_std_offset
            if self.offset_at(local_seconds - Int64(p_std)) == p_std:
                if found_count == 0:
                    first_valid = p_std
                    found_count = 1
                elif p_std != first_valid and found_count == 1:
                    second_valid = p_std
                    found_count = 2
            if self.posix_has_dst:
                var p_dst = self.posix_dst_offset
                if (
                    p_dst != p_std
                    and self.offset_at(local_seconds - Int64(p_dst)) == p_dst
                ):
                    if found_count == 0:
                        first_valid = p_dst
                        found_count = 1
                    elif p_dst != first_valid and found_count == 1:
                        second_valid = p_dst
                        found_count = 2

        # Two valid -> fold. Larger offset is the chronologically first
        # occurrence (e.g. EDT just before fall-back); smaller is second.
        if found_count == 2:
            var larger: Int32
            var smaller: Int32
            if first_valid > second_valid:
                larger = first_valid
                smaller = second_valid
            else:
                larger = second_valid
                smaller = first_valid
            return smaller if fold else larger

        # One valid -> unambiguous.
        if found_count == 1:
            return first_valid

        # Zero valid -> gap. Walk the transition table for the spring-forward
        # window that contains L. Each transition i has a gap iff
        # post_offset > pre_offset; the wall-clock gap is then
        # [transitions[i] + pre_offset, transitions[i] + post_offset).
        comptime if Self.transition_count > 0:
            for i in range(Self.transition_count):
                var pre_offset: Int32 = 0
                if i > 0:
                    pre_offset = self.offsets[Int(self.type_indices[i - 1])]
                else:
                    # Before the first transition: first non-DST type
                    # (LMT-ish), matching offset_at's pre-first-transition
                    # logic.
                    comptime if Self.type_count > 0:
                        var seen = False
                        for k in range(Self.type_count):
                            if self.is_dst[k] == 0:
                                pre_offset = self.offsets[k]
                                seen = True
                                break
                        if not seen:
                            pre_offset = self.offsets[0]
                var post_offset = self.offsets[Int(self.type_indices[i])]
                if post_offset > pre_offset:
                    var pre_wall = self.transitions[i] + Int64(pre_offset)
                    var post_wall = self.transitions[i] + Int64(post_offset)
                    if pre_wall <= local_seconds and local_seconds < post_wall:
                        return pre_offset if not fold else post_offset

        # POSIX-future gap (past the final stored transition) or no
        # historical match: ±1 day sampling. POSIX rules emit at most one
        # transition per direction per year, so the bracket is safe here.
        var off_before = self.offset_at(local_seconds - 86400)
        var off_after = self.offset_at(local_seconds + 86400)
        return off_after if fold else off_before
