DESCRIPTION = "Yellow Submarine HTTP Server with REST Client"
LICENSE = "MIT"
BB_STRICT_CHECKSUM = "0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit go

SRC_URI = "file://server-init file://go.mod file://go.sum file://main.go file://domain/artifact.go file://domain/fish.go file://domain/go.mod file://domain/rpc.go file://domain/submarine.go file://usecases/artifact.go file://usecases/fish.go file://usecases/go.mod file://usecases/submarine.go file://gateway/api/api.go file://gateway/api/go.mod file://gateway/api/go.sum file://gateway/events/go.mod file://gateway/events/rpc.go"

do_compile() {
        ${GO} build -o ${WORKDIR}/build/server ${WORKDIR}/main.go
}

do_install() {
        install -d "${D}/${bindir}"
        install -D -m 0755 "${WORKDIR}/build/server" "${D}/${bindir}"
        install -D -m 0755 "${WORKDIR}/server-init" "${D}/${sysconfdir}/init.d/server-init"

        install -d ${D}${sysconfdir}/init.d
        install -d ${D}${sysconfdir}/rcS.d
        install -d ${D}${sysconfdir}/rc1.d
        install -d ${D}${sysconfdir}/rc2.d
        install -d ${D}${sysconfdir}/rc3.d
        install -d ${D}${sysconfdir}/rc4.d
        install -d ${D}${sysconfdir}/rc5.d

        ln -sf ../init.d/server-init ${D}${sysconfdir}/rc5.d/S99server-init
}
