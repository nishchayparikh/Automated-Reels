# Delivery report — Tech in 60 Seconds

Delivered on October 13, 2026. The application runs locally with a web process and worker, and never uses paid services or real social publishing in demo mode.

## Delivered

- Eight connected creator screens: overview, calendar, video details, review queue, generation, settings, connections, and job history. Real progress, authenticated video preview/download, edits, approval invalidation, rejection, platform schedules, retries, reconciliation and safe diagnostics.
- Strict structured stories, source provenance, evidence warnings, original scripts, original SVG graphics, five Remotion scene components, synchronized captions, bundled English narration and configurable multilingual live narration.
- Durable SQLite schema/migrations, atomic claims, rendering serialization, revision checks, leases, restart recovery, bounded retries, failure queue, timezone/DST handling, deduplication, daily backlog and spending reservations.
- Real OpenAI, ElevenLabs, R2, Instagram, Facebook Page and YouTube adapters; protected OAuth state, PKCE for Google, encrypted tokens/checkpoints, renewal and independent publication outcomes. External publishing disabled by default.
- Dockerfile and two-service Compose configuration, pinned dependencies/lockfile, `.env.example`, seed and demo runners, backup utility, deployment/provider/restore/troubleshooting documentation and an architecture diagram in README.

## Validation

`npm run build` passes. **26 tests pass** with `npm test`; provider transport is mocked explicitly. Browser validation uses actual Chrome and the running app. The complete demo created/generated the two sample stories, produced narration, rendered actual video, validated both files, approved the RAG revision and simulated publication to all three platforms.

| Sample | Duration | Frame size / rate | Codecs | Script words |
| --- | --- | --- | --- | --- |
| How RAG works | About 49.94 seconds | 1080 × 1920 / 30fps | H.264 + AAC, 48kHz | 124 |
| Redis cache outage | About 49.92 seconds | 1080 × 1920 / 30fps | H.264 + AAC, 48kHz | 125 |

Both samples fully decode with FFmpeg, have non-silent narration, and are downloadable MP4s. Mean audio levels were approximately −23.6 and −23.7dB. Audio is encoded at 128kbps for platform delivery. Demo highlighting is estimated word timing, visibly identified as sample voice; live alignment comes from ElevenLabs characters.

Frames at 2, 12, 25, 37 and 46 seconds were visually inspected for each sample. Interview, flow, analogy, failure and code scenes have readable labels, captions and clear safe margins. Code is inert pseudocode. One misleading analogy icon was corrected to a book in the RAG sample. Scene transitions use the narration timeline. No material clipping was observed. Dashboard, calendar, detail and mobile captures were inspected; browser checks report no page exceptions or horizontal document overflow.

Tests cover persistence across reopening, cross-connection locking, lease recovery, retry exhaustion, ambiguous social results, independent platform success, source-review approval gates, approval/media invalidation after edits, DST gaps/fallback, spending thresholds, strict scene bounds, URL/network restrictions, encryption and error redaction, scheduler idempotency, external-publication gate and render serialization. Adapter contracts cover Instagram container/status/final publish and uncertain-result behavior, Facebook binary transfer/finish/processing, YouTube resumable offset/native scheduling/processing and token refresh. Text/voice contracts use mock Responses and mock timestamp audio.

Real-browser tests cover eight screens, preview dimensions/duration and media errors, source restrictions, owner authentication, mutation origin and CSRF checks, development-server denial of private data/config/env files, create/reject controls, and mobile layout. Public documentation retrieval was also exercised: MDN returned a usable passage through a validated redirect; Redis returned an insufficient response and is treated as failed retrieval requiring owner review. The online backup command successfully created a consistent SQLite snapshot. Compose syntax validates. `npm audit` reports zero known vulnerabilities at the final dependency check.

Detailed measurements and screenshots are in `artifacts/demo-report.json` and `artifacts/qa/`. The final sample files are `artifacts/samples/rag.mp4` and `artifacts/samples/redis.mp4`.

## Known limits and remaining setup

- **No live paid provider or social account tests.** Keys, app permissions, app review, professional Instagram account, Facebook Page, YouTube channel/verification and private R2 bucket must be supplied/configured by the owner. Mock contract success is not live-provider certification.
- **Docker runtime not tested.** Docker CLI is installed, but no Docker daemon was running on the development host. The Compose file validates; container build/start remains a deployment smoke test on a running Docker host.
- Demo text has finished RAG and Redis explanations. Other topics get a labelled offline demonstration draft for owner rewrite; the finite seed catalog does not promise an endless stream of original mock topics.
- English sample narration is bundled. Hindi/Hinglish text and voice are live-provider options with bundled compatible fonts; multilingual voice quality and rendering were not live-tested. New demo narration on Linux/macOS needs `espeak-ng`; Windows uses SAPI.
- Source quotes can be checked for retrieval and exact matches, but automatic semantic fact verification is not claimed. Every fresh AI story requires owner evidence review. Disabling manual approval does not bypass evidence requirements.
- Visuals use five reusable scene templates. New visual concepts can need new components. No arbitrary animation engine is promised.
- Generation costs are reserved estimates, not actual invoice tracking or a provider billing guarantee. Daily planning has a durable one-hour cooldown to bound repeated planning calls when a backlog cannot be filled.
- Application-managed schedules dispatch at the due time, so platform processing can make the actual public time later. YouTube supports `publishAt` in its adapter when invoked ahead of time. Unknown publication outcomes remain in review if a platform cannot prove success or safe continuation.
- SQLite/media work storage must be persistent and local to the two processes; draft and R2 media are private. Local copies are retained for retries and previews. This release has no automatic retention/pruning policy.
- Instagram reference pages were inaccessible. The requested dark, restrained, educational-diagram format guided the original designs.

See README for exact configuration, official documentation links, deployment, backups/restoration, provider requirements and troubleshooting. No purchases, paid deployments, or real posts were performed.
