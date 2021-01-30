_scriptPath=$(readlink -f "$0")
_scriptDir=$(dirname "$_scriptPath")

build_alpino_virt() {
	#msg "build_alpino_virt"

	# if the user provided a directory using --ali-dir, copy all files to /ali
	if [ ! -z "$ALPINE_LINUX_INITIALIZE_DIR" ]; then
		local _destDir="${DESTDIR}/ali"
		mkdir -p $_destDir

		cp -a "${ALPINE_LINUX_INITIALIZE_DIR}/"* $_destDir

		# ensure init.sh is executable
		chmod +x "$_destDir/init.sh"
	fi
}

section_alpino_virt() {
	#msg "section_alpino_virt"
	build_section alpino_virt
}

profile_alpino_standard() {
	title="Standard"
	desc="Alpine as it was intended.
		Just enough to get you started.
		Network connection is required."
	profile_base
	profile_abbrev="std"
	image_ext="iso"
	arch="aarch64 x86 x86_64 ppc64le s390x"
	output_format="iso"
	kernel_cmdline="nomodeset"
	kernel_addons="xtables-addons"
	case "$ARCH" in
	s390x)
		apks="$apks s390-tools"
		initfs_features="$initfs_features dasd_mod qeth"
		initfs_cmdline="modules=loop,squashfs,dasd_mod,qeth quiet"
		;;
	ppc64le)
		initfs_cmdline="modules=loop,squashfs,sd-mod,usb-storage,ibmvscsi quiet"
		;;
	esac
}


profile_alpino_virt() {
	profile_standard
	profile_abbrev="virt"
	title="Virtual"
	desc="Similar to standard.
		Slimmed down kernel.
		Optimized for virtual systems."
	arch="aarch64 x86 x86_64"
	kernel_addons=
	kernel_flavors="virt"
	kernel_cmdline="console=tty0 console=ttyS0,115200"
	syslinux_serial="0 115200"
}
