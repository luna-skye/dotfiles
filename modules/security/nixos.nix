{ helpers, config, pkgs, lib, ... }:

# Much of this configuration was pulled from: https://saylesss88.github.io/nix/hardening_NixOS.html
# Some smaller parts from: https://github.com/sioodmy/dotfiles

let
  cfg = config.zen.security;

in {
  options.zen.security = {
    apparmor.enable = helpers.mkBooleanOption true "Whether to enable AppArmor security";

    setKernelParams = helpers.mkBooleanOption true "Whether to enable hardened kernel parameters";
    setSysctlTweaks = helpers.mkBooleanOption true "Whether to enable hardened sysctl settings";
    blacklistKernelModules = helpers.mkBooleanOption true "Whether to blacklist unmaintained or uncommon kernel modules";
    disableCoreDumps = helpers.mkBooleanOption true "Whether to disable systemd coredumps";
  };

  config = {
    security = {
      polkit.enable = true;
      rtkit.enable = true;
      forcePageTableIsolation = true;

      pam.loginLimits = lib.lists.optionals (cfg.disableCoreDumps) [{
        domain = "*";
        type = "-";
        item = "core";
        value = "0";
      }];

      apparmor = lib.mkIf (cfg.apparmor.enable) {
        enable = true;
        killUnconfinedConfinables = true;
        packages = [ pkgs.apparmor-profiles ];
      };
    };

    systemd.coredump.enable = if (cfg.disableCoreDumps) then false else true;

    boot = {
      kernel.sysctl = lib.mkIf (cfg.setSysctlTweaks) {
        "kernel.kptr_restrict" = 2;        # prevent pointer leaks
        "kernel.dmesg_restrict" = 1;       # restrict kernel log to CAP_SYSLOG capability
        "vm.unprivileged_userfaultfd" = 0; # prevent exploit of use-after-free flaws
        "kernel.kexec_load_disabled" = 1;  # kexec is used to boot another kernel during runtime and can be abused
        "kernel.perf_event_paranoid" = 3;  # restrict all usage of performance events to the CAP_PERFMON capability

        # kernel self-protection
        # sysrq exposes a lot of potentially dangerous debuggin functionality to unprivileged users
        # 4 makes it so a user can only use the secure attention key. A value of 0 would disable completely
        "kernel.sysrq" = 4;

        # disable unprivileged user namespaces, Note: Docker, NH, and other apps may need this
        # This should be set to 0 if you don't rely on flatpak, NH, Docker, etc.
        "kernel.unprivileged_userns_clone" = 1; 


        # network
        "net.ipv4.tcp_syncookies" = 1; # protect against SYN flood attacks (denial of service attack)
        "net.ipv4.tcp_rfc1337" = 1;    # protect against TIME-WAIT assassination

        # enable source validation of packets received (prevents IP spoofing)
        "net.ipv4.conf.default.rp_filter" = 1;
        "net.ipv4.conf.all.rp_filter" = 1;
      };

      kernelParams = lib.lists.optionals (cfg.setKernelParams) [
        "slab_nomerge" # make it harder to influence slab cache layout
        "vsyscall=none" # disables vsyscalls, they've been replaced with vDSO
        "debugfs=off" # disables debugfs, which exposes sensitive info about the kernel
        "oops=panic" # certain exploits cause an "oops", this makes the kernel panic if one occurs
        "lockdown=confidentiality" # prevents user space code excalation

        # enables zeroing of memory during allocation and free time
        # helps mitigate use-after-free vulnerabilities
        "init_on_alloc=1"
        "init_on_free=1"

        # randomizes page allocator freelist, improving security by
        # making page allocations less predictable
        "page_alloc.shuffel=1"

        # enable skernel page table isolation, which mitigates meltdown and
        # prevents some KASLR bypasses
        "pti=on"

        # randomizes the kernel sack offset on each syscall
        # making attacks which rely on a deterministic stack layout difficult
        "randomize_kstack_offset=on"

        # only allows kernel modules that have been signed with a valid key to be loaded
        # making it harder to load malicious kernel modules
        # can make virtualbox or nvidia drivers unstable
        "module.sig_enforce=1"
      ];

      blacklistedKernelModules = lib.lists.optionals (cfg.blacklistKernelModules) [
        # network
        "ax25" # amateur X.25
        "x25"  # X.25
        "netrom"
        "rose"
        "dccp" # datagram congestion control protocol
        "sctp" # stream control transmission protocol
        "rds"  # reliable datagram sockets
        "tipc" # transparent inter-process communication
        "n-hdlc" # high-level data link control
        "decnet"
        "econet"
        "af_802154" # IEEE 802.15.4
        "ipx" # internetwork packet exchange
        "appletalk"
        "psnap" # subnetworkaccess protocol
        "p8023" # novell raw IEE 802.3
        "p8022" # IEE 802.3
        "can" # controller area network
        "atm"

        # filesystems
        "adfs"
        "affs"
        "bfs"
        "befs"
        "cramfs"
        "efs"
        "erofs"
        "exofs"
        "freevxfs"
        "f2fs"
        "vivid"
        "gfs2"
        "ksmbd"
        "nfsv4"
        "nfsv3"
        "cifs"
        "nfs"
        "jffs2"
        "hfs"
        "hfsplus"
        "squashfs"
        "udf"
        "hpfs"
        "jfs"
        "minix"
        "nilfs2"
        "omfs"
        "qnx4"
        "qnx6"
        "sysv"
        "udf"
        "squashfs" # compressed read-only file system used for Live CDs
        "cifs" # cmb (common internet file system)
        "ksmbd" # smb3 kernel server
        "gfs2"
      ];
    };
  };
}
