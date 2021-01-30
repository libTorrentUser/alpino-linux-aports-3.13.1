profile_custom_dwm() {
	title="Custom DWM"
	desc="Alpine Linux with a minimal kernel and DWM"
	profile_base
	profile_abbrev="custom_dwm"
	image_ext="iso"
	arch="x86_64"
	output_format="iso"
	kernel_flavors="custom"
	apks="$apks \
		xorg-server xf86-input-libinput eudev xf86-video-amdgpu xf86-video-qxl xf86-video-modesetting xset xsetroot\
		mesa-egl setxkbmap dwm ttf-freefont \
		p7zip \
		alsa-utils alsa-lib alsaconf"
}
