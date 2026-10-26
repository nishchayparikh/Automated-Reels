# Local storage update — October 13, 2026

The existing application in `C:/Users/nishc/Desktop/reels` now defaults to the owner's filesystem. `.env` and `.env.example` use `STORAGE_PROVIDER=local` and `LOCAL_STORAGE_PATH=./data/media`. Other environment values were preserved. No Cloudflare, OpenAI or ElevenLabs account is needed for the manual script/recording workflow.

## Completed

- Completed configuration and deployment wiring around the existing local/R2 storage abstraction. New uploads and renders retain portable provider/key/size/hash/type metadata. Legacy references remain readable without silent migration.
- Added startup directory initialization, protected-folder validation and a storage readiness/folder panel in Connections. Private media cannot be configured in frontend public/build directories or the application root.
- Preserved authenticated narration/video playback and downloads with byte ranges, actionable missing-file and storage errors, and generated file identifiers. Unsafe traversal, junction/symlink and hardlink accesses are rejected.
- Preserved direct local-file Facebook/YouTube uploads and scoped, expiring Instagram video delivery. Missing public HTTPS hosting blocks only Instagram URL delivery. No tunnel or public exposure was configured.
- Preserved the optional R2 adapter and explicit copy/verify/update migration. Added `npm run migrate:r2`; default dry-run lists candidates without downloading objects or changing media references. Remote originals are never deleted.
- Updated Docker Compose so both processes share the same host media folder at `/app/media`, chosen using `MEDIA_HOST_PATH`, while retaining the named SQLite/work volume. Documented non-root folder permissions and existing-volume compatibility.
- Updated Docker exclusions and README backup/restore instructions, including custom media paths and separate database/media backups.
- Added 12 storage tests and an isolated HTTP/render/persistence verification runner (`npm run test:storage-http`).

## Checks actually completed

- `npm test`: **50 passed, 0 failed**. Includes storage identifiers and unsafe links, old reference compatibility, directory/capacity/permission error classification, delivery expiry/tampering/revocation, missing public origin, and fixture-based migration verification/failure handling. Existing manual workflow and provider contract tests also passed.
- `npm run build`: TypeScript checking and production frontend build passed.
- `docker compose config --quiet`: passed.
- Isolated HTTP verification passed with no configured AI/R2 credentials: authenticated narration upload/normalization and range playback; unauthorized upload/preview, CSRF, corrupt audio and raw-folder access rejection; actionable missing-file HTTP 404; restored audio remained usable.
- Complete Remotion render passed: **49.941 seconds, 1080 × 1920, 30 fps, H.264/AAC, 2,457,224 bytes**. Full decode and audio level checks passed (mean -23.6 dB). Preview/download hashes matched the stored file; range requests returned correct bytes and out-of-range requests returned HTTP 416.
- Instagram, Facebook and YouTube publication were simulated successfully. AI usage remained zero. Scoped delivery worked without owner cookies; expired and tampered links returned HTTP 403.
- After stopping and restarting the isolated web process, the database, narration range playback, exact video bytes and all simulated publication records remained accessible.
- Browser inspection confirmed the Connections storage-ready panel and a decoded video preview: 1080 × 1920, 49.941 seconds, readyState 4, no media error. Representative rendered frames at 2, 25 and 46 seconds were visually inspected.
- Migration CLI dry-run and the SQLite backup command passed against the isolated test database.

The complete workflow used the bundled synthetic audio fixture and a separate test database/media folder. The owner's database, existing drafts, schedules and media were not used for verification. No real posts, paid generation calls or real R2 migration were performed.

## Remaining deployment requirements and limits

- Restart the normal web/worker processes to load the changed environment and source.
- Docker Desktop's Linux engine was stopped. Configuration was validated, but a container build/start and bind-mount persistence were not tested in running containers. Grant the documented non-root user access to the selected host folder.
- Live social account access and real R2 migration require your own credentials and smoke tests. Existing R2-only files without a local cache still need R2 credentials until explicitly migrated.
- Live Instagram URL delivery requires an already publicly reachable HTTPS origin. Local generation/download and simulated posting work on localhost; no public origin was provisioned.
- Disk exhaustion/quota/permission error classification was tested with injected OS error codes; the machine's disk was not filled and user folder permissions were not altered.
- Caption timing remains owner-editable approximate timing; this storage change does not add speech alignment or transcription.
