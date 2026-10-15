# Continuing work in the editors

Honor the user's chosen medium. A still photo can remain a photo, a 3D model can
remain editable, and a timeline correction can reuse its existing footage.
Use the verified MCP connection for agent operations; the user can open the
ContentFactory browser editor for interactive work.

- **Photo:** preserve source asset/file and the exact photo job settings. Deliver
  the processed image and, when requested, an immutable named recipe. A flattened
  image is not a layered photo document; do not promise unsupported interchange.
- **Video:** retain composition ID and immutable revision. Read filtered layers
  and changes when useful, edit by stable IDs with `expectedRevision`, validate,
  and deliver the editable composition together with the requested render.
  Discover native composition import/export operations when interchange is
  requested; a preview clip is not a composition package or final export.
- **3D:** retain typed scene/animation settings from the durable job. Choose GLB
  for supported static interchange or packed BLEND for an editable native scene.
  Reopening BLEND is restricted to exact editor exports owned by that project;
  arbitrary uploaded BLEND files are not supported. PNG/MP4 outputs are renders,
  not editable scene documents.

Do not reconstruct a timeline or scene from screenshots when native state exists.
Recover `creative_tasks_list` / `creative_task_get`, operation receipts and the
saved revision after context loss. Save a concise `creative_task_save` record
when needed for resumption, without passwords, OAuth data or local paths.

Return links provided by native artifact/transfer results and identify what each
link opens or downloads. Do not invent editor URL routes. If a native result
contains no direct editor link, give the project and composition/asset identifiers
and tell the user where to select them in ContentFactory. Generated download
tickets expire and do not themselves mean that a file was saved locally.
