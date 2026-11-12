# Grok Build and local video

Use this reference when Grok Build receives a request involving video on the user's PC.

## Native connection

The installer selects `grok`, installs this bundle under `$GROK_HOME/skills` or `~/.grok/skills`, and registers the `content-factory` MCP server using Streamable HTTP. Open `/skills` to find the workflow. Invoke `/contentfactory` or let Grok select the matching specialist.

Open `/mcps`, select `content-factory`, and press `i` for ContentFactory OAuth. Complete the browser consent with the intended projects, permissions and spending limits. `grok login` handles the Grok account. After consent, use `grok mcp doctor content-factory` and an actual read-only project listing to verify the connection. Live operations still use the discovery and receipt workflow in [execution](execution.md).

## Receive a local source

Use the user's exact selected file and authorized media scope. A request to send a named local video to Grok for review authorizes that native intake within the request's scope. Reuse this authorization. Establish any missing permission before sending media to an external model.

For explicitly requested Grok-native review, use the installed client's supported video attachment or native inspection capability when available. Confirm the current tool's accepted input, media formats, byte/duration limits and actual read result. Full-video attachment syntax and limits need runtime verification for the installed Grok Build version. A local path supplies a locator. Successful access to the video content is required before describing its scenes, sound or timing.

Give Grok a request such as the following, substituting the user's selected path and actual authorization.

    /contentfactory Review my local video at "C:\Videos\clip.mp4" through the native video intake supported by this Grok build. I authorize sending this video to Grok for that review. Identify the relevant timecodes, then prepare the requested ContentFactory edit.

If native intake is unavailable, discover ContentFactory's current media inspection and upload capabilities and continue through the supported source-transfer path. State the specific native capability gap. The user can upload the selected source through ContentFactory's UI when the CLI lacks the required transfer transport.

This native review path produces observations and source-selection context. Record the reviewed file identity, coverage and relevant findings in the creative task once an owned project is available. Use the available ContentFactory operations for editable compositions, processing, generation and rendering.

## Make the source available to ContentFactory

Discover `asset_upload_capabilities`, the live upload/transfer operations and their current contracts. Prepare the authorized file using its exact byte size and lowercase SHA-256, follow the documented transfer transport, recover the receipt, and verify the completed owned asset/file pin before editing. See [execution](execution.md) and the [asset specialist](../../contentfactory-assets/SKILL.md).

Grok attachments, xAI file IDs, PC paths and ContentFactory asset/file pins belong to their respective systems. Resolve the completed ContentFactory upload to an owned immutable pin for server-side operations. Apply any format or size conversion through the supported ContentFactory path within the user's authorization.

## Capability evidence

Connection and skill routing were checked against official documentation on 2026-11-12. Grok Build 1.0.77 verified native MCP registration and installed-skill discovery on Windows. The shell installer passed isolated download/CLI fixture checks on Linux. Native full-video intake and authenticated ContentFactory execution require a live acceptance run with an authorized sample.

- [Grok Build MCP servers](https://docs.x.ai/build/features/mcp-servers)
- [Grok Build skills](https://docs.x.ai/build/features/skills-plugins-marketplaces)
- [Grok Build settings and GROK_HOME](https://docs.x.ai/build/settings)
- [Grok Build CLI reference](https://docs.x.ai/build/cli/reference)
