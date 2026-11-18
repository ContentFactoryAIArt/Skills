---
name: contentfactory-3d
description: Author, inspect, simulate, animate, export or render ContentFactory Blender and supported 2D scenes.
---

# ContentFactory 3D and 2D animation

Follow the [shared workflow](../contentfactory/SKILL.md). For a film, recover the director's staged action and continuity. A standalone model or still render uses its own brief.

1. Inspect exact owned inputs. Use `blender_model_inspect` for stable model nodes and actions, then discover the relevant native capabilities for geometry, materials, lighting, rigs, simulation, animation or Grease Pencil. Build a typed scene from discovered controls and retain immutable source pins.
2. For new authored animation, follow the [reference and storyboard approval procedure](../contentfactory/references/director-approval.md) before submitting moving renders, including motion tests. Stage a complete action with character, object, drawing or simulation changes. If this replaces a failed model take, preserve the beat and get approval for materially changed staging.
3. Use supported scene inspection or animation preview for material staging checks, then render the planned range. Poll the durable job and verify actual motion, contacts, occlusions, continuity and the requested output. Endpoint stills establish poses and geometry. Playback establishes how the action unfolds.
4. Use `blender_scene_export` or the supported operation for the required editable result. Check export fidelity since editable BLEND, evaluated GLB, static simulation samples and MP4 preserve different kinds of data.

See [operation routes](../contentfactory/references/operation-routes.md). Deliver owned output pins and editable state to the orchestrator when part of a film. Report a missing native capability with the affected beat or artifact.
