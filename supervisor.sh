# Install Hass.io Supervisor
echo "[Info] Install supervisor startup scripts"
curl -sL ${URL_BIN_HASSIO} > "${PREFIX}"/sbin/hassio-supervisor
curl -sL ${URL_SERVICE_HASSIO} > "${SYSCONFDIR}"/systemd/system/hassio-supervisor.service

sed -i "s,%%HASSIO_CONFIG%%,${CONFIG},g" "${PREFIX}"/sbin/hassio-supervisor
sed -i -e "s,%%DOCKER_BINARY%%,${DOCKER_BINARY},g" \
       -e "s,%%DOCKER_SERVICE%%,${DOCKER_SERVICE},g" \
       -e "s,%%HASSIO_BINARY%%,${PREFIX}/sbin/hassio-supervisor,g" \
       "${SYSCONFDIR}"/systemd/system/hassio-supervisor.service

chmod a+x "${PREFIX}"/sbin/hassio-supervisor
systemctl enable hassio-supervisor.service
