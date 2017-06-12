Luckily, you can change the screen resolution.  Just not here.  What you need to do is:

- Open Terminal
- Type: sudo vi /etc/default/grub
- Find the line starting with GRUB_CMDLINE_LINUX_DEFAULT, and add video=hyperv_fb:[the resolution you want].  The resolution I want is 1280x720.  So my line ends up looking like this: GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=hyperv_fb:1280x720"
- Write the changes and quit vi.
- Run: sudo update-grub
- Reboot the virtual machine
