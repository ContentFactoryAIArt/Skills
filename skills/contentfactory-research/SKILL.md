---
name: contentfactory-research
description: Search or collect external sources with ContentFactory research operations and import usable media into a selected project. Not for unrelated general web research.
---

# contentfactory research

Use the connected ContentFactory MCP server and stay within the user's selected projects and authorization. Search `operations_list` for the needed operations, following continuation anchors when present; use `operations_describe` to obtain the full input schema and current contract revision. Schema descriptions do not install new native tools. Invoke read operations with `operations_read` and effectful operations with `operations_execute`, supplying the exact revision and full arguments. If the contract changed, rediscover it before proceeding. Check the MCP error indicator and typed result status; a transport success alone does not prove the operation succeeded. Preserve native media or resource blocks when returned.

Use the requested sources and selected project. Discover the current research operation and its preflight/receipt contract; respect provider charges and the user's spending limit, including reserved or uncertain charges. Submit only the requested collection or search. Preserve the idempotency key for identical retries and poll a durable content-operation receipt after an uncertain outcome. Return useful source metadata and owned media references; do not assume all provider results contain downloadable media. This skill covers ContentFactory research, not general research using unrelated tools.

Build bounded download arguments from the current schema, including required message limits even for an exact Telegram post. A quote's maximum reservation is not an actual charge; narrowing the source does not necessarily lower its ceiling. Public Telegram previews may omit full large videos, and throttled YouTube pages may expose only titles/descriptions. Label findings from that evidence accordingly rather than claiming watched footage or measured performance. An unavailable tariff remains a blocker until a relevant configuration changes; do not repeat unchanged preflights or substitute a paid import without the requested spending authorization.
