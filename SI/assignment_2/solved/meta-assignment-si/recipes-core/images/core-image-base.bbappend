IMAGE_INSTALL += "curl example dhcp-client python3 ssh avahi-daemon tui server"

inherit extrausers

EXTRA_USERS_PARAMS += "usermod -P labsi root;"

EXTRA_USERS_PARAMS += "useradd -P student student;"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "file://hostname"

do_install_append () {
    install -m 644 ${WORKDIR}/hostname ${D}${sysconfdir}/hostname
}