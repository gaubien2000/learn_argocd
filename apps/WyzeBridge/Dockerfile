FROM mrlt8/wyze-bridge@sha256:a5802013c508c9283d3bfb707e277fe032890193fc8bee85810c2ebeec00cf7b

# The upstream image defaults to root and rewrites /app/mediamtx.yml at startup.
# Make all runtime-writable image paths owned by the unprivileged service UID.
RUN chown -R 1000:1000 /app /tokens /img

USER 1000:1000
