profile_custom_dwm_cjk() {
	title="Custom DWM CJK"
	desc="Alpine Linux with a minimal kernel and DWM and CJK fonts"
	profile_base
	profile_abbrev="customDwmK"
	image_ext="iso"
	arch="x86_64"
	output_format="iso"
	kernel_flavors="custom"
	apks="$apks \
		xorg-server xf86-input-libinput eudev xf86-video-amdgpu xf86-video-qxl xf86-video-modesetting xset xsetroot\
		mesa-egl setxkbmap dwm ttf-freefont font-noto-cjk \
		p7zip \
		alsa-utils alsa-lib alsaconf"
}
