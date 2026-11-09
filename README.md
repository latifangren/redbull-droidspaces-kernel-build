# Pixel 5 (Redbull) Droidspaces Kernel Builder

Automated CI builder for the Google Pixel 5 (`redfin`), Pixel 4a 5G (`bramble`), and Pixel 5a (`barbet`) Linux 4.19 kernel with full container capabilities for **[Droidspaces WebUI](https://github.com/latifangren/droidspaces-webui)**.

This repository uses **GitHub Actions** to pull the latest upstream kernel source from [crdroidandroid/android_kernel_google_redbull](https://github.com/crdroidandroid/android_kernel_google_redbull), merge container kernel fragments, compile with **Proton Clang**, and package the result into an **AnyKernel3 flashable zip**.

---

## Enabled Kernel Features

Standard stock Android & custom ROM kernels omit several container features. This builder injects [`configs/droidspaces.config`](configs/droidspaces.config) on top of `redbull_defconfig`:

| Feature | Kernel Config | Purpose in Droidspaces |
|---|---|---|
| **User Namespaces** | `CONFIG_USER_NS=y` | Allows rootless/unprivileged Docker, Podman, and browser sandboxing (Chromium, Bubblewrap) |
| **CFS Bandwidth Cgroup** | `CONFIG_CFS_BANDWIDTH=y` | Enables CPU quota allocation per container (`--cpus=1.5`) |
| **Macvlan / Macvtap** | `CONFIG_MACVLAN=y`, `CONFIG_MACVTAP=y` | Enables direct LAN NIC attachment (`--net=macvlan`) |
| **IPv6 NAT (NAT66)** | `CONFIG_IP6_NF_NAT=y`, `CONFIG_IP6_NF_TARGET_MASQUERADE=y` | Full IPv6 internet connectivity in `--net=nat` mode |
| **POSIX Message Queues** | `CONFIG_POSIX_MQUEUE=y`, `CONFIG_SYSVIPC=y` | High-performance inter-process communication for Linux daemons |

---

## How to Build

1. Push this repository to your GitHub account (e.g. `https://github.com/<username>/redbull-droidspaces-kernel-build`).
2. Go to the **Actions** tab on GitHub.
3. Select **Build Pixel 5 Droidspaces Kernel**.
4. Click **Run workflow**:
   - **Target Branch**: `16.0` (Default for crDroid 12 / Android 16) or `17.0` (for Android 17).
   - **Buat GitHub Release otomatis**: `true`
5. Click **Run workflow**. The build takes ~10–15 minutes on GitHub's cloud runners.

---

## How to Flash

Once the build finishes:
1. Download the generated `Droidspaces-Kernel-Pixel5-*.zip` from the **Releases** page (or Artifacts).
2. Transfer or download the `.zip` to your Pixel 5.
3. Open **KernelSU Manager** (or **Magisk** / TWRP Recovery).
4. Tap **Modules** -> **Install from storage** -> Select the downloaded `.zip`.
5. Reboot the phone.

---

## Verification

After rebooting, open a root terminal (or ADB) and run:

```bash
su -c '/data/local/Droidspaces/bin/droidspaces check'
```

All container capabilities will now display `[✓]` with **33/34 features active** (the only remaining missing feature is `New mount API`, which is expected on Linux 4.19 and handled transparently by Droidspaces seccomp shims).

---

## Credits
- Kernel Source: [crDroid Android Redbull Team](https://github.com/crdroidandroid/android_kernel_google_redbull)
- Clang Toolchain: [Proton Clang](https://github.com/kdrag0n/proton-clang) by kdrag0n
- Installer Engine: [AnyKernel3](https://github.com/osm0sis/AnyKernel3) by osm0sis
- Container Runtime: [Droidspaces-OSS](https://github.com/ravindu644/Droidspaces-OSS) by ravindu644
