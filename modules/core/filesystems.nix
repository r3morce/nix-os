{ config, ... }:

{
  # Auto-mount /dev/sdd1 to /mnt/data
  # Note: Change fsType if your drive uses a different filesystem (btrfs, ntfs-3g, etc.)
  fileSystems."/mnt/data" = {
    device = "/dev/sdd1";
    fsType = "ext4";  # Adjust based on your filesystem type
    options = [
      "defaults"
      "nofail"  # Don't fail boot if drive is not present
    ];
  };
}
