# Effects, vector artwork and audio processing

Discover `creative_capabilities` and `composition_capabilities` for the selected
project/profile, then describe the relevant write contracts. The live catalog
owns installed kernels, plugin IDs, parameters and limits. A product/library
name does not authorize an upstream server, executable or unlisted effect.

## Video and composition effects

Read the saved composition, exact revision and target layer IDs. Use
`composition_edit` for a bounded change, preserving source time, trim, crop,
audio and unrelated layer settings. Effects on existing footage normally need
no new generated clip.

Native ordered `layout.effects` may include color grade, pixel effects and
geometric distortions. `layout.importedEffects` uses operator-installed ISF/OFX
plugins from the selected capability catalog. Pin the discovered identifiers,
revisions and parameter types. Do not upload executable plugins or fabricate
parameters for a missing installation. Observe layer-type and stack limits.

Order changes pixels. Distinguish per-frame effect phase from source playback
speed and layer motion; transitions and motion blur have their own contracts.
Preserve alpha and confirm edge behavior. Author explicit neutral values when
resetting a look; zero is not an omitted default.

Validate the saved revision against its exact render profile/capability
revision. Inspect a rendered frame and a short clip over the changed interval,
including transition boundaries. Browser playback or a WASM preview does not
prove that every server-rendered imported plugin has been evaluated. Finish with
the requested final render and its actual artifact checks from `compose.md`.

## Vector and audio work

`vector_process` accepts the discovered editable path commands or an owned
tracing source. Inspect the returned paths/artifact and preserve editability when
requested; a raster preview is not the editable vector output. Read the current
curve, boolean, stroke and tracing capabilities instead of assuming a full
desktop vector application is exposed.

`audio_process` applies an ordered SoundCraft DSP chain to an owned source.
Select the exact interval, sample rate, channel count and installed plugin
parameters. Poll its existing media job and verify the published audio. Use
`media_quality_check` for applicable objective checks and report actual listening
coverage separately. See `audio.md` for generated speech, music and sound effects;
native DSP and paid generation are different operations.
