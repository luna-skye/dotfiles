{ pkgs, ... }:


{
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [ pkgs.apparmor-profiles ];
    };

    forcePageTableIsolation = true;
  };

  boot = {
    blacklistedKernelModules = [
      # network
      "ax25"
      "netrom"
      "rose"

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
    ];
  };
}
