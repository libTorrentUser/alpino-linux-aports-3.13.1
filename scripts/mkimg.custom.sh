profile_custom() {
	title="Custom"
	desc="Alpine Linux with a customized kernel"
	profile_base
	profile_abbrev="custom"
	image_ext="iso"
	arch="x86_64"
	output_format="iso"
	kernel_flavors="custom"
	apks="$apks"
}
