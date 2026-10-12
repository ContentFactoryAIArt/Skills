# Speech, Music and Sound Effects

Reuse accepted recordings and voices. Recover pending audio receipts before
requesting replacements. A supplied voice recording does not itself authorize
voice cloning. Discover speech models/voices, preflight and synthesize the exact
chosen narration in the intended language. Transcribe existing speech only when
its missing words matter; an intake request does not authorize rewriting it.

Generate requested music and sound effects with dedicated models through
ContentFactory `music_compose` and `sound_effects_generate`, when exposed.
Discover current versions and exact `content_operation_preflight` quotes.
Provider names in catalogs do not authorize calling their APIs or another MCP.
Never replace missing music/effect generation with local oscillators, scripts
or a sound effect stretched across the entire soundtrack.

A quote-only request is not spending authorization. Distinguish unavailable
pricing, insufficient balance and a ceiling below the quote. Preserve existing
receipts and continue independent editing; do not retry an unchanged missing
tariff, invent a price or silently omit requested music.

## Musical Direction

For ordinary promotional work, use balanced tone, restrained transients and
comfortable relative levels. Keep incidental effects short and subordinate to
the music. A harsh source rejected by the user needs replacement; lowering its
gain alone does not change its timbre. Preserve deliberate abrasive aesthetics
when explicitly part of the brief.

Distinct showcase cases need distinct musical ideas when variety is requested.
Offsets, gains and playback rates of one track do not create that variety.
Preserve specifically liked clips as quality references. Shape entrances and
endings in Compose and check abrupt cuts, masking and balance in the real export.
A favorable model report or clipping pass cannot prove listening comfort.

## Timing and Listening

Measure duration and fit the edit. Use `speech_align` only when word-level
captions or synchronization need it. For avatars, reuse accepted narration,
discover the supported generation/preparation path, account for dependent costs
and preserve usable muxed timing. Avoid duplicate voice tracks.

Listen to ContentFactory native audio blocks when the client supports them.
`media_audio_extract`, its native job wait and `media_audio_preview` can provide
bounded intervals from an owned source. Discover their current limits and
selectors. For longer review, cover ordered intervals without gaps rather than
assuming one preview contains the entire source.

When extraction to the actual decoded end is needed, describe the live
`audio.untilSourceEnd` contract before using it. If supported, supply the exact
start and omit a conflicting bounded end. Otherwise retain valid explicit
intervals; do not shrink guessed endpoints until a request happens to pass.
Use supported sample rates, channels and stream selection. Preserve returned
sample counts and resolved duration, and disclose an extraction limit instead
of treating a truncated source as complete.

Record intervals actually heard, stream and source offsets, selected asset/file,
model/voice, receipt and cost. Returning an audio block is not proof of listening.
If this client cannot play it, say so and use only the evidence available through
ContentFactory. A full-duration audio stream does not establish correct words,
uncut endings, balance or the presence of the requested musical idea.
