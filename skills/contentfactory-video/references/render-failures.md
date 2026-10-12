# Diagnose a Failed Render

Use after an observed failure, not as a routine matrix for every successful edit.
All diagnostics stay inside ContentFactory. Preserve the original composition
and pinned revision.

1. Recover the existing job and safe failure diagnostics. Pending/running is
   not failure. Confirm document revision, profile and capability revision;
   do not replace an uncertain job because its first response was lost.
2. Check what validation inspected. Structural validity does not establish
   source readability, decoding, selected streams or audio headroom. Read
   `inspectMedia`, `inspectAudioMix` results and actual preflight flags.
3. Follow the reported class:

| Failure | Native next check |
| --- | --- |
| AUDIO_CLIPPING | Audio policy, overlaps, duplicate tracks, gains and fades; correct and revalidate. |
| SOURCE_UNAVAILABLE / ACCESS_REVOKED | Owned asset/file, permission, availability and digest. |
| CAPABILITIES_CHANGED / UNSUPPORTED / LIMIT_EXCEEDED | Refresh the named profile, feature or limit. |
| INVALID_DOCUMENT | Complete typed violations and paths. |
| RENDER_FAILED | Preserve receipt and safe diagnostics; isolate a reproducible source interval. |

4. If necessary, create a small diagnostic composition with the same failing
   source interval/profile. Begin with one visual layer, then add its embedded
   audio, separate audio and effects individually. For many layers, bisect
   groups. Retain enough duration to reproduce the actual failure. Change one
   variable per attempt and stop when explained or when the authorized budget
   cannot support another attempt.
5. Native audio extraction can isolate a stream while preserving its timing.
   A passing reproduction after extraction does not show that all embedded
   video audio is broken. Do not make the diagnostic workaround universal.

Correct the intended composition, save a new revision, validate and render.
Recover prior receipts before new keys. Verify the actual final export, not
only the diagnostic preview. If unresolved, report revision/job, failure class,
minimal failing interval/layer and validation flags without secrets or raw
provider payloads.
