FROM quay.io/fedora/fedora-silverblue:44

# Running under rootless Podman fails the 'var-tmpfiles' lint by default, since
# host's securityfs is mounted for the container but cannot be read. Overwrite
# securityfs with empty tmpfs to facilitate /var lints.
RUN --mount=type=tmpfs,dst=/sys/kernel/security bootc container lint
