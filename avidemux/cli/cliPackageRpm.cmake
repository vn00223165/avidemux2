SET(CPACK_RPM_PACKAGE_PROVIDES "avidemux-cli = ${AVIDEMUX_VERSION}")
SET(CPACK_RPM_PACKAGE_NAME "avidemux3-cli")
SET(CPACK_RPM_PACKAGE_DESCRIPTION "CLI for avidemux")
SET(CPACK_RPM_PACKAGE_SUMMARY "CLI for avidemux")
SET(CPACK_PACKAGE_RELOCATABLE "false")

include(admCPackRpm)
