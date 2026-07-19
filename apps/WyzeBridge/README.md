# Wyze Bridge

Argo CD-managed Wyze Bridge deployment for the single-node K3s cluster.

The upstream image defaults to root, so `Dockerfile` builds a hardened derivative that runs as UID/GID 1000. Build and import it on the K3s node before reconciliation:

```bash
docker build -t wyze-bridge-nonroot:2.10.3-1 apps/WyzeBridge
docker save wyze-bridge-nonroot:2.10.3-1 | sudo k3s ctr images import -
```

The `wyze-bridge-credentials` Secret is intentionally not stored in Git. It must contain `WYZE_EMAIL`, `WYZE_PASSWORD`, `API_ID`, `API_KEY`, `WB_USERNAME`, and `WB_PASSWORD`.

The pod uses host networking for reliable local camera and WebRTC connectivity. No Ingress or externally published Service is created. Home Assistant can use the in-cluster service endpoints, including `rtsp://wyze-bridge.wyze-bridge.svc.cluster.local:8554/<camera-name>`.

Because the hardened image is node-local, rebuild and import it after replacing or rebuilding the K3s node.
