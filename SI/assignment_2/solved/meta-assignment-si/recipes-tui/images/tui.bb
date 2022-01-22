DESCRIPTION = "Yellow Submarine Text User Interface."
LICENSE = "MIT"
BB_STRICT_CHECKSUM = "0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit go

SRC_URI = "file://tui-init file://main.go file://go.mod file://go.sum file://tui-init"

do_compile() {
        ${GO} build -o ${WORKDIR}/build/tui ${WORKDIR}/main.go
}

do_install() {
        install -d "${D}/${bindir}"
        install -D -m 0755 "${WORKDIR}/build/tui" "${D}/${bindir}"
        install -D -m 0755 "${WORKDIR}/tui-init" "${D}/${sysconfdir}/init.d/tui-init"

        install -d ${D}${sysconfdir}/init.d
        install -d ${D}${sysconfdir}/rcS.d
        install -d ${D}${sysconfdir}/rc1.d
        install -d ${D}${sysconfdir}/rc2.d
        install -d ${D}${sysconfdir}/rc3.d
        install -d ${D}${sysconfdir}/rc4.d
        install -d ${D}${sysconfdir}/rc5.d

        ln -sf ../init.d/tui-init ${D}${sysconfdir}/rc5.d/S90tui-init
}
