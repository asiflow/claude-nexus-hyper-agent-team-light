# beam-sre Memory Index

## Project Context
- [project_gke_cluster_state.md](project_gke_cluster_state.md) — ASIFlow GKE cluster state (2026-04-15 post-drain); Plane 1 deployment TBD; operational hazards pre-existing (OTLP broken, redis-pdb broken, 5 nodes 5d+ uptime)

## Feedback / Discipline
- [feedback_coordination_boundary.md](feedback_coordination_boundary.md) — Coordination boundary with infra-expert (generic K8s), observability-expert (generic OTLP), cluster-awareness (live reads) — owns BEAM sliver; never duplicates
