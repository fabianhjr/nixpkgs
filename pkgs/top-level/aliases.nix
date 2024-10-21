lib: self: super:

### Deprecated aliases - for backward compatibility
### Please maintain this list in ASCIIbetical ordering.
### Hint: the "sections" are delimited by ### <letter> ###

# These aliases should not be used within nixpkgs, but exist to improve
# backward compatibility in projects outside of nixpkgs. See the
# documentation for the `allowAliases` option for more background.

# A script to convert old aliases to throws and remove old
# throws can be found in './maintainers/scripts/remove-old-aliases.py'.

# Add 'preserve, reason: reason why' after the date if the alias should not be removed.
# Try to keep them to a minimum.
# valid examples of what to preserve:
#   distro aliases such as:
#     debian-package-name -> nixos-package-name

with self;

let
  # Removing recurseForDerivation prevents derivations of aliased attribute set
  # to appear while listing all the packages available.
  removeRecurseForDerivations = alias:
    if alias.recurseForDerivations or false
    then lib.removeAttrs alias [ "recurseForDerivations" ]
    else alias;

  # Disabling distribution prevents top-level aliases for non-recursed package
  # sets from building on Hydra.
  removeDistribute = alias:
    if lib.isDerivation alias then
      lib.dontDistribute alias
    else alias;

  transmission3Warning = { prefix ? "", suffix ? "" }: let
    p = "${prefix}transmission${suffix}";
    p3 = "${prefix}transmission_3${suffix}";
    p4 = "${prefix}transmission_4${suffix}";
  in "${p} has been renamed to ${p3} since ${p4} is also available. Note that upgrade caused data loss for some users so backup is recommended (see NixOS 24.11 release notes for details)";

  # Make sure that we are not shadowing something from all-packages.nix.
  checkInPkgs = n: alias:
    if builtins.hasAttr n super
    then throw "Alias ${n} is still in all-packages.nix"
    else alias;

  mapAliases = aliases:
    lib.mapAttrs
      (n: alias:
        removeDistribute
          (removeRecurseForDerivations
            (checkInPkgs n alias)))
      aliases;
in

mapAliases {
  # Added 2018-07-16 preserve, reason: forceSystem should not be used directly in Nixpkgs.
  forceSystem = system: _:
    (import self.path { localSystem = { inherit system; }; });

  ### A ###

  AusweisApp2 = throw "'AusweisApp2' has been renamed to/replaced by 'ausweisapp'"; # Converted to throw 2024-10-21
  a4term = throw "'a4term' has been renamed to/replaced by 'a4'"; # Converted to throw 2024-10-21
  acorn = throw "acorn has been removed as the upstream project was archived"; # Added 2024-04-27
  acousticbrainz-client = throw "acousticbrainz-client has been removed since the AcousticBrainz project has been shut down"; # Added 2024-06-04
  adtool = throw "'adtool' has been removed, as it was broken and unmaintained";
  adom = throw "'adom' has been removed, as it was broken and unmaintained"; # added 2024-05-09
  adoptopenjdk-bin = throw "adoptopenjdk has been removed as the upstream project is deprecated. Consider using `temurin-bin`"; # Added 2024-05-09
  adoptopenjdk-bin-17-packages-darwin = throw "adoptopenjdk has been removed as the upstream project is deprecated. Consider using `temurin-bin-17`."; # Added 2024-05-09
  adoptopenjdk-bin-17-packages-linux = throw "adoptopenjdk has been removed as the upstream project is deprecated. Consider using `temurin-bin-17`."; # Added 2024-05-09
  adoptopenjdk-hotspot-bin-11 = throw "adoptopenjdk has been removed as the upstream project is deprecated. Consider using `temurin-bin-11`."; # Added 2024-05-09
  adoptopenjdk-hotspot-bin-15 = throw "adoptopenjdk has been removed as the upstream project is deprecated. JDK 15 is also EOL. Consider using `temurin-bin-17`."; # Added 2024-05-09
  adoptopenjdk-hotspot-bin-16 = throw "adoptopenjdk has been removed as the upstream project is deprecated. JDK 16 is also EOL. Consider using `temurin-bin-17`."; # Added 2024-05-09
  adoptopenjdk-hotspot-bin-8 = throw "adoptopenjdk has been removed as the upstream project is deprecated. Consider using `temurin-bin-8`."; # Added 2024-05-09
  adoptopenjdk-jre-bin = throw "adoptopenjdk has been removed as the upstream project is deprecated. Consider using `temurin-jre-bin`."; # Added 2024-05-09
  adoptopenjdk-jre-hotspot-bin-11 = throw "adoptopenjdk has been removed as the upstream project is deprecated. Consider using `temurin-jre-bin-11`."; # Added 2024-05-09
  adoptopenjdk-jre-hotspot-bin-15 = throw "adoptopenjdk has been removed as the upstream project is deprecated. JDK 15 is also EOL. Consider using `temurin-jre-bin-17`."; # Added 2024-05-09
  adoptopenjdk-jre-hotspot-bin-16 = throw "adoptopenjdk has been removed as the upstream project is deprecated. JDK 16 is also EOL. Consider using `temurin-jre-bin-17`."; # Added 2024-05-09
  adoptopenjdk-jre-hotspot-bin-8 = throw "adoptopenjdk has been removed as the upstream project is deprecated. Consider using `temurin-jre-bin-8`."; # Added 2024-05-09
  adoptopenjdk-jre-openj9-bin-11 = throw "adoptopenjdk has been removed as the upstream project is deprecated. Consider using `semeru-jre-bin-11`."; # Added 2024-05-09
  adoptopenjdk-jre-openj9-bin-15 = throw "adoptopenjdk has been removed as the upstream project is deprecated. JDK 15 is also EOL. Consider using `semeru-jre-bin-17`."; # Added 2024-05-09
  adoptopenjdk-jre-openj9-bin-16 = throw "adoptopenjdk has been removed as the upstream project is deprecated. JDK 16 is also EOL. Consider using `semeru-jre-bin-17`."; # Added 2024-05-09
  adoptopenjdk-jre-openj9-bin-8 = throw "adoptopenjdk has been removed as the upstream project is deprecated. Consider using `semeru-jre-bin-8`."; # Added 2024-05-09
  adoptopenjdk-openj9-bin-11 = throw "adoptopenjdk has been removed as the upstream project is deprecated. Consider using `semeru-bin-11`."; # Added 2024-05-09
  adoptopenjdk-openj9-bin-15 = throw "adoptopenjdk has been removed as the upstream project is deprecated. JDK 15 is also EOL. Consider using `semeru-bin-17`."; # Added 2024-05-09
  adoptopenjdk-openj9-bin-16 = throw "adoptopenjdk has been removed as the upstream project is deprecated. JDK 16 is also EOL. Consider using `semeru-bin-17`."; # Added 2024-05-09
  adoptopenjdk-openj9-bin-8 = throw "adoptopenjdk has been removed as the upstream project is deprecated. Consider using `semeru-bin-8`."; # Added 2024-05-09
  # Post 24.11 branch-off, this should throw an error
  addOpenGLRunpath = addDriverRunpath; # Added 2024-05-25
  aeon = throw "aeon has been removed from nixpkgs, as it was broken and unmaintained"; # Added 2024-07-15
  afl = throw "afl has been removed as the upstream project was archived. Consider using 'aflplusplus'"; # Added 2024-04-21
  agda-pkg = throw "agda-pkg has been removed due to being unmaintained"; # Added 2024-09-10"
  alsaLib = throw "'alsaLib' has been renamed to/replaced by 'alsa-lib'"; # Converted to throw 2024-10-17
  alsaOss = throw "'alsaOss' has been renamed to/replaced by 'alsa-oss'"; # Converted to throw 2024-10-17
  alsaPluginWrapper = throw "'alsaPluginWrapper' has been renamed to/replaced by 'alsa-plugins-wrapper'"; # Converted to throw 2024-10-17
  alsaPlugins = throw "'alsaPlugins' has been renamed to/replaced by 'alsa-plugins'"; # Converted to throw 2024-10-17
  alsaTools = throw "'alsaTools' has been renamed to/replaced by 'alsa-tools'"; # Converted to throw 2024-10-17
  alsaUtils = throw "'alsaUtils' has been renamed to/replaced by 'alsa-utils'"; # Converted to throw 2024-10-17
  angelfish = throw "'angelfish' has been renamed to/replaced by 'libsForQt5.kdeGear.angelfish'"; # Converted to throw 2024-10-17
  ansible_2_14 = throw "Ansible 2.14 goes end of life in 2024/05 and can't be supported throughout the 24.05 release cycle"; # Added 2024-04-11
  antennas = throw "antennas has been removed as it only works with tvheadend, which nobody was willing to maintain and was stuck on an unmaintained version that required FFmpeg 4; please see https://github.com/NixOS/nixpkgs/pull/332259 if you are interested in maintaining a newer version"; # Added 2024-08-21
  androidndkPkgs_23b = lib.warn "The package set `androidndkPkgs_23b` has been renamed to `androidndkPkgs_23`." androidndkPkgs_23; # Added 2024-07-21
  ankisyncd = throw "ankisyncd is dead, use anki-sync-server instead"; # Added 2024-08-10
  ao = libfive; # Added 2024-10-11
  apacheKafka_3_5 = throw "apacheKafka_2_8 through _3_5 have been removed from nixpkgs as outdated"; # Added 2024-06-13
  antimicroX = throw "'antimicroX' has been renamed to/replaced by 'antimicrox'"; # Converted to throw 2024-10-17
  appthreat-depscan = dep-scan; # Added 2024-04-10
  arcanist = throw "arcanist was removed as phabricator is not supported and does not accept fixes"; # Added 2024-06-07
  aria = throw "'aria' has been renamed to/replaced by 'aria2'"; # Converted to throw 2024-10-21
  armcord = throw "ArmCord was renamed to legcord by the upstream developers. Action is required to migrate configurations between the two applications. Please see this PR for more details: https://github.com/NixOS/nixpkgs/pull/347971"; # Added 2024-10-11
  aseprite-unfree = throw "'aseprite-unfree' has been renamed to/replaced by 'aseprite'"; # Converted to throw 2024-10-21
  audaciousQt5 = throw "'audaciousQt5' has been removed, since audacious is built with Qt 6 now"; # Added 2024-07-06
  auditBlasHook = throw "'auditBlasHook' has been removed since it never worked"; # Added 2024-04-02
  aumix = throw "'aumix' has been removed due to lack of maintenance upstream. Consider using 'pamixer' for CLI or 'pavucontrol' for GUI"; # Added 2024-09-14
  authy = throw "'authy' has been removed since it reached end of life"; # Added 2024-04-19
  avldrums-lv2 = throw "'avldrums-lv2' has been renamed to/replaced by 'x42-avldrums'"; # Converted to throw 2024-10-17
  avrlibcCross = avrlibc; # Added 2024-09-06
  awesome-4-0 = throw "'awesome-4-0' has been renamed to/replaced by 'awesome'"; # Converted to throw 2024-10-21
  aws-env = throw "aws-env has been removed as the upstream project was unmaintained"; # Added 2024-06-11
  aws-google-auth = throw "aws-google-auth has been removed as the upstream project was unmaintained"; # Added 2024-07-31

  ### B ###

  badtouch = authoscope; # Project was renamed, added 20210626
  baget = throw "'baget' has been removed due to being unmaintained";
  bashInteractive_5 = throw "'bashInteractive_5' has been renamed to/replaced by 'bashInteractive'"; # Converted to throw 2024-10-17
  bash_5 = throw "'bash_5' has been renamed to/replaced by 'bash'"; # Converted to throw 2024-10-17
  BeatSaberModManager = beatsabermodmanager; # Added 2024-06-12
  bibata-extra-cursors = throw "bibata-cursors has been removed as it was broken"; # Added 2024-07-15
  bitcoin-unlimited = throw "bitcoin-unlimited has been removed as it was broken and unmaintained"; # Added 2024-07-15
  bitcoind-unlimited = throw "bitcoind-unlimited has been removed as it was broken and unmaintained"; # Added 2024-07-15
  bird2 = throw "'bird2' has been renamed to/replaced by 'bird'"; # Converted to throw 2024-10-21
  bitwarden = throw "'bitwarden' has been renamed to/replaced by 'bitwarden-desktop'"; # Converted to throw 2024-10-21
  blender-with-packages = throw "blender-with-packages is deprecated in favor of blender.withPackages, e.g. `blender.withPackages(ps: [ ps.foobar ])`"; # Converted to throw 2024-10-21
  bless = throw "'bless' has been removed due to lack of maintenance upstream and depending on gtk2. Consider using 'imhex' or 'ghex' instead"; # Added 2024-09-15
  blockbench-electron = throw "'blockbench-electron' has been renamed to/replaced by 'blockbench'"; # Converted to throw 2024-10-21
  bmap-tools = bmaptool; # Added 2024-08-05
  boost_process = throw "boost_process has been removed as it is included in regular boost"; # Added 2024-05-01
  bpb = throw "bpb has been removed as it is unmaintained and not compatible with recent Rust versions"; # Added 2024-04-30
  bpftool = throw "'bpftool' has been renamed to/replaced by 'bpftools'"; # Converted to throw 2024-10-17
  brasero-original = lib.warn "Use 'brasero-unwrapped' instead of 'brasero-original'" brasero-unwrapped; # Added 2024-09-29
  bs-platform = throw "'bs-platform' was removed as it was broken, development ended and 'melange' has superseded it"; # Added 2024-07-29

  budgie = throw "The `budgie` scope has been removed and all packages moved to the top-level"; # Added 2024-07-14
  budgiePlugins = throw "The `budgiePlugins` scope has been removed and all packages moved to the top-level"; # Added 2024-07-14

  inherit (libsForQt5.mauiPackages) buho; # added 2022-05-17
  butler = throw "butler was removed because it was broken and abandoned upstream"; # added 2024-06-18
  # Shorter names; keep the longer name for back-compat. Added 2023-04-11
  buildFHSUserEnv = buildFHSEnv;
  buildFHSUserEnvChroot = buildFHSEnvChroot;
  buildFHSUserEnvBubblewrap = buildFHSEnvBubblewrap;

  # bitwarden_rs renamed to vaultwarden with release 1.21.0 (2021-04-30)
  bitwarden_rs = vaultwarden;
  bitwarden_rs-mysql = vaultwarden-mysql;
  bitwarden_rs-postgresql = vaultwarden-postgresql;
  bitwarden_rs-sqlite = vaultwarden-sqlite;
  bitwarden_rs-vault = vaultwarden-vault;



  ### C ###

  calligra = kdePackages.calligra; # Added 2024-09-27
  callPackage_i686 = pkgsi686Linux.callPackage;
  cask = throw "'cask' has been renamed to/replaced by 'emacs.pkgs.cask'"; # Converted to throw 2024-10-21
  canonicalize-jars-hook = throw "'canonicalize-jars-hook' has been renamed to/replaced by 'stripJavaArchivesHook'"; # Converted to throw 2024-10-21
  cargo-deps = throw "cargo-deps has been removed as the repository is deleted"; # Added 2024-04-09
  cargo-espflash = espflash;
  cawbird = throw "cawbird has been abandoned upstream and is broken anyways due to Twitter closing its API";
  certmgr-selfsigned = throw "'certmgr-selfsigned' has been renamed to/replaced by 'certmgr'"; # Converted to throw 2024-10-21
  challenger = taler-challenger; # Added 2024-09-04
  check_smartmon = throw "'check_smartmon' has been renamed to 'nagiosPlugins.check_smartmon'"; # Added 2024-05-03
  check_systemd = throw "'check_systemd' has been renamed to 'nagiosPlugins.check_systemd'"; # Added 2024-05-03
  check_zfs = throw "'check_zfs' has been renamed to 'nagiosPlugins.check_zfs'"; # Added 2024-05-03
  check-esxi-hardware = throw "'check-esxi-hardware' has been renamed to 'nagiosPlugins.check_esxi_hardware'"; # Added 2024-05-03
  check-mssql-health = throw "'check-mssql-health' has been renamed to 'nagiosPlugins.check_mssql_health'"; # Added 2024-05-03
  check-nwc-health = throw "'check-nwc-health' has been renamed to 'nagiosPlugins.check_nwc_health'"; # Added 2024-05-03
  check-openvpn = throw "'check-openvpn' has been renamed to 'nagiosPlugins.check_openvpn'"; # Added 2024-05-03
  check-ups-health = throw "'check-ups-health' has been renamed to 'nagiosPlugins.check_ups_health'"; # Added 2024-05-03
  check-uptime = throw "'check-uptime' has been renamed to 'nagiosPlugins.check_uptime'"; # Added 2024-05-03
  check-wmiplus = throw "'check-wmiplus' has been renamed to 'nagiosPlugins.check_wmi_plus'"; # Added 2024-05-03
  checkSSLCert = throw "'checkSSLCert' has been renamed to 'nagiosPlugins.check_ssl_cert'"; # Added 2024-05-03
  chiaki4deck = chiaki-ng; # Added 2024-08-04
  chocolateDoom = throw "'chocolateDoom' has been renamed to/replaced by 'chocolate-doom'"; # Converted to throw 2024-10-21
  ChowCentaur = chow-centaur; # Added 2024-06-12
  ChowPhaser = chow-phaser; # Added 2024-06-12
  ChowKick = chow-kick; # Added 2024-06-12
  CHOWTapeModel = chow-tape-model; # Added 2024-06-12
  chrome-gnome-shell = throw "'chrome-gnome-shell' has been renamed to/replaced by 'gnome-browser-connector'"; # Converted to throw 2024-10-21
  cloog = throw "cloog has been removed from Nixpkgs, as it is unmaintained and obsolete"; # Added 2024-09-13
  cloog_0_18_0 = throw "cloog_0_18_0 has been removed from Nixpkgs, as it is unmaintained and obsolete"; # Added 2024-09-13
  cloogppl = throw "cloogppl has been removed from Nixpkgs, as it is unmaintained and obsolete"; # Added 2024-09-13
  clang-sierraHack = throw "clang-sierraHack has been removed because it solves a problem that no longer seems to exist. Hey, what were you even doing with that thing anyway?"; # Added 2024-10-05
  clang-sierraHack-stdenv = clang-sierraHack; # Added 2024-10-05
  inherit (libsForQt5.mauiPackages) clip; # added 2022-05-17
  clwrapperFunction = throw "Lisp packages have been redesigned. See 'lisp-modules' in the nixpkgs manual."; # Added 2024-05-07
  CoinMP = coinmp; # Added 2024-06-12
  collada-dom = throw "'collada-dom' has been renamed to/replaced by 'opencollada'"; # Converted to throw 2024-10-21
  coriander = throw "'coriander' has been removed because it depends on GNOME 2 libraries"; # Added 2024-06-27
  corretto19 = throw "Corretto 19 was removed as it has reached its end of life"; # Added 2024-08-01
  cosmic-tasks = tasks; # Added 2024-07-04
  cpp-ipfs-api = throw "'cpp-ipfs-api' has been renamed to/replaced by 'cpp-ipfs-http-client'"; # Converted to throw 2024-10-21
  crispyDoom = throw "'crispyDoom' has been renamed to/replaced by 'crispy-doom'"; # Converted to throw 2024-10-21
  crossLibcStdenv = stdenvNoLibc; # Added 2024-09-06
  clash-geoip = throw "'clash-geoip' has been removed. Consider using 'dbip-country-lite' instead."; # added 2024-10-19
  clash-verge = throw "'clash-verge' has been removed, as it was broken and unmaintained. Consider using 'clash-verge-rev' or 'clash-nyanpasu' instead"; # Added 2024-09-17
  clasp = throw "'clasp' has been renamed to/replaced by 'clingo'"; # Converted to throw 2024-10-21
  claws-mail-gtk3 = throw "'claws-mail-gtk3' has been renamed to/replaced by 'claws-mail'"; # Converted to throw 2024-10-17
  cockroachdb-bin = throw "'cockroachdb-bin' has been renamed to/replaced by 'cockroachdb'"; # Converted to throw 2024-10-21
  codimd = throw "'codimd' has been renamed to/replaced by 'hedgedoc'"; # Converted to throw 2024-10-17
  inherit (libsForQt5.mauiPackages) communicator; # added 2022-05-17
  concurrencykit = throw "'concurrencykit' has been renamed to/replaced by 'libck'"; # Converted to throw 2024-10-17
  containerpilot = throw "'containerpilot' has been removed from nixpkgs, as it was broken and unmaintained"; # Added 2024-06-09
  crackmapexec = throw "'crackmapexec' has been removed as it was unmaintained. Use 'netexec' instead"; # 2024-08-11
  cups-kyodialog3 = throw "'cups-kyodialog3' has been renamed to/replaced by 'cups-kyodialog'"; # Converted to throw 2024-10-21
  cvs_fast_export = throw "'cvs_fast_export' has been renamed to/replaced by 'cvs-fast-export'"; # Converted to throw 2024-10-17

  # these are for convenience, not for backward compat and shouldn't expire
  clang9Stdenv = throw "clang9Stdenv has been removed from nixpkgs"; # Added 2024-04-08
  clang12Stdenv = lowPrio llvmPackages_12.stdenv;
  clang13Stdenv = lowPrio llvmPackages_13.stdenv;
  clang14Stdenv = lowPrio llvmPackages_14.stdenv;
  clang15Stdenv = lowPrio llvmPackages_15.stdenv;
  clang16Stdenv = lowPrio llvmPackages_16.stdenv;
  clang17Stdenv = lowPrio llvmPackages_17.stdenv;
  clang18Stdenv = lowPrio llvmPackages_18.stdenv;
  clang19Stdenv = lowPrio llvmPackages_19.stdenv;

  clang-tools_9 = throw "clang-tools_9 has been removed from nixpkgs"; # Added 2024-04-08
  clang_9 = throw "clang_9 has been removed from nixpkgs"; # Added 2024-04-08

  clang-tools_12 = llvmPackages_12.clang-tools; # Added 2024-04-22
  clang-tools_13 = llvmPackages_13.clang-tools; # Added 2024-04-22
  clang-tools_14 = llvmPackages_14.clang-tools; # Added 2024-04-22
  clang-tools_15 = llvmPackages_15.clang-tools; # Added 2024-04-22
  clang-tools_16 = llvmPackages_16.clang-tools; # Added 2024-04-22
  clang-tools_17 = llvmPackages_17.clang-tools; # Added 2024-04-22
  clang-tools_18 = llvmPackages_18.clang-tools; # Added 2024-04-22
  clang-tools_19 = llvmPackages_19.clang-tools; # Added 2024-08-21

  cq-editor = throw "cq-editor has been removed, as it use a dependency that was disabled since python 3.8 and was last updated in 2021"; # Added 2024-05-13

  ### D ###

  dart_stable = throw "'dart_stable' has been renamed to/replaced by 'dart'"; # Converted to throw 2024-10-17
  dart-sass-embedded = throw "dart-sass-embedded has been removed from nixpkgs, as is now included in Dart Sass itself.";
  dat = nodePackages.dat;
  dbeaver = throw "'dbeaver' has been renamed to/replaced by 'dbeaver-bin'"; # Added 2024-05-16
  deadpixi-sam = deadpixi-sam-unstable;

  debugedit-unstable = throw "'debugedit-unstable' has been renamed to/replaced by 'debugedit'"; # Converted to throw 2024-10-17
  deltachat-electron = throw "'deltachat-electron' has been renamed to/replaced by 'deltachat-desktop'"; # Converted to throw 2024-10-17

  demjson = throw "'demjson' has been renamed to/replaced by 'with'"; # Converted to throw 2024-10-21
  dgsh = throw "'dgsh' has been removed, as it was broken and unmaintained"; # added 2024-05-09
  dibbler = throw "dibbler was removed because it is not maintained anymore"; # Added 2024-05-14
  dillong = throw "'dillong' has been removed, as upstream is abandoned since 2021-12-13. Use either 'dillo' or 'dillo-plus'. The latter integrates features from dillong."; # Added 2024-10-07
  dnnl = throw "'dnnl' has been renamed to/replaced by 'oneDNN'"; # Converted to throw 2024-10-17
  dnscrypt-wrapper = throw "dnscrypt-wrapper was removed because it has been effectively unmaintained since 2018. Use DNSCcrypt support in dnsdist instead"; # Added 2024-09-14
  docker-compose_1 = throw "'docker-compose_1' has been removed because it has been unmaintained since May 2021. Use docker-compose instead."; # Added 2024-07-29
  docker-distribution = throw "'docker-distribution' has been renamed to/replaced by 'distribution'"; # Converted to throw 2024-10-21
  dolphin-emu-beta = throw "'dolphin-emu-beta' has been renamed to/replaced by 'dolphin-emu'"; # Converted to throw 2024-10-21
  dolphinEmu = throw "'dolphinEmu' has been renamed to/replaced by 'dolphin-emu'"; # Converted to throw 2024-10-17
  dolphinEmuMaster = throw "'dolphinEmuMaster' has been renamed to/replaced by 'dolphin-emu-beta'"; # Converted to throw 2024-10-17
  dotty = throw "'dotty' has been renamed to/replaced by 'scala_3'"; # Converted to throw 2024-10-21
  dotnet-netcore = throw "'dotnet-netcore' has been renamed to/replaced by 'dotnet-runtime'"; # Converted to throw 2024-10-17
  dotnet-sdk_2 = throw "'dotnet-sdk_2' has been renamed to/replaced by 'dotnetCorePackages.sdk_2_1'"; # Converted to throw 2024-10-17
  dotnet-sdk_3 = throw "'dotnet-sdk_3' has been renamed to/replaced by 'dotnetCorePackages.sdk_3_1'"; # Converted to throw 2024-10-17
  dotnet-sdk_5 = throw "'dotnet-sdk_5' has been renamed to/replaced by 'dotnetCorePackages.sdk_5_0'"; # Converted to throw 2024-10-17
  drush = throw "drush as a standalone package has been removed because it's no longer supported as a standalone tool";
  dtv-scan-tables_linuxtv = throw "'dtv-scan-tables_linuxtv' has been renamed to/replaced by 'dtv-scan-tables'"; # Converted to throw 2024-10-21
  dtv-scan-tables_tvheadend = throw "'dtv-scan-tables_tvheadend' has been renamed to/replaced by 'dtv-scan-tables'"; # Converted to throw 2024-10-21
  du-dust = throw "'du-dust' has been renamed to/replaced by 'dust'"; # Converted to throw 2024-10-21
  dylibbundler = throw "'dylibbundler' has been renamed to/replaced by 'macdylibbundler'"; # Converted to throw 2024-10-17

  ### E ###

  EBTKS = throw "'EBTKS' has been renamed to/replaced by 'ebtks'"; # Converted to throw 2024-10-21
  eask = eask-cli; # Added 2024-09-05
  ec2_ami_tools = throw "'ec2_ami_tools' has been renamed to/replaced by 'ec2-ami-tools'"; # Converted to throw 2024-10-17
  ec2_api_tools = throw "'ec2_api_tools' has been renamed to/replaced by 'ec2-api-tools'"; # Converted to throw 2024-10-17
  ec2-utils = throw "'ec2-utils' has been renamed to/replaced by 'amazon-ec2-utils'"; # Converted to throw 2024-10-21

  edUnstable = throw "edUnstable was removed; use ed instead"; # Added 2024-07-01
  elasticsearch7Plugins = elasticsearchPlugins;

  # Electron


  elixir_ls = throw "'elixir_ls' has been renamed to/replaced by 'elixir-ls'"; # Converted to throw 2024-10-21

  # Emacs
  emacs28-gtk2 = throw "emacs28-gtk2 was removed because GTK2 is EOL; migrate to emacs28{,-gtk3,-nox} or to more recent versions of Emacs."; # Added 2024-09-20
  emacs28NativeComp = throw "'emacs28NativeComp' has been renamed to/replaced by 'emacs28'"; # Converted to throw 2024-10-21
  emacs28Packages = throw "'emacs28Packages' has been renamed to/replaced by 'emacs28.pkgs'"; # Converted to throw 2024-10-17
  emacs28WithPackages = throw "'emacs28WithPackages' has been renamed to/replaced by 'emacs28.pkgs.withPackages'"; # Converted to throw 2024-10-17
  emacsMacport = throw "'emacsMacport' has been renamed to/replaced by 'emacs-macport'"; # Converted to throw 2024-10-21
  emacsNativeComp = throw "'emacsNativeComp' has been renamed to/replaced by 'emacs28NativeComp'"; # Converted to throw 2024-10-21
  emacsWithPackages = throw "'emacsWithPackages' has been renamed to/replaced by 'emacs.pkgs.withPackages'"; # Converted to throw 2024-10-17

  EmptyEpsilon = empty-epsilon; # Added 2024-07-14
  enyo-doom = throw "'enyo-doom' has been renamed to/replaced by 'enyo-launcher'"; # Converted to throw 2024-10-21
  epoxy = throw "'epoxy' has been renamed to/replaced by 'libepoxy'"; # Converted to throw 2024-10-17

  erlang_27-rc3 = throw "erlang_27-rc3 has been removed in favor of erlang_27"; # added 2024-05-20
  erlangR24 = throw "erlangR24 has been removed in favor of erlang_24"; # added 2024-05-24
  erlangR24_odbc = throw "erlangR24_odbc has been removed in favor of erlang_24_odbc"; # added 2024-05-24
  erlangR24_javac = throw "erlangR24_javac has been removed in favor of erlang_24_javac"; # added 2024-05-24
  erlangR24_odbc_javac = throw "erlangR24_odbc_javac has been removed in favor of erlang_24_odbc_javac"; # added 2024-05-24
  erlangR25 = throw "erlangR25 has been removed in favor of erlang_25"; # added 2024-05-24
  erlangR25_odbc = throw "erlangR25_odbc has been removed in favor of erlang_25_odbc"; # added 2024-05-24
  erlangR25_javac = throw "erlangR25_javac has been removed in favor of erlang_25_javac"; # added 2024-05-24
  erlangR25_odbc_javac = throw "erlangR25_odbc_javac has been removed in favor of erlang_25_odbc_javac"; # added 2024-05-24
  erlangR26 = throw "erlangR26 has been removed in favor of erlang_26"; # added 2024-05-24
  erlangR26_odbc = throw "erlangR26_odbc has been removed in favor of erlang_26_odbc"; # added 2024-05-24
  erlangR26_javac = throw "erlangR26_javac has been removed in favor of erlang_26_javac"; # added 2024-05-24
  erlangR26_odbc_javac = throw "erlangR26_odbc_javac has been removed in favor of erlang_26_odbc_javac"; # added 2024-05-24

  ethabi = throw "ethabi has been removed due to lack of maintainence upstream and no updates in Nixpkgs"; # Added 2024-07-16
  eww-wayland = lib.warn "eww now can build for X11 and wayland simultaneously, so `eww-wayland` is deprecated, use the normal `eww` package instead." eww;

  ### F ###

  fahcontrol = throw "fahcontrol has been removed because the download is no longer available"; # added 2024-09-24
  fahviewer = throw "fahviewer has been removed because the download is no longer available"; # added 2024-09-24
  fam = throw "'fam' (aliased to 'gamin') has been removed as it is unmaintained upstream"; # Added 2024-04-19
  faustStk = throw "'faustStk' has been renamed to/replaced by 'faustPhysicalModeling'"; # Converted to throw 2024-10-21
  fastnlo = throw "'fastnlo' has been renamed to/replaced by 'fastnlo-toolkit'"; # Converted to throw 2024-10-17
  fastnlo_toolkit = throw "'fastnlo_toolkit' has been renamed to/replaced by 'fastnlo-toolkit'"; # Converted to throw 2024-10-21
  fcitx5-catppuccin = catppuccin-fcitx5; # Added 2024-06-19
  inherit (luaPackages) fennel; # Added 2022-09-24
  ferdi = throw "'ferdi' has been removed, upstream does not exist anymore and the package is insecure"; # Added 2024-08-22
  fetchFromGithub = throw "You meant fetchFromGitHub, with a capital H"; # preserve
  ffmpeg_5 = throw "ffmpeg_5 has been removed, please use another version"; # Added 2024-07-12
  ffmpeg_5-headless = throw "ffmpeg_5-headless has been removed, please use another version"; # Added 2024-07-12
  ffmpeg_5-full = throw "ffmpeg_5-full has been removed, please use another version"; # Added 2024-07-12
  FIL-plugins = fil-plugins; # Added 2024-06-12
  fileschanged = throw "'fileschanged' has been removed as it is unmaintained upstream"; # Added 2024-04-19
  finger_bsd = bsd-finger;
  fingerd_bsd = bsd-fingerd;
  firefox-esr-115 = throw "The Firefox 115 ESR series has reached its end of life. Upgrade to `firefox-esr` or `firefox-esr-128` instead.";
  firefox-esr-115-unwrapped = throw "The Firefox 115 ESR series has reached its end of life. Upgrade to `firefox-esr-unwrapped` or `firefox-esr-128-unwrapped` instead.";
  firefox-wayland = throw "'firefox-wayland' has been renamed to/replaced by 'firefox'"; # Converted to throw 2024-10-21
  firmwareLinuxNonfree = throw "'firmwareLinuxNonfree' has been renamed to/replaced by 'linux-firmware'"; # Converted to throw 2024-10-21
  fishfight = throw "'fishfight' has been renamed to/replaced by 'jumpy'"; # Converted to throw 2024-10-21
  fit-trackee = fittrackee; # added 2024-09-03
  flashrom-stable = throw "'flashrom-stable' has been renamed to/replaced by 'flashprog'"; # Converted to throw 2024-10-21
  flatbuffers_2_0 = throw "'flatbuffers_2_0' has been renamed to/replaced by 'flatbuffers'"; # Converted to throw 2024-10-21
  flutter313 = throw "flutter313 has been removed because it isn't updated anymore, and no packages in nixpkgs use it. If you still need it, use flutter.mkFlutter to get a custom version"; # Added 2024-10-05
  flutter316 = throw "flutter316 has been removed because it isn't updated anymore, and no packages in nixpkgs use it. If you still need it, use flutter.mkFlutter to get a custom version"; # Added 2024-10-05
  flutter322 = throw "flutter322 has been removed because it isn't updated anymore, and no packages in nixpkgs use it. If you still need it, use flutter.mkFlutter to get a custom version"; # Added 2024-10-05
  flutter323 = throw "flutter323 has been removed because it isn't updated anymore, and no packages in nixpkgs use it. If you still need it, use flutter.mkFlutter to get a custom version"; # Added 2024-10-05
  foldingathome = throw "'foldingathome' has been renamed to/replaced by 'fahclient'"; # Converted to throw 2024-10-17
  forgejo-actions-runner = forgejo-runner; # Added 2024-04-04

  fractal-next = throw "'fractal-next' has been renamed to/replaced by 'fractal'"; # Converted to throw 2024-10-21
  framework-system-tools = throw "'framework-system-tools' has been renamed to/replaced by 'framework-tool'"; # Converted to throw 2024-10-21
  francis = kdePackages.francis; # added 2024-07-13
  frostwire = throw "frostwire was removed, as it was broken due to reproducibility issues, use `frostwire-bin` package instead."; # added 2024-05-17
  fuse2fs = if stdenv.hostPlatform.isLinux then e2fsprogs.fuse2fs else null; # Added 2022-03-27 preserve, reason: convenience, arch has a package named fuse2fs too.
  futuresql = throw "'futuresql' has been renamed to/replaced by 'libsForQt5.futuresql'"; # Converted to throw 2024-10-21
  fx_cast_bridge = throw "'fx_cast_bridge' has been renamed to/replaced by 'fx-cast-bridge'"; # Converted to throw 2024-10-21


  fcitx5-chinese-addons = throw "'fcitx5-chinese-addons' has been renamed to/replaced by 'libsForQt5.fcitx5-chinese-addons'"; # Converted to throw 2024-10-21
  fcitx5-configtool = throw "'fcitx5-configtool' has been renamed to/replaced by 'libsForQt5.fcitx5-configtool'"; # Converted to throw 2024-10-21
  fcitx5-skk-qt = throw "'fcitx5-skk-qt' has been renamed to/replaced by 'libsForQt5.fcitx5-skk-qt'"; # Converted to throw 2024-10-21
  fcitx5-unikey = throw "'fcitx5-unikey' has been renamed to/replaced by 'libsForQt5.fcitx5-unikey'"; # Converted to throw 2024-10-21
  fcitx5-with-addons = throw "'fcitx5-with-addons' has been renamed to/replaced by 'libsForQt5.fcitx5-with-addons'"; # Converted to throw 2024-10-21

  ### G ###

  g4music = gapless; # Added 2024-07-26
  g4py = throw "'g4py' has been renamed to/replaced by 'python3Packages.geant4'"; # Converted to throw 2024-10-17
  gamin = throw "'gamin' has been removed as it is unmaintained upstream"; # Added 2024-04-19
  gcc48 = throw "gcc48 has been removed from Nixpkgs, as it is unmaintained and obsolete"; # Added 2024-09-10
  gcc49 = throw "gcc49 has been removed from Nixpkgs, as it is unmaintained and obsolete"; # Added 2024-09-11
  gcc49Stdenv = throw "gcc49Stdenv has been removed from Nixpkgs, as it is unmaintained and obsolete"; # Added 2024-09-11
  gcc6 = throw "gcc6 has been removed from Nixpkgs, as it is unmaintained and obsolete"; # Added 2024-09-13
  gcc6Stdenv = throw "gcc6Stdenv has been removed from Nixpkgs, as it is unmaintained and obsolete"; # Added 2024-09-13
  gcc10StdenvCompat = if stdenv.cc.isGNU && lib.versionAtLeast stdenv.cc.version "11" then gcc10Stdenv else stdenv; # Added 2024-03-21
  gcj = gcj6; # Added 2024-09-13
  gcj6 = throw "gcj6 has been removed from Nixpkgs, as it is unmaintained and obsolete"; # Added 2024-09-13
  gcolor2 = throw "'gcolor2' has been removed due to lack of maintenance upstream and depending on gtk2. Consider using 'gcolor3' or 'eyedropper' instead"; # Added 2024-09-15
  gfortran48 = throw "'gfortran48' has been removed from nixpkgs"; # Added 2024-09-10
  gfortran49 = throw "'gfortran49' has been removed from nixpkgs"; # Added 2024-09-11
  ghostwriter = throw "'ghostwriter' has been renamed to/replaced by 'libsForQt5.kdeGear.ghostwriter'"; # Converted to throw 2024-10-21
  gmpc = throw "'gmpc' has been removed due to lack of maintenance upstream. Consider using 'plattenalbum' instead"; # Added 2024-09-14
  gmtk = throw "'gmtk' has been removed due to lack of maintenance upstream"; # Added 2024-09-14
  gmtp = throw "'gmtp' has been removed due to lack of maintenance upstream. Consider using 'gnome-music' instead"; # Added 2024-09-14
  gnome-latex = throw "'gnome-latex' has been superseded by 'enter-tex'"; # Added 2024-09-18
  gnu-cobol = gnucobol; # Added 2024-09-17
  gogs = throw ''
    Gogs development has stalled. Also, it has several unpatched, critical vulnerabilities that
    weren't addressed within a year: https://github.com/gogs/gogs/issues/7777

    Consider migrating to forgejo or gitea.
  ''; # Added 2024-10-12
  git-backup = throw "git-backup has been removed, as it has been abandoned upstream. Consider using git-backup-go instead.";
  git-credential-1password = throw "'git-credential-1password' has been removed, as the upstream project is deleted."; # Added 2024-05-20

  gitAndTools = self // {
    darcsToGit = darcs-to-git;
    gitAnnex = git-annex;
    gitBrunch = git-brunch;
    gitFastExport = git-fast-export;
    gitRemoteGcrypt = git-remote-gcrypt;
    svn_all_fast_export = svn-all-fast-export;
    topGit = top-git;
  }; # Added 2021-01-14

  glew-egl = lib.warn "'glew-egl' is now provided by 'glew' directly" glew; # Added 2024-08-11
  glfw-wayland = glfw; # Added 2024-04-19
  glfw-wayland-minecraft = glfw3-minecraft; # Added 2024-05-08
  globalprotect-openconnect = throw "'globalprotect-openconnect' has been renamed to/replaced by 'gpauth' and 'gpclient'"; # Added 2024-09-21
  glxinfo = mesa-demos; # Added 2024-07-04
  gmailieer = throw "'gmailieer' has been renamed to/replaced by 'lieer'"; # Converted to throw 2024-10-17
  gnatboot11 = gnat-bootstrap11;
  gnatboot12 = gnat-bootstrap12;
  gnatboot = gnat-bootstrap;
  gnatcoll-core = throw "'gnatcoll-core' has been renamed to/replaced by 'gnatPackages.gnatcoll-core'"; # Converted to throw 2024-10-21
  gnatcoll-gmp = throw "'gnatcoll-gmp' has been renamed to/replaced by 'gnatPackages.gnatcoll-gmp'"; # Converted to throw 2024-10-21
  gnatcoll-iconv = throw "'gnatcoll-iconv' has been renamed to/replaced by 'gnatPackages.gnatcoll-iconv'"; # Converted to throw 2024-10-21
  gnatcoll-lzma = throw "'gnatcoll-lzma' has been renamed to/replaced by 'gnatPackages.gnatcoll-lzma'"; # Converted to throw 2024-10-21
  gnatcoll-omp = throw "'gnatcoll-omp' has been renamed to/replaced by 'gnatPackages.gnatcoll-omp'"; # Converted to throw 2024-10-21
  gnatcoll-python3 = throw "'gnatcoll-python3' has been renamed to/replaced by 'gnatPackages.gnatcoll-python3'"; # Converted to throw 2024-10-21
  gnatcoll-readline = throw "'gnatcoll-readline' has been renamed to/replaced by 'gnatPackages.gnatcoll-readline'"; # Converted to throw 2024-10-21
  gnatcoll-syslog = throw "'gnatcoll-syslog' has been renamed to/replaced by 'gnatPackages.gnatcoll-syslog'"; # Converted to throw 2024-10-21
  gnatcoll-zlib = throw "'gnatcoll-zlib' has been renamed to/replaced by 'gnatPackages.gnatcoll-zlib'"; # Converted to throw 2024-10-21
  gnatcoll-postgres = throw "'gnatcoll-postgres' has been renamed to/replaced by 'gnatPackages.gnatcoll-postgres'"; # Converted to throw 2024-10-21
  gnatcoll-sql = throw "'gnatcoll-sql' has been renamed to/replaced by 'gnatPackages.gnatcoll-sql'"; # Converted to throw 2024-10-21
  gnatcoll-sqlite = throw "'gnatcoll-sqlite' has been renamed to/replaced by 'gnatPackages.gnatcoll-sqlite'"; # Converted to throw 2024-10-21
  gnatcoll-xref = throw "'gnatcoll-xref' has been renamed to/replaced by 'gnatPackages.gnatcoll-xref'"; # Converted to throw 2024-10-21
  gnatcoll-db2ada = throw "'gnatcoll-db2ada' has been renamed to/replaced by 'gnatPackages.gnatcoll-db2ada'"; # Converted to throw 2024-10-21
  gnatinspect = throw "'gnatinspect' has been renamed to/replaced by 'gnatPackages.gnatinspect'"; # Converted to throw 2024-10-21
  gnome-dictionary = throw "'gnome-dictionary' has been removed as it has been archived upstream. Consider using 'wordbook' instead"; # Added 2024-09-14
  gnome-firmware-updater = throw "'gnome-firmware-updater' has been renamed to/replaced by 'gnome-firmware'"; # Converted to throw 2024-10-21
  gnome-hexgl = throw "'gnome-hexgl' has been removed due to lack of maintenance upstream"; # Added 2024-09-14
  gnome-passwordsafe = throw "'gnome-passwordsafe' has been renamed to/replaced by 'gnome-secrets'"; # Converted to throw 2024-10-21
  gnome_mplayer = throw "'gnome_mplayer' has been removed due to lack of maintenance upstream. Consider using 'celluloid' instead"; # Added 2024-09-14
  gnome-resources = throw "'gnome-resources' has been renamed to/replaced by 'resources'"; # Converted to throw 2024-10-21

  gmock = throw "'gmock' has been renamed to/replaced by 'gtest'"; # Converted to throw 2024-10-17

  gnome3 = throw "'gnome3' has been renamed to/replaced by 'gnome'"; # Converted to throw 2024-10-17
  gnuradio3_9 = throw "gnuradio3_9 has been removed because it is not compatible with the latest volk and it had no dependent packages which justified it's distribution"; # Added 2024-07-28
  gnuradio3_9Minimal = throw "gnuradio3_9Minimal has been removed because it is not compatible with the latest volk and it had no dependent packages which justified it's distribution"; # Added 2024-07-28
  gnuradio3_9Packages = throw "gnuradio3_9Minimal has been removed because it is not compatible with the latest volk and it had no dependent packages which justified it's distribution"; # Added 2024-07-28
  gobby5 = throw "'gobby5' has been renamed to/replaced by 'gobby'"; # Converted to throw 2024-10-17

  #godot


  go-thumbnailer = throw "'go-thumbnailer' has been renamed to/replaced by 'thud'"; # Converted to throw 2024-10-21
  go-upower-notify = upower-notify; # Added 2024-07-21
  gpicview = throw "'gpicview' has been removed due to lack of maintenance upstream and depending on gtk2. Consider using 'loupe', 'gthumb' or 'image-roll' instead"; # Added 2024-09-15
  gprbuild-boot = gnatPackages.gprbuild-boot; # Added 2024-02-25;

  gqview = throw "'gqview' has been removed due to lack of maintenance upstream and depending on gtk2. Consider using 'gthumb' instead";
  grafana_reporter = grafana-reporter; # Added 2024-06-09
  grapefruit = throw "'grapefruit' was removed due to being blocked by Roblox, rendering the package useless"; # Added 2024-08-23
  gringo = throw "'gringo' has been renamed to/replaced by 'clingo'"; # Converted to throw 2024-10-21
  grub2_full = throw "'grub2_full' has been renamed to/replaced by 'grub2'"; # Converted to throw 2024-10-21
  gtetrinet = throw "'gtetrinet' has been removed because it depends on GNOME 2 libraries"; # Added 2024-06-27
  gtkcord4 = throw "'gtkcord4' has been renamed to/replaced by 'dissent'"; # Converted to throw 2024-10-21
  gtkperf = throw "'gtkperf' has been removed due to lack of maintenance upstream"; # Added 2024-09-14
  guardian-agent = throw "'guardian-agent' has been removed, as it hasn't been maintained upstream in years and accumulated many vulnerabilities"; # Added 2024-06-09
  guile-disarchive = throw "'guile-disarchive' has been renamed to/replaced by 'disarchive'"; # Converted to throw 2024-10-21

  ### H ###

  HentaiAtHome = hentai-at-home; # Added 2024-06-12
  hll2390dw-cups = throw "The hll2390dw-cups package was dropped since it was unmaintained."; # Added 2024-06-21
  hop-cli = throw "hop-cli has been removed as the service has been shut-down"; # Added 2024-08-13
  ht-rust = throw "'ht-rust' has been renamed to/replaced by 'xh'"; # Converted to throw 2024-10-17
  hydra_unstable = hydra; # Added 2024-08-22
  hydron = throw "hydron has been removed as the project has been archived upstream since 2022 and is affected by a severe remote code execution vulnerability";


  ### I ###

  i3-gaps = throw "'i3-gaps' has been renamed to/replaced by 'i3'"; # Converted to throw 2024-10-21
  ib-tws = throw "ib-tws has been removed from nixpkgs as it was broken"; # Added 2024-07-15
  ib-controller = throw "ib-controller has been removed from nixpkgs as it was broken"; # Added 2024-07-15
  imagemagick7Big = throw "'imagemagick7Big' has been renamed to/replaced by 'imagemagickBig'"; # Converted to throw 2024-10-17
  imagemagick7 = throw "'imagemagick7' has been renamed to/replaced by 'imagemagick'"; # Converted to throw 2024-10-17
  imagemagick7_light = throw "'imagemagick7_light' has been renamed to/replaced by 'imagemagick_light'"; # Converted to throw 2024-10-17
  immersed-vr = lib.warn "'immersed-vr' has been renamed to 'immersed'" immersed; # Added 2024-08-11
  input-utils = throw "The input-utils package was dropped since it was unmaintained."; # Added 2024-06-21
  index-fm = throw "'index-fm' has been renamed to/replaced by 'libsForQt5.mauiPackages.index'"; # Converted to throw 2024-10-21
  inotifyTools = inotify-tools;
  inter-ui = throw "'inter-ui' has been renamed to/replaced by 'inter'"; # Converted to throw 2024-10-17
  ipfs = throw "'ipfs' has been renamed to/replaced by 'kubo'"; # Converted to throw 2024-10-21
  ipfs-migrator-all-fs-repo-migrations = throw "'ipfs-migrator-all-fs-repo-migrations' has been renamed to/replaced by 'kubo-migrator-all-fs-repo-migrations'"; # Converted to throw 2024-10-21
  ipfs-migrator-unwrapped = throw "'ipfs-migrator-unwrapped' has been renamed to/replaced by 'kubo-migrator-unwrapped'"; # Converted to throw 2024-10-21
  ipfs-migrator = throw "'ipfs-migrator' has been renamed to/replaced by 'kubo-migrator'"; # Converted to throw 2024-10-21
  iproute = throw "'iproute' has been renamed to/replaced by 'iproute2'"; # Converted to throw 2024-10-17
  irrlichtmt = throw "irrlichtmt has been removed because it was moved into the Minetest repo"; # Added 2024-08-12
  isl_0_11 = throw "isl_0_11 has been removed from Nixpkgs, as it is unmaintained and obsolete"; # Added 2024-09-13
  isl_0_14 = throw "isl_0_14 has been removed from Nixpkgs, as it is unmaintained and obsolete"; # Added 2024-09-13
  iso-flags-png-320x420 = lib.warn "iso-flags-png-320x420 has been renamed to iso-flags-png-320x240" iso-flags-png-320x240; # Added 2024-07-17

  ### J ###


  jack2Full = throw "'jack2Full' has been renamed to/replaced by 'jack2'"; # Converted to throw 2024-10-17
  jami-client-qt = throw "'jami-client-qt' has been renamed to/replaced by 'jami-client'"; # Converted to throw 2024-10-21
  jami-client = throw "'jami-client' has been renamed to/replaced by 'jami'"; # Converted to throw 2024-10-21
  jami-daemon = throw "'jami-daemon' has been renamed to/replaced by 'jami.daemon'"; # Converted to throw 2024-10-21
  jsawk = throw "'jsawk' has been removed because it is unmaintained upstream"; # Added 2028-08-07

  # Julia
  julia_16-bin = throw "'julia_16-bin' has been removed from nixpkgs as it has reached end of life"; # Added 2024-10-08

  jush = throw "jush has been removed from nixpkgs because it is unmaintained"; # Added 2024-05-28

  ### K ###

  k3s_1_26 = throw "'k3s_1_26' has been removed from nixpkgs as it has reached end of life"; # Added 2024-05-20
  k3s_1_27 = throw "'k3s_1_27' has been removed from nixpkgs as it has reached end of life on 2024-06-28"; # Added 2024-06-01
  # k3d was a 3d editing software k-3d - "k3d has been removed because it was broken and has seen no release since 2016" Added 2022-01-04
  # now kube3d/k3d will take it's place
  kube3d = k3d; # Added 2022-0705
  kafkacat = throw "'kafkacat' has been renamed to/replaced by 'kcat'"; # Converted to throw 2024-10-17
  kak-lsp = throw "'kak-lsp' has been renamed to/replaced by 'kakoune-lsp'"; # Converted to throw 2024-10-21
  kargo = throw "kargo was removed as it is deprecated upstream and depends on the removed boto package"; # Added 2024-09-22
  kdbplus = throw "'kdbplus' has been removed from nixpkgs"; # Added 2024-05-06
  kdeconnect = throw "'kdeconnect' has been renamed to/replaced by 'plasma5Packages.kdeconnect-kde'"; # Converted to throw 2024-10-17
  keepkey_agent = throw "'keepkey_agent' has been renamed to/replaced by 'keepkey-agent'"; # Converted to throw 2024-10-21
  kerberos = throw "'kerberos' has been renamed to/replaced by 'krb5'"; # Converted to throw 2024-10-17
  kexectools = throw "'kexectools' has been renamed to/replaced by 'kexec-tools'"; # Converted to throw 2024-10-17
  keyfinger = throw "keyfinder has been removed as it was abandoned upstream and did not build; consider using mixxx or keyfinder-cli"; # Addd 2024-08-25
  keysmith = throw "'keysmith' has been renamed to/replaced by 'libsForQt5.kdeGear.keysmith'"; # Converted to throw 2024-10-17
  kgx = throw "'kgx' has been renamed to/replaced by 'gnome-console'"; # Converted to throw 2024-10-21
  kibana7 = throw "Kibana 7.x has been removed from nixpkgs as it depends on an end of life Node.js version and received no maintenance in time."; # Added 2023-30-10
  kibana = kibana7;
  kio-admin = throw "'kio-admin' has been renamed to/replaced by 'libsForQt5.kdeGear.kio-admin'"; # Converted to throw 2024-10-21
  kiwitalk = throw "KiwiTalk has been removed because the upstream has been deprecated at the request of Kakao and it's now obsolete."; # Added 2024-10-10
  kodiGBM = kodi-gbm;
  kodiPlain = kodi;
  kodiPlainWayland = kodi-wayland;
  kodiPlugins = kodiPackages; # Added 2021-03-09;
  kramdown-rfc2629 = throw "'kramdown-rfc2629' has been renamed to/replaced by 'rubyPackages.kramdown-rfc2629'"; # Converted to throw 2024-10-17
  krb5Full = krb5;
  krita-beta = throw "'krita-beta' has been renamed to/replaced by 'krita'"; # Converted to throw 2024-10-17
  kubei = throw "'kubei' has been renamed to/replaced by 'kubeclarity'"; # Converted to throw 2024-10-21

  ### L ###

  l3afpad = throw "'l3afpad' has been removed due to lack of maintenance upstream. Consider using 'xfce.mousepad' instead"; # Added 2024-09-14
  larynx = throw "'larynx' has been renamed to/replaced by 'piper-tts'"; # Converted to throw 2024-10-21
  LASzip = laszip; # Added 2024-06-12
  LASzip2 = laszip_2; # Added 2024-06-12
  latinmodern-math = lmmath;
  ledger_agent = throw "'ledger_agent' has been renamed to/replaced by 'ledger-agent'"; # Converted to throw 2024-10-21
  lfs = throw "'lfs' has been renamed to/replaced by 'dysk'"; # Converted to throw 2024-10-21
  libAfterImage = throw "'libAfterImage' has been removed from nixpkgs, as it's no longer in development for a long time"; # Added 2024-06-01
  libav = throw "libav has been removed as it was insecure and abandoned upstream for over half a decade; please use FFmpeg"; # Added 2024-08-25
  libav_0_8 = libav; # Added 2024-08-25
  libav_11 = libav; # Added 2024-08-25
  libav_12 = libav; # Added 2024-08-25
  libav_all = libav; # Added 2024-08-25
  libayatana-indicator-gtk3 = throw "'libayatana-indicator-gtk3' has been renamed to/replaced by 'libayatana-indicator'"; # Converted to throw 2024-10-21
  libayatana-appindicator-gtk3 = throw "'libayatana-appindicator-gtk3' has been renamed to/replaced by 'libayatana-appindicator'"; # Converted to throw 2024-10-21
  libbencodetools = throw "'libbencodetools' has been renamed to/replaced by 'bencodetools'"; # Converted to throw 2024-10-21
  libbpf_1 = throw "'libbpf_1' has been renamed to/replaced by 'libbpf'"; # Converted to throw 2024-10-21
  libbson = throw "'libbson' has been renamed to/replaced by 'mongoc'"; # Converted to throw 2024-10-21
  libgme = throw "'libgme' has been renamed to/replaced by 'game-music-emu'"; # Converted to throw 2024-10-21
  libgnome-keyring3 = libgnome-keyring; # Added 2024-06-22
  libgpgerror = throw "'libgpgerror' has been renamed to/replaced by 'libgpg-error'"; # Converted to throw 2024-10-17
  libheimdal = throw "'libheimdal' has been renamed to/replaced by 'heimdal'"; # Converted to throw 2024-10-21
  libixp_hg = libixp;
  libjpeg_drop = throw "'libjpeg_drop' has been renamed to/replaced by 'libjpeg_original'"; # Converted to throw 2024-10-17
  liblastfm = throw "'liblastfm' has been renamed to/replaced by 'libsForQt5.liblastfm'"; # Converted to throw 2024-10-17
  liboop = throw "liboop has been removed as it is unmaintained upstream."; # Added 2024-08-14
  libpqxx_6 = throw "libpqxx_6 has been removed, please use libpqxx"; # Added 2024-10-02
  libpulseaudio-vanilla = throw "'libpulseaudio-vanilla' has been renamed to/replaced by 'libpulseaudio'"; # Converted to throw 2024-10-21
  libquotient = throw "'libquotient' has been renamed to/replaced by 'libsForQt5.libquotient'"; # Converted to throw 2024-10-21
  librarian-puppet-go = throw "'librarian-puppet-go' has been removed, as it's upstream is unmaintained"; # Added 2024-06-10
  librdf = throw "'librdf' has been renamed to/replaced by 'lrdf'"; # Converted to throw 2024-10-17
  LibreArp = librearp; # Added 2024-06-12
  LibreArp-lv2 = librearp-lv2; # Added 2024-06-12
  libreddit = throw "'libreddit' has been removed because it is unmaintained upstream. Consider using 'redlib', a maintained fork"; # Added 2024-07-17
  librtlsdr = throw "'librtlsdr' has been renamed to/replaced by 'rtl-sdr'"; # Converted to throw 2024-10-21
  librewolf-wayland = throw "'librewolf-wayland' has been renamed to/replaced by 'librewolf'"; # Converted to throw 2024-10-21
  libseat = throw "'libseat' has been renamed to/replaced by 'seatd'"; # Converted to throw 2024-10-17
  libsForQt515 = throw "'libsForQt515' has been renamed to/replaced by 'libsForQt5'"; # Converted to throw 2024-10-21
  libtensorflow-bin = throw "'libtensorflow-bin' has been renamed to/replaced by 'libtensorflow'"; # Converted to throw 2024-10-21
  libtorrentRasterbar = throw "'libtorrentRasterbar' has been renamed to/replaced by 'libtorrent-rasterbar'"; # Converted to throw 2024-10-17
  libtorrentRasterbar-1_2_x = throw "'libtorrentRasterbar-1_2_x' has been renamed to/replaced by 'libtorrent-rasterbar-1_2_x'"; # Converted to throw 2024-10-17
  libtorrentRasterbar-2_0_x = throw "'libtorrentRasterbar-2_0_x' has been renamed to/replaced by 'libtorrent-rasterbar-2_0_x'"; # Converted to throw 2024-10-17
  libungif = throw "'libungif' has been renamed to/replaced by 'giflib'"; # Converted to throw 2024-10-17
  libusb = throw "'libusb' has been renamed to/replaced by 'libusb1'"; # Converted to throw 2024-10-17
  libvpx_1_8 = throw "libvpx_1_8 has been removed because it is impacted by security issues and not used in nixpkgs, move to 'libvpx'"; # Added 2024-07-26
  libwnck3 = libwnck;
  libyamlcpp = throw "'libyamlcpp' has been renamed to/replaced by 'yaml-cpp'"; # Converted to throw 2024-10-21
  libyamlcpp_0_3 = throw "'libyamlcpp_0_3' has been renamed to/replaced by 'yaml-cpp_0_3'"; # Converted to throw 2024-10-21
  lightdm_gtk_greeter = throw "'lightdm_gtk_greeter' has been renamed to/replaced by 'lightdm-gtk-greeter'"; # Converted to throw 2024-10-21
  lightstep-tracer-cpp = throw "lightstep-tracer-cpp is deprecated since 2022-08-29; the upstream recommends migration to opentelemetry projects.";
  linux_wallpaperengine = throw "linux_wallpaperengine was removed due to freeimage dependency"; # Added 2024-07-19
  lispPackages_new = throw "Lisp packages have been redesigned. See 'lisp-modules' in the nixpkgs manual."; # Added 2024-05-07
  lispPackages = throw "Lisp packages have been redesigned. See 'lisp-modules' in the nixpkgs manual."; # Added 2024-05-07
  lispPackagesFor = throw "Lisp packages have been redesigned. See 'lisp-modules' in the nixpkgs manual."; # Added 2024-05-07
  Literate = literate; # Added 2024-06-12
  llama = throw "'llama' has been renamed to/replaced by 'walk'"; # Converted to throw 2024-10-21

  # Linux kernels
  linux-rt_5_10 = linuxKernel.kernels.linux_rt_5_10;
  linux-rt_5_15 = linuxKernel.kernels.linux_rt_5_15;
  linux-rt_5_4 = linuxKernel.kernels.linux_rt_5_4;
  linux-rt_6_1 = linuxKernel.kernels.linux_rt_6_1;
  linuxPackages_4_14 = linuxKernel.packages.linux_4_14;
  linuxPackages_4_19 = linuxKernel.packages.linux_4_19;
  linuxPackages_5_4 = linuxKernel.packages.linux_5_4;
  linuxPackages_5_10 = linuxKernel.packages.linux_5_10;
  linuxPackages_5_15 = linuxKernel.packages.linux_5_15;
  linuxPackages_6_1 = linuxKernel.packages.linux_6_1;
  linuxPackages_6_4 = linuxKernel.packages.linux_6_4;
  linuxPackages_6_5 = linuxKernel.packages.linux_6_5;
  linuxPackages_6_6 = linuxKernel.packages.linux_6_6;
  linuxPackages_6_7 = linuxKernel.packages.linux_6_7;
  linuxPackages_6_8 = linuxKernel.packages.linux_6_8;
  linuxPackages_6_9 = linuxKernel.packages.linux_6_9;
  linuxPackages_6_10 = linuxKernel.packages.linux_6_10;
  linuxPackages_6_11 = linuxKernel.packages.linux_6_11;
  linuxPackages_rpi0 = linuxKernel.packages.linux_rpi1;
  linuxPackages_rpi02w = linuxKernel.packages.linux_rpi3;
  linuxPackages_rpi1 = linuxKernel.packages.linux_rpi1;
  linuxPackages_rpi2 = linuxKernel.packages.linux_rpi2;
  linuxPackages_rpi3 = linuxKernel.packages.linux_rpi3;
  linuxPackages_rpi4 = linuxKernel.packages.linux_rpi4;
  linuxPackages_rt_5_10 = linuxKernel.packages.linux_rt_5_10;
  linuxPackages_rt_5_15 = linuxKernel.packages.linux_rt_5_15;
  linuxPackages_rt_5_4 = linuxKernel.packages.linux_rt_5_4;
  linuxPackages_rt_6_1 = linuxKernel.packages.linux_rt_6_1;
  linux_4_14 = linuxKernel.kernels.linux_4_14;
  linux_4_19 = linuxKernel.kernels.linux_4_19;
  linux_5_4 = linuxKernel.kernels.linux_5_4;
  linux_5_10 = linuxKernel.kernels.linux_5_10;
  linux_5_15 = linuxKernel.kernels.linux_5_15;
  linux_6_1 = linuxKernel.kernels.linux_6_1;
  linux_6_4 = linuxKernel.kernels.linux_6_4;
  linux_6_5 = linuxKernel.kernels.linux_6_5;
  linux_6_6 = linuxKernel.kernels.linux_6_6;
  linux_6_7 = linuxKernel.kernels.linux_6_7;
  linux_6_8 = linuxKernel.kernels.linux_6_8;
  linux_6_9 = linuxKernel.kernels.linux_6_9;
  linux_6_10 = linuxKernel.kernels.linux_6_10;
  linux_6_11 = linuxKernel.kernels.linux_6_11;
  linux_rpi0 = linuxKernel.kernels.linux_rpi1;
  linux_rpi02w = linuxKernel.kernels.linux_rpi3;
  linux_rpi1 = linuxKernel.kernels.linux_rpi1;
  linux_rpi2 = linuxKernel.kernels.linux_rpi2;
  linux_rpi3 = linuxKernel.kernels.linux_rpi3;
  linux_rpi4 = linuxKernel.kernels.linux_rpi4;

  # Added 2021-04-04
  linuxPackages_xen_dom0 = linuxPackages;
  linuxPackages_latest_xen_dom0 = linuxPackages_latest;
  linuxPackages_xen_dom0_hardened = linuxPackages_hardened;
  linuxPackages_latest_xen_dom0_hardened = linuxPackages_latest_hardened;

  # Added 2021-08-16
  linuxPackages_latest_hardened = throw ''
    The attribute `linuxPackages_hardened_latest' was dropped because the hardened patches
    frequently lag behind the upstream kernel. In some cases this meant that this attribute
    had to refer to an older kernel[1] because the latest hardened kernel was EOL and
    the latest supported kernel didn't have patches.

    If you want to use a hardened kernel, please check which kernel minors are supported
    and use a versioned attribute, e.g. `linuxPackages_5_10_hardened'.

    [1] for more context: https://github.com/NixOS/nixpkgs/pull/133587
  '';
  linux_latest_hardened = linuxPackages_latest_hardened;

  # Added 2023-11-18, modified 2024-01-09
  linuxPackages_testing_bcachefs = throw "'linuxPackages_testing_bcachefs' has been removed, please use 'linuxPackages_latest', any kernel version at least 6.7, or any other linux kernel with bcachefs support";
  linux_testing_bcachefs = throw "'linux_testing_bcachefs' has been removed, please use 'linux_latest', any kernel version at least 6.7, or any other linux kernel with bcachefs support";

  llvmPackages_git = (callPackages ../development/compilers/llvm { }).git;

  lld_9 = throw "lld_9 has been removed from nixpkgs"; # Added 2024-04-08
  lldb_9 = throw "lldb_9 has been removed from nixpkgs"; # Added 2024-04-08
  llvmPackages_9 = throw "llvmPackages_9 has been removed from nixpkgs"; # Added 2024-04-08
  llvm_9 = throw "llvm_9 has been removed from nixpkgs"; # Added 2024-04-08

  lobster-two = throw "'lobster-two' has been renamed to/replaced by 'google-fonts'"; # Converted to throw 2024-10-17
  lsh = throw "lsh has been removed as it had no maintainer in Nixpkgs and hasn't seen an upstream release in over a decade"; # Added 2024-08-14
  lv_img_conv = throw "'lv_img_conv' has been removed from nixpkgs as it is broken"; # Added 2024-06-18
  lxd = throw "'lxd' has been renamed to/replaced by 'lib.warn'"; # Converted to throw 2024-10-21
  lxd-unwrapped = throw "'lxd-unwrapped' has been renamed to/replaced by 'lib.warn'"; # Converted to throw 2024-10-21
  lzma = throw "'lzma' has been renamed to/replaced by 'xz'"; # Converted to throw 2024-10-17

  ### M ###

  ma1sd = throw "ma1sd was dropped as it is unmaintained"; # Added 2024-07-10
  MACS2 = throw "'MACS2' has been renamed to/replaced by 'macs2'"; # Converted to throw 2024-10-21
  mailctl = throw "mailctl has been renamed to oama"; # Added 2024-08-19
  mailman-rss = throw "The mailman-rss package was dropped since it was unmaintained."; # Added 2024-06-21
  mariadb_110 = throw "mariadb_110 has been removed from nixpkgs, please switch to another version like mariadb_114"; # Added 2024-08-15
  mariadb-client = hiPrio mariadb.client; #added 2019.07.28
  maligned = throw "maligned was deprecated upstream in favor of x/tools/go/analysis/passes/fieldalignment"; # Added 20204-08-24
  marwaita-manjaro = lib.warn "marwaita-manjaro has been renamed to marwaita-teal" marwaita-teal; # Added 2024-07-08
  marwaita-peppermint = lib.warn "marwaita-peppermint has been renamed to marwaita-red" marwaita-red; # Added 2024-07-01
  marwaita-ubuntu = lib.warn "marwaita-ubuntu has been renamed to marwaita-orange" marwaita-orange; # Added 2024-07-08
  masari = throw "masari has been removed as it was abandoned upstream"; # Added 2024-07-11
  mathematica9 = throw "mathematica9 has been removed as it was obsolete, broken, and depended on OpenCV 2"; # Added 2024-08-20
  mathematica10 = throw "mathematica10 has been removed as it was obsolete, broken, and depended on OpenCV 2"; # Added 2024-08-20
  mathematica11 = throw "mathematica11 has been removed as it was obsolete, broken, and depended on OpenCV 2"; # Added 2024-08-20
  matrique = throw "'matrique' has been renamed to/replaced by 'spectral'"; # Converted to throw 2024-10-17
  matrix-sliding-sync = throw "matrix-sliding-sync has been removed as matrix-synapse 114.0 and later covers its functionality"; # Added 2024-10-20
  maui-nota = throw "'maui-nota' has been renamed to/replaced by 'libsForQt5.mauiPackages.nota'"; # Converted to throw 2024-10-21
  maui-shell = throw "maui-shell has been removed from nixpkgs, it was broken"; # Added 2024-07-15
  mcomix3 = throw "'mcomix3' has been renamed to/replaced by 'mcomix'"; # Converted to throw 2024-10-21
  mdt = md-tui; # Added 2024-09-03
  meme = throw "'meme' has been renamed to/replaced by 'meme-image-generator'"; # Converted to throw 2024-10-17
  mhwaveedit = throw "'mkwaveedit' has been removed due to lack of maintenance upstream. Consider using 'audacity' or 'tenacity' instead";
  microcodeAmd = microcode-amd; # Added 2024-09-08
  microcodeIntel = microcode-intel; # Added 2024-09-08
  microsoft_gsl = throw "'microsoft_gsl' has been renamed to/replaced by 'microsoft-gsl'"; # Converted to throw 2024-10-21
  MIDIVisualizer = midivisualizer; # Added 2024-06-12
  mikutter = throw "'mikutter' has been removed because the package was broken and had no maintainers"; # Added 2024-10-01
  mime-types = throw "'mime-types' has been renamed to/replaced by 'mailcap'"; # Converted to throw 2024-10-21
  minetest-touch = minetestclient; # Added 2024-08-12
  minetestclient_5 = throw "'minetestclient_5' has been renamed to/replaced by 'minetestclient'"; # Converted to throw 2024-10-21
  minetestserver_5 = throw "'minetestserver_5' has been renamed to/replaced by 'minetestserver'"; # Converted to throw 2024-10-21
  minizip2 = throw "'minizip2' has been renamed to/replaced by 'minizip-ng'"; # Converted to throw 2024-10-21
  mod_dnssd = throw "'mod_dnssd' has been renamed to/replaced by 'apacheHttpdPackages.mod_dnssd'"; # Converted to throw 2024-10-17
  mod_fastcgi = throw "'mod_fastcgi' has been renamed to/replaced by 'apacheHttpdPackages.mod_fastcgi'"; # Converted to throw 2024-10-17
  mod_python = throw "'mod_python' has been renamed to/replaced by 'apacheHttpdPackages.mod_python'"; # Converted to throw 2024-10-17
  mod_wsgi = throw "'mod_wsgi' has been renamed to/replaced by 'apacheHttpdPackages.mod_wsgi'"; # Converted to throw 2024-10-17
  mod_ca = throw "'mod_ca' has been renamed to/replaced by 'apacheHttpdPackages.mod_ca'"; # Converted to throw 2024-10-17
  mod_crl = throw "'mod_crl' has been renamed to/replaced by 'apacheHttpdPackages.mod_crl'"; # Converted to throw 2024-10-17
  mod_csr = throw "'mod_csr' has been renamed to/replaced by 'apacheHttpdPackages.mod_csr'"; # Converted to throw 2024-10-17
  mod_ocsp = throw "'mod_ocsp' has been renamed to/replaced by 'apacheHttpdPackages.mod_ocsp'"; # Converted to throw 2024-10-17
  mod_scep = throw "'mod_scep' has been renamed to/replaced by 'apacheHttpdPackages.mod_scep'"; # Converted to throw 2024-10-17
  mod_spkac = throw "'mod_spkac' has been renamed to/replaced by 'apacheHttpdPackages.mod_spkac'"; # Converted to throw 2024-10-17
  mod_pkcs12 = throw "'mod_pkcs12' has been renamed to/replaced by 'apacheHttpdPackages.mod_pkcs12'"; # Converted to throw 2024-10-17
  mod_timestamp = throw "'mod_timestamp' has been renamed to/replaced by 'apacheHttpdPackages.mod_timestamp'"; # Converted to throw 2024-10-17
  monero = throw "'monero' has been renamed to/replaced by 'monero-cli'"; # Converted to throw 2024-10-17
  mongodb-4_4 = throw "mongodb-4_4 has been removed, it's end of life since April 2024"; # Added 2024-04-11
  mongodb-5_0 = throw "mongodb-5_0 has been removed, it's end of life since October 2024"; # Added 2024-10-01
  moz-phab = throw "'moz-phab' has been renamed to/replaced by 'mozphab'"; # Converted to throw 2024-10-21
  mp3info = throw "'mp3info' has been removed due to lack of maintenance upstream. Consider using 'eartag' or 'tagger' instead"; # Added 2024-09-14
  mpc_cli = throw "'mpc_cli' has been renamed to/replaced by 'mpc-cli'"; # Converted to throw 2024-10-21
  mpd_clientlib = throw "'mpd_clientlib' has been renamed to/replaced by 'libmpdclient'"; # Converted to throw 2024-10-17
  mpdevil = plattenalbum; # Added 2024-05-22
  mpg321 = throw "'mpg321' has been removed due to it being unmaintained by upstream. Consider using mpg123 instead."; # Added 2024-05-10
  msp430NewlibCross = msp430Newlib; # Added 2024-09-06
  mupdf_1_17 = throw "'mupdf_1_17' has been removed due to being outdated and insecure. Consider using 'mupdf' instead."; # Added 2024-08-22
  mutt-with-sidebar = throw "'mutt-with-sidebar' has been renamed to/replaced by 'mutt'"; # Converted to throw 2024-10-21
  mysql-client = hiPrio mariadb.client;
  mysql = throw "'mysql' has been renamed to/replaced by 'mariadb'"; # Converted to throw 2024-10-17
  mesa_drivers = throw "'mesa_drivers' has been removed, use 'pkgs.mesa' or 'pkgs.mesa.drivers' depending on target use case."; # Converted to throw 2024-07-11

  ### N ###

  ncdu_2 = throw "'ncdu_2' has been renamed to/replaced by 'ncdu'"; # Converted to throw 2024-10-21
  neocities-cli = neocities; # Added 2024-07-31
  nextcloud27 = throw ''
    Nextcloud v27 has been removed from `nixpkgs` as the support for is dropped
    by upstream in 2024-06. Please upgrade to at least Nextcloud v28 by declaring

        services.nextcloud.package = pkgs.nextcloud28;

    in your NixOS config.

    WARNING: if you were on Nextcloud 26 you have to upgrade to Nextcloud 27
    first on 24.05 because Nextcloud doesn't support upgrades across multiple major versions!
  ''; # Added 2024-06-25
  nextcloud27Packages = throw "Nextcloud27 is EOL!"; # Added 2024-06-25
  nagiosPluginsOfficial = monitoring-plugins;
  neochat = throw "'neochat' has been renamed to/replaced by 'libsForQt5.kdeGear.neochat'"; # Converted to throw 2024-10-21
  newlibCross = newlib; # Added 2024-09-06
  newlib-nanoCross = newlib-nano; # Added 2024-09-06
  nitrokey-udev-rules = throw "'nitrokey-udev-rules' has been renamed to/replaced by 'libnitrokey'"; # Converted to throw 2024-10-21
  nix-direnv-flakes = nix-direnv;
  nix-ld-rs = nix-ld; # Added 2024-08-17
  nix-repl = throw (
    # Added 2018-08-26
    "nix-repl has been removed because it's not maintained anymore, " +
    "use `nix repl` instead. Also see https://github.com/NixOS/nixpkgs/pull/44903"
  );
  nix-simple-deploy = throw "'nix-simple-deploy' has been removed as it is broken and unmaintained"; # Added 2024-08-17
  nix-universal-prefetch = throw "The nix-universal-prefetch package was dropped since it was unmaintained."; # Added 2024-06-21
  nixFlakes = throw "'nixFlakes' has been renamed to/replaced by 'nixVersions.stable'"; # Converted to throw 2024-10-17
  nixStable = throw "'nixStable' has been renamed to/replaced by 'nixVersions.stable'"; # Converted to throw 2024-10-21
  nixUnstable = throw "nixUnstable has been removed. For bleeding edge (Nix master, roughly weekly updated) use nixVersions.git, otherwise use nixVersions.latest."; # Converted to throw 2024-04-22
  nix_2_3 = nixVersions.nix_2_3;
  nixfmt = throw "'nixfmt' has been renamed to/replaced by 'lib.warn'"; # Converted to throw 2024-10-21

  # When the nixops_unstable alias is removed, nixops_unstable_minimal can be renamed to nixops_unstable.

  nixosTest = throw "'nixosTest' has been renamed to/replaced by 'testers.nixosTest'"; # Converted to throw 2024-10-21
  nmap-unfree = throw "'nmap-unfree' has been renamed to/replaced by 'nmap'"; # Converted to throw 2024-10-17
  nodejs-18_x = throw "'nodejs-18_x' has been renamed to/replaced by 'nodejs_18'"; # Converted to throw 2024-10-21
  nodejs-slim-18_x = throw "'nodejs-slim-18_x' has been renamed to/replaced by 'nodejs-slim_18'"; # Converted to throw 2024-10-21
  noto-fonts-cjk = throw "'noto-fonts-cjk' has been renamed to/replaced by 'noto-fonts-cjk-sans'"; # Converted to throw 2024-10-17
  noto-fonts-emoji = throw "'noto-fonts-emoji' has been renamed to/replaced by 'noto-fonts-color-emoji'"; # Converted to throw 2024-10-21
  noto-fonts-extra = throw "'noto-fonts-extra' has been renamed to/replaced by 'noto-fonts'"; # Converted to throw 2024-10-21
  NSPlist = throw "'NSPlist' has been renamed to/replaced by 'nsplist'"; # Converted to throw 2024-10-21
  nushellFull = lib.warn "`nushellFull` has has been replaced by `nushell` as it's features no longer exist" nushell; # Added 2024-05-30
  nvidia-podman = throw "podman should use the Container Device Interface (CDI) instead. See https://web.archive.org/web/20240729183805/https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html#configuring-podman"; # Added 2024-08-02
  nvidia-thrust = throw "nvidia-thrust has been removed because the project was deprecated; use cudaPackages.cuda_cccl";
  nvtop = throw "'nvtop' has been renamed to/replaced by 'lib.warn'"; # Converted to throw 2024-10-21
  nvtop-amd = throw "'nvtop-amd' has been renamed to/replaced by 'lib.warn'"; # Converted to throw 2024-10-21
  nvtop-nvidia = throw "'nvtop-nvidia' has been renamed to/replaced by 'lib.warn'"; # Converted to throw 2024-10-21
  nvtop-intel = throw "'nvtop-intel' has been renamed to/replaced by 'lib.warn'"; # Converted to throw 2024-10-21
  nvtop-msm = throw "'nvtop-msm' has been renamed to/replaced by 'lib.warn'"; # Converted to throw 2024-10-21

  ### O ###

  o = throw "'o' has been renamed to/replaced by 'orbiton'"; # Converted to throw 2024-10-21
  oathToolkit = throw "'oathToolkit' has been renamed to/replaced by 'oath-toolkit'"; # Converted to throw 2024-10-21
  oauth2_proxy = throw "'oauth2_proxy' has been renamed to/replaced by 'oauth2-proxy'"; # Converted to throw 2024-10-17
  onevpl-intel-gpu = lib.warn "onevpl-intel-gpu has been renamed to vpl-gpu-rt" vpl-gpu-rt; # Added 2024-06-04
  opencv2 = throw "opencv2 has been removed as it is obsolete and was not used by any other package; please migrate to OpenCV 4"; # Added 2024-08-20
  opencv3 = throw "opencv3 has been removed as it is obsolete and was not used by any other package; please migrate to OpenCV 4"; # Added 2024-08-20
  openafs_1_8 = throw "'openafs_1_8' has been renamed to/replaced by 'openafs'"; # Converted to throw 2024-10-21
  opencl-info = throw "opencl-info has been removed, as the upstream is unmaintained; consider using 'clinfo' instead"; # Added 2024-06-12
  opencomposite-helper = throw "opencomposite-helper has been removed from nixpkgs as it causes issues with some applications. See https://wiki.nixos.org/wiki/VR#OpenComposite for the recommended setup"; # Added 2024-09-07
  openconnect_gnutls = throw "'openconnect_gnutls' has been renamed to/replaced by 'openconnect'"; # Converted to throw 2024-10-21
  opendylan = throw "opendylan has been removed from nixpkgs as it was broken"; # Added 2024-07-15
  opendylan_bin = throw "opendylan_bin has been removed from nixpkgs as it was broken"; # Added 2024-07-15
  openelec-dvb-firmware = throw "'openelec-dvb-firmware' has been renamed to/replaced by 'libreelec-dvb-firmware'"; # Converted to throw 2024-10-17
  openethereum = throw "openethereum development has ceased by upstream. Use alternate clients such as go-ethereum, erigon, or nethermind"; # Added 2024-05-13
  openimageio2 = throw "'openimageio2' has been renamed to/replaced by 'openimageio'"; # Converted to throw 2024-10-21
  openisns = throw "'openisns' has been renamed to/replaced by 'open-isns'"; # Converted to throw 2024-10-17
  openjdk19 = throw "OpenJDK 19 was removed as it has reached its end of life"; # Added 2024-08-01
  openjdk19_headless = openjdk19; # Added 2024-08-01
  jdk19 = openjdk19; # Added 2024-08-01
  jdk19_headless = openjdk19; # Added 2024-08-01
  openjdk20 = throw "OpenJDK 20 was removed as it has reached its end of life"; # Added 2024-08-01
  openjdk20_headless = openjdk20; # Added 2024-08-01
  jdk20 = openjdk20; # Added 2024-08-01
  jdk20_headless = openjdk20; # Added 2024-08-01
  openjfx11 = throw "OpenJFX 11 was removed as it has reached its end of life"; # Added 2024-10-07
  openjfx19 = throw "OpenJFX 19 was removed as it has reached its end of life"; # Added 2024-08-01
  openjfx20 = throw "OpenJFX 20 was removed as it has reached its end of life"; # Added 2024-08-01
  openjpeg_2 = throw "'openjpeg_2' has been renamed to/replaced by 'openjpeg'"; # Converted to throw 2024-10-17
  openlens = throw "Lens Closed its source code, package obsolete/stale - consider lens as replacement"; # Added 2024-09-04
  openlp = throw "openlp has been removed for now because the outdated version depended on insecure and removed packages and it needs help to upgrade and maintain it; see https://github.com/NixOS/nixpkgs/pull/314882"; # Added 2024-07-29
  openmpt123 = throw "'openmpt123' has been renamed to/replaced by 'libopenmpt'"; # Converted to throw 2024-10-17
  openssl_3_0 = throw "'openssl_3_0' has been renamed to/replaced by 'openssl_3'"; # Converted to throw 2024-10-21
  orchis = throw "'orchis' has been renamed to/replaced by 'orchis-theme'"; # Converted to throw 2024-10-17
  onlyoffice-bin = onlyoffice-desktopeditors; # Added 2024-09-20
  onlyoffice-bin_latest = onlyoffice-bin; # Added 2024-07-03
  onlyoffice-bin_7_2 = throw "onlyoffice-bin_7_2 has been removed. Please use the latest version available under onlyoffice-bin"; # Added 2024-07-03
  onlyoffice-bin_7_5 = throw "onlyoffice-bin_7_5 has been removed. Please use the latest version available under onlyoffice-bin"; # Added 2024-07-03
  openvswitch-lts = throw "openvswitch-lts has been removed. Please use the latest version available under openvswitch"; # Added 2024-08-24
  OSCAR = oscar; # Added 2024-06-12
  osxfuse = throw "'osxfuse' has been renamed to/replaced by 'macfuse-stubs'"; # Converted to throw 2024-10-17
  ovn-lts = throw "ovn-lts has been removed. Please use the latest version available under ovn"; # Added 2024-08-24
  oysttyer = throw "oysttyer has been removed; it is no longer maintained because of Twitter disabling free API access"; # Added 2024-09-23

  ### P ###

  PageEdit = throw "'PageEdit' has been renamed to/replaced by 'pageedit'"; # Converted to throw 2024-10-21
  p2pvc = throw "p2pvc has been removed as it is unmaintained upstream and depends on OpenCV 2"; # Added 2024-08-20
  packet-cli = throw "'packet-cli' has been renamed to/replaced by 'metal-cli'"; # Converted to throw 2024-10-17
  paperoni = throw "paperoni has been removed, because it is unmaintained"; # Added 2024-07-14
  paperless = throw "'paperless' has been renamed to/replaced by 'paperless-ngx'"; # Converted to throw 2024-10-17
  paperless-ng = throw "'paperless-ng' has been renamed to/replaced by 'paperless-ngx'"; # Converted to throw 2024-10-21
  partition-manager = throw "'partition-manager' has been renamed to/replaced by 'libsForQt5.partitionmanager'"; # Converted to throw 2024-10-21
  patchelfStable = throw "'patchelfStable' has been renamed to/replaced by 'patchelf'"; # Converted to throw 2024-10-21
  pcsctools = throw "'pcsctools' has been renamed to/replaced by 'pcsc-tools'"; # Converted to throw 2024-10-21
  pcsxr = throw "pcsxr was removed as it has been abandoned for over a decade; please use DuckStation, Mednafen, or the RetroArch PCSX ReARMed core"; # Added 2024-08-20
  peach = throw "'peach' has been renamed to/replaced by 'asouldocs'"; # Converted to throw 2024-10-21
  percona-server_innovation = lib.warn "Percona upstream has decided to skip all Innovation releases of MySQL and only release LTS versions." percona-server; # Added 2024-10-13
  percona-server_lts = percona-server; # Added 2024-10-13
  percona-xtrabackup_innovation = lib.warn "Percona upstream has decided to skip all Innovation releases of MySQL and only release LTS versions." percona-xtrabackup; # Added 2024-10-13
  percona-xtrabackup_lts = percona-xtrabackup; # Added 2024-10-13
  pentablet-driver = throw "'pentablet-driver' has been renamed to/replaced by 'xp-pen-g430-driver'"; # Converted to throw 2024-10-21
  perldevel = throw "'perldevel' has been dropped due to lack of updates in nixpkgs and lack of consistent support for devel versions by 'perl-cross' releases, use 'perl' instead";
  perldevelPackages = perldevel;
  petrinizer = throw "'petrinizer' has been removed, as it was broken and unmaintained"; # added 2024-05-09
  pgadmin = pgadmin4;
  pharo-spur64 = throw "'pharo-spur64' has been renamed to/replaced by 'pharo'"; # Converted to throw 2024-10-21
  picom-next = throw "'picom-next' has been renamed to/replaced by 'picom'"; # Converted to throw 2024-10-21
  pict-rs_0_3 = throw "pict-rs_0_3 has been removed, as it was an outdated version and no longer compiled"; # Added 2024-08-20

  pipewire_0_2 = throw "pipewire_0_2 has been removed as it is outdated and no longer used"; # Added 2024-07-28
  pipewire-media-session = throw "pipewire-media-session is no longer maintained and has been removed. Please use Wireplumber instead.";
  playwright = lib.warn "'playwright' will reference playwright-driver in 25.05. Reference 'python3Packages.playwright' for the python test launcher" python3Packages.toPythonApplication python3Packages.playwright; # Added 2024-10-04
  pleroma-otp = throw "'pleroma-otp' has been renamed to/replaced by 'pleroma'"; # Converted to throw 2024-10-17
  pltScheme = racket; # just to be sure
  poretools = throw "poretools has been removed from nixpkgs, as it was broken and unmaintained"; # Added 2024-06-03
  powerdns = throw "'powerdns' has been renamed to/replaced by 'pdns'"; # Converted to throw 2024-10-21

  # postgresql plugins
  cstore_fdw = postgresqlPackages.cstore_fdw;
  pg_cron = postgresqlPackages.pg_cron;
  pg_hll = postgresqlPackages.pg_hll;
  pg_repack = postgresqlPackages.pg_repack;
  pg_similarity = postgresqlPackages.pg_similarity;
  pg_topn = postgresqlPackages.pg_topn;
  pgjwt = postgresqlPackages.pgjwt;
  pgroonga = postgresqlPackages.pgroonga;
  pgtap = postgresqlPackages.pgtap;
  plv8 = postgresqlPackages.plv8;
  postgis = postgresqlPackages.postgis;
  tex-match = throw "'tex-match' has been removed due to lack of maintenance upstream. Consider using 'hieroglyphic' instead"; # Added 2024-09-24
  texinfo5 = throw "'texinfo5' has been removed from nixpkgs"; # Added 2024-09-10
  timescaledb = postgresqlPackages.timescaledb;
  tsearch_extras = postgresqlPackages.tsearch_extras;

  # pinentry was using multiple outputs, this emulates the old interface for i.e. home-manager
  # soon: throw "'pinentry' has been removed. Pick an appropriate variant like 'pinentry-curses' or 'pinentry-gnome3'";
  pinentry = pinentry-all // {
    curses = pinentry-curses;
    emacs = pinentry-emacs;
    gnome3 = pinentry-gnome3;
    gtk2 = pinentry-gtk2;
    qt = pinentry-qt;
    tty = pinentry-tty;
    flavors = [ "curses" "emacs" "gnome3" "gtk2" "qt" "tty" ];
  }; # added 2024-01-15
  pinentry_qt5 = throw "'pinentry_qt5' has been renamed to/replaced by 'pinentry-qt'"; # Converted to throw 2024-10-17
  pivx = throw "pivx has been removed as it was marked as broken"; # Added 2024-07-15
  pivxd = throw "pivxd has been removed as it was marked as broken"; # Added 2024-07-15

  PlistCpp = throw "'PlistCpp' has been renamed to/replaced by 'plistcpp'"; # Converted to throw 2024-10-21
  pocket-updater-utility = throw "'pocket-updater-utility' has been renamed to/replaced by 'pupdate'"; # Converted to throw 2024-10-21
  prismlauncher-qt5 = throw "'prismlauncher-qt5' has been removed from nixpkgs. Please use 'prismlauncher'"; # Added 2024-04-20
  prismlauncher-qt5-unwrapped = throw "'prismlauncher-qt5-unwrapped' has been removed from nixpkgs. Please use 'prismlauncher-unwrapped'"; # Added 2024-04-20
  probe-rs = probe-rs-tools; # Added 2024-05-23
  probe-run = throw "probe-run is deprecated upstream.  Use probe-rs instead."; # Added 2024-05-23
  prometheus-dmarc-exporter = throw "'prometheus-dmarc-exporter' has been renamed to/replaced by 'dmarc-metrics-exporter'"; # Converted to throw 2024-10-21
  prometheus-dovecot-exporter = dovecot_exporter; # Added 2024-06-10
  prometheus-openldap-exporter = throw "'prometheus-openldap-exporter' has been removed from nixpkgs, as it was unmaintained"; # Added 2024-09-01
  prometheus-minio-exporter = throw "'prometheus-minio-exporter' has been removed from nixpkgs, use Minio's built-in Prometheus integration instead"; # Added 2024-06-10
  protobuf3_24 = protobuf_24;
  protobuf3_23 = protobuf_23;
  protobuf3_21 = protobuf_21;
  protonup = throw "'protonup' has been renamed to/replaced by 'protonup-ng'"; # Converted to throw 2024-10-21
  protonvpn-gui_legacy = throw "protonvpn-gui_legacy source code was removed from upstream. Use protonvpn-gui instead."; # Added 2024-10-12
  proxmark3-rrg = throw "'proxmark3-rrg' has been renamed to/replaced by 'proxmark3'"; # Converted to throw 2024-10-21
  psensor = throw "'psensor' has been removed due to lack of maintenance upstream. Consider using 'mission-center', 'resources' or 'monitorets' instead"; # Added 2024-09-14
  pyo3-pack = maturin;
  pypi2nix = throw "pypi2nix has been removed due to being unmaintained";
  pypolicyd-spf = throw "'pypolicyd-spf' has been renamed to/replaced by 'spf-engine'"; # Converted to throw 2024-10-21
  python = throw "'python' has been renamed to/replaced by 'python2'"; # Converted to throw 2024-10-21
  python-swiftclient = throw "'python-swiftclient' has been renamed to/replaced by 'swiftclient'"; # Converted to throw 2024-10-17
  pythonFull = throw "'pythonFull' has been renamed to/replaced by 'python2Full'"; # Converted to throw 2024-10-21
  pythonPackages = throw "'pythonPackages' has been renamed to/replaced by 'python.pkgs'"; # Converted to throw 2024-10-21

  ### Q ###

  qbittorrent-qt5 = throw "'qbittorrent-qt5' has been removed as qBittorrent 5 dropped support for Qt 5. Please use 'qbittorrent'"; # Added 2024-09-30
  qcsxcad = throw "'qcsxcad' has been renamed to/replaced by 'libsForQt5.qcsxcad'"; # Converted to throw 2024-10-17
  qflipper = throw "'qflipper' has been renamed to/replaced by 'qFlipper'"; # Converted to throw 2024-10-21
  qscintilla = throw "'qscintilla' has been renamed to/replaced by 'libsForQt5.qscintilla'"; # Converted to throw 2024-10-21
  qscintilla-qt6 = throw "'qscintilla-qt6' has been renamed to/replaced by 'qt6Packages.qscintilla'"; # Converted to throw 2024-10-21
  qt515 = throw "'qt515' has been renamed to/replaced by 'qt5'"; # Converted to throw 2024-10-21
  qt5ct = throw "'qt5ct' has been renamed to/replaced by 'libsForQt5.qt5ct'"; # Converted to throw 2024-10-17
  qt6ct = throw "'qt6ct' has been renamed to/replaced by 'qt6Packages.qt6ct'"; # Converted to throw 2024-10-21
  qtcurve = throw "'qtcurve' has been renamed to/replaced by 'libsForQt5.qtcurve'"; # Converted to throw 2024-10-17
  qtile-unwrapped = throw "'qtile-unwrapped' has been renamed to/replaced by 'python3.pkgs.qtile'"; # Converted to throw 2024-10-21
  quantum-espresso-mpi = throw "'quantum-espresso-mpi' has been renamed to/replaced by 'quantum-espresso'"; # Converted to throw 2024-10-21
  quicklispPackages = throw "Lisp packages have been redesigned. See 'lisp-modules' in the nixpkgs manual."; # Added 2024-05-07
  quicklispPackagesABCL = throw "Lisp packages have been redesigned. See 'lisp-modules' in the nixpkgs manual."; # Added 2024-05-07
  quicklispPackagesCCL = throw "Lisp packages have been redesigned. See 'lisp-modules' in the nixpkgs manual."; # Added 2024-05-07
  quicklispPackagesClisp = throw "Lisp packages have been redesigned. See 'lisp-modules' in the nixpkgs manual."; # Added 2024-05-07
  quicklispPackagesECL = throw "Lisp packages have been redesigned. See 'lisp-modules' in the nixpkgs manual."; # Added 2024-05-07
  quicklispPackagesFor = throw "Lisp packages have been redesigned. See 'lisp-modules' in the nixpkgs manual."; # Added 2024-05-07
  quicklispPackagesGCL = throw "Lisp packages have been redesigned. See 'lisp-modules' in the nixpkgs manual."; # Added 2024-05-07
  quicklispPackagesSBCL = throw "Lisp packages have been redesigned. See 'lisp-modules' in the nixpkgs manual."; # Added 2024-05-07

  ### R ###

  rabbitvcs = throw "rabbitvcs has been removed from nixpkgs, because it was broken"; # Added 2024-07-15
  radare2-cutter = throw "'radare2-cutter' has been renamed to/replaced by 'cutter'"; # Converted to throw 2024-10-17
  radicle-cli = throw "'radicle-cli' was removed in favor of 'radicle-node'"; # Added 2024-05-04
  radicle-upstream = throw "'radicle-upstream' was sunset, see <https://community.radworks.org/t/2962>"; # Added 2024-05-04
  railway-travel = throw "'railway-travel' has been renamed to/replaced by 'diebahn'"; # Converted to throw 2024-10-21
  rambox-pro = throw "'rambox-pro' has been renamed to/replaced by 'rambox'"; # Converted to throw 2024-10-21
  rapidjson-unstable = lib.warn "'rapidjson-unstable' has been renamed to 'rapidjson'" rapidjson; # Added 2024-07-28
  redocly-cli = redocly; # Added 2024-04-14
  redpanda = throw "'redpanda' has been renamed to/replaced by 'redpanda-client'"; # Converted to throw 2024-10-21
  redpanda-server = throw "'redpanda-server' has been removed because it was broken for a long time"; # Added 2024-06-10
  relibc = throw "relibc has been removed due to lack of maintenance"; # Added 2024-09-02
  replay-sorcery = throw "replay-sorcery has been removed as it is unmaintained upstream. Consider using gpu-screen-recorder or obs-studio instead."; # Added 2024-07-13
  restinio_0_6 = throw "restinio_0_6 has been removed from nixpkgs as it's not needed by downstream packages"; # Added 2024-07-04
  retroshare06 = retroshare;
  rigsofrods = throw "'rigsofrods' has been renamed to/replaced by 'rigsofrods-bin'"; # Converted to throw 2024-10-21
  ring-daemon = throw "'ring-daemon' has been renamed to/replaced by 'jami-daemon'"; # Converted to throw 2024-10-17
  rockbox_utility = throw "'rockbox_utility' has been renamed to/replaced by 'rockbox-utility'"; # Converted to throw 2024-10-21
  rpiboot-unstable = throw "'rpiboot-unstable' has been renamed to/replaced by 'rpiboot'"; # Converted to throw 2024-10-17
  rr-unstable = throw "'rr-unstable' has been renamed to/replaced by 'rr'"; # Converted to throw 2024-10-21
  rtx = throw "'rtx' has been renamed to/replaced by 'mise'"; # Converted to throw 2024-10-21
  runCommandNoCC = runCommand;
  runCommandNoCCLocal = runCommandLocal;
  rustc-wasm32 = throw "'rustc-wasm32' has been renamed to/replaced by 'rustc'"; # Converted to throw 2024-10-21
  rustic-rs = rustic; # Added 2024-08-02
  rxvt_unicode = throw "'rxvt_unicode' has been renamed to/replaced by 'rxvt-unicode-unwrapped'"; # Converted to throw 2024-10-17
  rxvt_unicode-with-plugins = throw "'rxvt_unicode-with-plugins' has been renamed to/replaced by 'rxvt-unicode'"; # Converted to throw 2024-10-17

  # The alias for linuxPackages*.rtlwifi_new is defined in ./all-packages.nix,
  # due to it being inside the linuxPackagesFor function.
  rtlwifi_new-firmware = throw "'rtlwifi_new-firmware' has been renamed to/replaced by 'rtw88-firmware'"; # Converted to throw 2024-10-17
  rtw88-firmware = throw "rtw88-firmware has been removed because linux-firmware now contains it."; # Added 2024-06-28

  ### S ###

  SDL_classic = SDL1; # Added 2024-09-03
  s2n = throw "'s2n' has been renamed to/replaced by 's2n-tls'"; # Converted to throw 2024-10-17
  sandboxfs = throw "'sandboxfs' has been removed due to being unmaintained, consider using linux namespaces for sandboxing instead"; # Added 2024-06-06
  sane-backends-git = throw "'sane-backends-git' has been renamed to/replaced by 'sane-backends'"; # Converted to throw 2024-10-17
  scantailor = throw "'scantailor' has been renamed to/replaced by 'scantailor-advanced'"; # Converted to throw 2024-10-21
  schildichat-web = throw ''
    schildichat has been removed as it is severely lacking behind the Element upstream and does not receive regular security fixes.
    Please participate in upstream discussion on getting out new releases:
    https://github.com/SchildiChat/schildichat-desktop/issues/212
    https://github.com/SchildiChat/schildichat-desktop/issues/215''; # Added 2023-12-05
  schildichat-desktop = schildichat-web;
  schildichat-desktop-wayland = schildichat-web;
  scitoken-cpp = throw "'scitoken-cpp' has been renamed to/replaced by 'scitokens-cpp'"; # Converted to throw 2024-10-21
  semeru-bin-16 = throw "Semeru 16 has been removed as it has reached its end of life"; # Added 2024-08-01
  semeru-jre-bin-16 = throw "Semeru 16 has been removed as it has reached its end of life"; # Added 2024-08-01
  session-desktop-appimage = session-desktop;
  sequoia = throw "'sequoia' has been renamed to/replaced by 'sequoia-sq'"; # Converted to throw 2024-10-21
  sexp = throw "'sexp' has been renamed to/replaced by 'sexpp'"; # Converted to throw 2024-10-21
  inherit (libsForQt5.mauiPackages) shelf; # added 2022-05-17
  shipyard = throw "'shipyard' has been renamed to/replaced by 'jumppad'"; # Converted to throw 2024-10-21
  shout = nodePackages.shout; # Added unknown; moved 2024-10-19
  sky = throw "'sky' has been removed because its upstream website disappeared"; # Added 2024-07-21
  SkypeExport = skypeexport; # Added 2024-06-12
  slack-dark = throw "'slack-dark' has been renamed to/replaced by 'slack'"; # Converted to throw 2024-10-17
  slurm-llnl = slurm; # renamed July 2017
  snapTools = throw "snapTools was removed because makeSnap produced broken snaps and it was the only function in snapTools. See https://github.com/NixOS/nixpkgs/issues/100618 for more details."; # 2024-03-04;
  soldat-unstable = throw "'soldat-unstable' has been renamed to/replaced by 'opensoldat'"; # Converted to throw 2024-10-21
  soundOfSorting = throw "'soundOfSorting' has been renamed to/replaced by 'sound-of-sorting'"; # Converted to throw 2024-10-21
  SP800-90B_EntropyAssessment = sp800-90b-entropyassessment; # Added on 2024-06-12
  SPAdes = spades; # Added 2024-06-12
  spark2014 = throw "'spark2014' has been renamed to/replaced by 'gnatprove'"; # Converted to throw 2024-10-21

  # Added 2020-02-10
  sourceHanSansPackages = {
    japanese = source-han-sans;
    korean = source-han-sans;
    simplified-chinese = source-han-sans;
    traditional-chinese = source-han-sans;
  };
  source-han-sans-japanese = source-han-sans;
  source-han-sans-korean = source-han-sans;
  source-han-sans-simplified-chinese = source-han-sans;
  source-han-sans-traditional-chinese = source-han-sans;
  sourceHanSerifPackages = {
    japanese = source-han-serif;
    korean = source-han-serif;
    simplified-chinese = source-han-serif;
    traditional-chinese = source-han-serif;
  };
  source-han-serif-japanese = source-han-serif;
  source-han-serif-korean = source-han-serif;
  source-han-serif-simplified-chinese = source-han-serif;
  source-han-serif-traditional-chinese = source-han-serif;


  spectral = throw "'spectral' has been renamed to/replaced by 'neochat'"; # Converted to throw 2024-10-17
  # spidermonkey is not ABI upwards-compatible, so only allow this for nix-shell
  spidermonkey = throw "'spidermonkey' has been renamed to/replaced by 'spidermonkey_78'"; # Converted to throw 2024-10-17
  spidermonkey_102 = throw "'spidermonkey_102' is EOL since 2023/03"; # Added 2024-08-07
  spotify-unwrapped = throw "'spotify-unwrapped' has been renamed to/replaced by 'spotify'"; # Converted to throw 2024-10-21
  spring-boot = throw "'spring-boot' has been renamed to/replaced by 'spring-boot-cli'"; # Converted to throw 2024-10-17
  srvc = throw "'srvc' has been removed, as it was broken and unmaintained"; # Added 2024-09-09
  ssm-agent = throw "'ssm-agent' has been renamed to/replaced by 'amazon-ssm-agent'"; # Converted to throw 2024-10-21
  starspace = throw "starspace has been removed from nixpkgs, as it was broken"; # Added 2024-07-15
  steamPackages = {
    steamArch = throw "`steamPackages.steamArch` has been removed as it's no longer applicable";
    steam = lib.warn "`steamPackages.steam` has been moved to top level as `steam-unwrapped`" steam-unwrapped;
    steam-fhsenv = lib.warn "`steamPackages.steam-fhsenv` has been moved to top level as `steam`" steam;
    steam-fhsenv-without-steam = lib.warn "`steamPackages.steam-fhsenv-without-steam` has been moved to top level as `steam-fhsenv-without-steam`" steam-fhsenv-without-steam;
    steamcmd = lib.warn "`steamPackages.steamcmd` has been moved to top level as `steamcmd`" steamcmd;
  };
  steam-small = steam; # Added 2024-09-12
  steam-run-native = throw "'steam-run-native' has been renamed to/replaced by 'steam-run'"; # Converted to throw 2024-10-21
  StormLib = throw "'StormLib' has been renamed to/replaced by 'stormlib'"; # Converted to throw 2024-10-21
  sumneko-lua-language-server = throw "'sumneko-lua-language-server' has been renamed to/replaced by 'lua-language-server'"; # Converted to throw 2024-10-21
  swiProlog = lib.warn "swiProlog has been renamed to swi-prolog" swi-prolog; # Added 2024-09-07
  swiPrologWithGui = lib.warn "swiPrologWithGui has been renamed to swi-prolog-gui" swi-prolog-gui; # Added 2024-09-07
  swig1 = throw "swig1 has been removed as it is obsolete"; # Added 2024-08-23
  swig2 = throw "swig2 has been removed as it is obsolete"; # Added 2024-08-23
  swig3 = throw "swig3 has been removed as it is obsolete"; # Added 2024-09-12
  swig4 = swig; # Added 2024-09-12
  swigWithJava = throw "swigWithJava has been removed as the main swig package has supported Java since 2009"; # Added 2024-09-12
  swtpm-tpm2 = throw "'swtpm-tpm2' has been renamed to/replaced by 'swtpm'"; # Converted to throw 2024-10-17
  Sylk = sylk; # Added 2024-06-12
  symbiyosys = sby; # Added 2024-08-18
  sync = taler-sync; # Added 2024-09-04
  syncthing-cli = throw "'syncthing-cli' has been renamed to/replaced by 'syncthing'"; # Converted to throw 2024-10-17
  syncthingtray-qt6 = throw "'syncthingtray-qt6' has been renamed to/replaced by 'syncthingtray'"; # Converted to throw 2024-10-21

  ### T ###

  tabula = throw "tabula has been removed from nixpkgs, as it was broken"; # Added 2024-07-15
  tangogps = throw "'tangogps' has been renamed to/replaced by 'foxtrotgps'"; # Converted to throw 2024-10-17
  taskwarrior = lib.warn "taskwarrior was replaced by taskwarrior3, which requires manual transition from taskwarrior 2.6, read upstream's docs: https://taskwarrior.org/docs/upgrade-3/" taskwarrior2;
  taplo-cli = throw "'taplo-cli' has been renamed to/replaced by 'taplo'"; # Converted to throw 2024-10-21
  taplo-lsp = throw "'taplo-lsp' has been renamed to/replaced by 'taplo'"; # Converted to throw 2024-10-21
  taro = throw "'taro' has been renamed to/replaced by 'taproot-assets'"; # Converted to throw 2024-10-21
  tdesktop = throw "'tdesktop' has been renamed to/replaced by 'telegram-desktop'"; # Converted to throw 2024-10-21
  teck-programmer = throw "teck-programmer was removed because it was broken and unmaintained"; # added 2024-08-23
  teleport_13 = throw "teleport 13 has been removed as it is EOL. Please upgrade to Teleport 14 or later"; # Added 2024-05-26
  teleport_14 = throw "teleport 14 has been removed as it is EOL. Please upgrade to Teleport 15 or later"; # Added 2024-10-18
  temurin-bin-20 = throw "Temurin 20 has been removed as it has reached its end of life"; # Added 2024-08-01
  temurin-jre-bin-20 = throw "Temurin 20 has been removed as it has reached its end of life"; # Added 2024-08-01
  temurin-bin-19 = throw "Temurin 19 has been removed as it has reached its end of life"; # Added 2024-08-01
  temurin-jre-bin-19 = throw "Temurin 19 has been removed as it has reached its end of life"; # Added 2024-08-01
  temurin-bin-18 = throw "Temurin 18 has been removed as it has reached its end of life"; # Added 2024-08-01
  temurin-jre-bin-18 = throw "Temurin 18 has been removed as it has reached its end of life"; # Added 2024-08-01
  temurin-bin-16 = throw "Temurin 16 has been removed as it has reached its end of life"; # Added 2024-08-01
  tepl = libgedit-tepl; # Added 2024-04-29
  testVersion = throw "'testVersion' has been renamed to/replaced by 'testers.testVersion'"; # Converted to throw 2024-10-21
  tfplugindocs = throw "'tfplugindocs' has been renamed to/replaced by 'terraform-plugin-docs'"; # Converted to throw 2024-10-21
  invalidateFetcherByDrvHash = throw "'invalidateFetcherByDrvHash' has been renamed to/replaced by 'testers.invalidateFetcherByDrvHash'"; # Converted to throw 2024-10-21
  timescale-prometheus = throw "'timescale-prometheus' has been renamed to/replaced by 'promscale'"; # Converted to throw 2024-10-17
  tightvnc = throw "'tightvnc' has been removed as the version 1.3 is not maintained upstream anymore and is insecure"; # Added 2024-08-22
  tkcvs = throw "'tkcvs' has been renamed to/replaced by 'tkrev'"; # Converted to throw 2024-10-21
  toil = throw "toil was removed as it was broken and requires obsolete versions of libraries"; # Added 2024-09-22
  tokodon = plasma5Packages.tokodon;
  tokyo-night-gtk = throw "'tokyo-night-gtk' has been renamed to/replaced by 'tokyonight-gtk-theme'"; # Converted to throw 2024-10-21
  tomcat_connectors = apacheHttpdPackages.mod_jk; # Added 2024-06-07
  tor-browser-bundle-bin = throw "'tor-browser-bundle-bin' has been renamed to/replaced by 'tor-browser'"; # Converted to throw 2024-10-21
  transmission = lib.warn (transmission3Warning {}) transmission_3; # Added 2024-06-10
  transmission-gtk = lib.warn (transmission3Warning {suffix = "-gtk";}) transmission_3-gtk; # Added 2024-06-10
  transmission-qt = lib.warn (transmission3Warning {suffix = "-qt";}) transmission_3-qt; # Added 2024-06-10
  treefmt = treefmt2; # 2024-06-28
  libtransmission = lib.warn (transmission3Warning {prefix = "lib";}) libtransmission_3; # Added 2024-06-10
  transfig = throw "'transfig' has been renamed to/replaced by 'fig2dev'"; # Converted to throw 2024-10-21
  transifex-client = throw "'transifex-client' has been renamed to/replaced by 'transifex-cli'"; # Converted to throw 2024-10-21
  trfl = throw "trfl has been removed, because it has not received an update for 3 years and was broken"; # Added 2024-07-25
  trezor_agent = throw "'trezor_agent' has been renamed to/replaced by 'trezor-agent'"; # Converted to throw 2024-10-21
  openai-triton-llvm = triton-llvm; # added 2024-07-18
  trust-dns = hickory-dns; # Added 2024-08-07
  tumpa = throw "tumpa has been removed, as it is broken"; # Added 2024-07-15
  turbogit = throw "turbogit has been removed as it is unmaintained upstream and depends on an insecure version of libgit2"; # Added 2024-08-25
  tvbrowser-bin = throw "'tvbrowser-bin' has been renamed to/replaced by 'tvbrowser'"; # Converted to throw 2024-10-21
  tvheadend = throw "tvheadend has been removed as it nobody was willing to maintain it and it was stuck on an unmaintained version that required FFmpeg 4; please see https://github.com/NixOS/nixpkgs/pull/332259 if you are interested in maintaining a newer version"; # Added 2024-08-21
  typst-fmt = throw "'typst-fmt' has been renamed to/replaced by 'typstfmt'"; # Converted to throw 2024-10-21
  typst-preview = throw "The features of 'typst-preview' have been consolidated to 'tinymist', an all-in-one language server for typst"; # Added 2024-07-07

  ### U ###

  uade123 = throw "'uade123' has been renamed to/replaced by 'uade'"; # Converted to throw 2024-10-21
  uberwriter = throw "'uberwriter' has been renamed to/replaced by 'apostrophe'"; # Converted to throw 2024-10-17
  ubootBeagleboneBlack = throw "'ubootBeagleboneBlack' has been renamed to/replaced by 'ubootAmx335xEVM'"; # Converted to throw 2024-10-17
  ubuntu_font_family = throw "'ubuntu_font_family' has been renamed to/replaced by 'ubuntu-classic'"; # Converted to throw 2024-10-21
  uclibc = throw "'uclibc' has been renamed to/replaced by 'uclibc-ng'"; # Converted to throw 2024-10-21
  uclibcCross = throw "'uclibcCross' has been renamed to/replaced by 'uclibc-ng'"; # Converted to throw 2024-10-21
  uefi-firmware-parser = throw "The uefi-firmware-parser package was dropped since it was unmaintained."; # Added 2024-06-21
  unicorn-emu = throw "'unicorn-emu' has been renamed to/replaced by 'unicorn'"; # Converted to throw 2024-10-17
  uniffi-bindgen = throw "uniffi-bindgen has been removed since upstream no longer provides a standalone package for the CLI";
  unifi-poller = throw "'unifi-poller' has been renamed to/replaced by 'unpoller'"; # Converted to throw 2024-10-21
  unifi-video = throw "unifi-video has been removed as it has been unsupported upstream since 2021"; # Added 2024-10-01
  unifi5 = throw "'unifi5' has been removed since its required MongoDB version is EOL."; # Added 2024-04-11
  unifi6 = throw "'unifi6' has been removed since its required MongoDB version is EOL."; # Added 2024-04-11
  unifi7 = throw "'unifi7' has been removed since it is vulnerable to CVE-2024-42025 and its required MongoDB version is EOL."; # Added 2024-10-01
  unifiLTS = throw "'unifiLTS' has been removed since UniFi no longer has LTS and stable releases. Use `pkgs.unifi` instead."; # Added 2024-04-11
  unifiStable = throw "'unifiStable' has been removed since UniFi no longer has LTS and stable releases. Use `pkgs.unifi` instead."; # Converted to throw 2024-04-11
  untrunc = throw "'untrunc' has been renamed to/replaced by 'untrunc-anthwlock'"; # Converted to throw 2024-10-17
  urxvt_autocomplete_all_the_things = throw "'urxvt_autocomplete_all_the_things' has been renamed to/replaced by 'rxvt-unicode-plugins.autocomplete-all-the-things'"; # Converted to throw 2024-10-17
  urxvt_bidi = throw "'urxvt_bidi' has been renamed to/replaced by 'rxvt-unicode-plugins.bidi'"; # Converted to throw 2024-10-17
  urxvt_font_size = throw "'urxvt_font_size' has been renamed to/replaced by 'rxvt-unicode-plugins.font-size'"; # Converted to throw 2024-10-17
  urxvt_perl = throw "'urxvt_perl' has been renamed to/replaced by 'rxvt-unicode-plugins.perl'"; # Converted to throw 2024-10-17
  urxvt_perls = throw "'urxvt_perls' has been renamed to/replaced by 'rxvt-unicode-plugins.perls'"; # Converted to throw 2024-10-17
  urxvt_tabbedex = throw "'urxvt_tabbedex' has been renamed to/replaced by 'rxvt-unicode-plugins.tabbedex'"; # Converted to throw 2024-10-17
  urxvt_theme_switch = throw "'urxvt_theme_switch' has been renamed to/replaced by 'rxvt-unicode-plugins.theme-switch'"; # Converted to throw 2024-10-17
  urxvt_vtwheel = throw "'urxvt_vtwheel' has been renamed to/replaced by 'rxvt-unicode-plugins.vtwheel'"; # Converted to throw 2024-10-17
  util-linuxCurses = throw "'util-linuxCurses' has been renamed to/replaced by 'util-linux'"; # Converted to throw 2024-10-21
  utillinux = util-linux; # Added 2020-11-24, keep until node2nix is phased out, see https://github.com/NixOS/nixpkgs/issues/229475

  ### V ###

  validphys2 = throw "validphys2 has been removed, since it has a broken dependency that was removed"; # Added 2024-08-21
  vamp = { vampSDK = vamp-plugin-sdk; }; # Added 2020-03-26
  vaapiIntel = throw "'vaapiIntel' has been renamed to/replaced by 'intel-vaapi-driver'"; # Converted to throw 2024-10-21
  vaapiVdpau = libva-vdpau-driver; # Added 2024-06-05
  vaultwarden-vault = throw "'vaultwarden-vault' has been renamed to/replaced by 'vaultwarden.webvault'"; # Converted to throw 2024-10-21
  vdirsyncerStable = vdirsyncer; # Added 2020-11-08, see https://github.com/NixOS/nixpkgs/issues/103026#issuecomment-723428168
  ventoy-bin = throw "'ventoy-bin' has been renamed to/replaced by 'ventoy'"; # Converted to throw 2024-10-21
  ventoy-bin-full = throw "'ventoy-bin-full' has been renamed to/replaced by 'ventoy-full'"; # Converted to throw 2024-10-21
  verilog = iverilog; # Added 2024-07-12
  ViennaRNA = throw "'ViennaRNA' has been renamed to/replaced by 'viennarna'"; # Converted to throw 2024-10-21
  vimHugeX = throw "'vimHugeX' has been renamed to/replaced by 'vim-full'"; # Converted to throw 2024-10-21
  vim_configurable = throw "'vim_configurable' has been renamed to/replaced by 'vim-full'"; # Converted to throw 2024-10-21
  vinagre = throw "'vinagre' has been removed as it has been archived upstream. Consider using 'gnome-connections' or 'remmina' instead"; # Added 2024-09-14
  vinegar = throw "'vinegar' was removed due to being blocked by Roblox, rendering the package useless"; # Added 2024-08-23
  virtscreen = throw "'virtscreen' has been removed, as it was broken and unmaintained"; # Added 2024-10-17
  vkBasalt = throw "'vkBasalt' has been renamed to/replaced by 'vkbasalt'"; # Converted to throw 2024-10-21
  vkdt-wayland = vkdt; # Added 2024-04-19
  inherit (libsForQt5.mauiPackages) vvave; # added 2022-05-17

  ### W ###
  wakatime = wakatime-cli; # 2024-05-30
  wal_e = throw "wal_e was removed as it is unmaintained upstream and depends on the removed boto package; upstream recommends using wal-g or pgbackrest"; # Added 2024-09-22
  wayfireApplications-unwrapped = throw ''
    'wayfireApplications-unwrapped.wayfire' has been renamed to/replaced by 'wayfire'
    'wayfireApplications-unwrapped.wayfirePlugins' has been renamed to/replaced by 'wayfirePlugins'
    'wayfireApplications-unwrapped.wcm' has been renamed to/replaced by 'wayfirePlugins.wcm'
    'wayfireApplications-unwrapped.wlroots' has been removed
  ''; # Add 2023-07-29
  waypoint = throw "waypoint has been removed from nixpkgs as the upstream project was archived"; # Added 2024-04-24
  webkitgtk = lib.warn "Explicitly set the ABI version of 'webkitgtk'" webkitgtk_4_0;
  wineWayland = wine-wayland;
  win-virtio = throw "'win-virtio' has been renamed to/replaced by 'virtio-win'"; # Converted to throw 2024-10-21
  wkhtmltopdf-bin = wkhtmltopdf; # Added 2024-07-17
  wlroots_0_16 = throw "'wlroots_0_16' has been removed in favor of newer versions"; # Added 2024-07-14
  wlroots = wlroots_0_18; # wlroots is unstable, we must keep depending on 'wlroots_0_*', convert to package after a stable(1.x) release
  wordpress6_3 = throw "'wordpress6_3' has been removed in favor of the latest version"; # Added 2024-08-03
  wordpress6_4 = throw "'wordpress6_4' has been removed in favor of the latest version"; # Added 2024-08-03
  wordpress6_5 = wordpress_6_5; # Added 2024-08-03
  wormhole-rs = magic-wormhole-rs; # Added 2022-05-30. preserve, reason: Arch package name, main binary name
  wpa_supplicant_ro_ssids = lib.trivial.warn "Deprecated package: Please use wpa_supplicant instead. Read-only SSID patches are now upstream!" wpa_supplicant;
  wrapLisp_old = throw "Lisp packages have been redesigned. See 'lisp-modules' in the nixpkgs manual."; # Added 2024-05-07
  wmii_hg = wmii;
  wrapGAppsHook = throw "'wrapGAppsHook' has been renamed to/replaced by 'wrapGAppsHook3'"; # Converted to throw 2024-10-21
  write_stylus = styluslabs-write-bin; # Added 2024-10-09

  ### X ###

  xbmc-retroarch-advanced-launchers = throw "'xbmc-retroarch-advanced-launchers' has been renamed to/replaced by 'kodi-retroarch-advanced-launchers'"; # Converted to throw 2024-10-17
  xdg_utils = throw "'xdg_utils' has been renamed to/replaced by 'xdg-utils'"; # Converted to throw 2024-10-17
  xen-light = throw "'xen-light' has been renamed to/replaced by 'xen-slim'"; # Added 2024-06-30
  xen-slim = throw "'xen-slim' has been renamed to 'xen'. The old Xen package with built-in components no longer exists"; # Added 2024-10-05
  xen_4_16 = throw "While Xen 4.16 was still security-supported when it was removed from Nixpkgs, it would have reached its End of Life a couple of days after NixOS 24.11 released. To avoid shipping an insecure version of Xen, the Xen Project Hypervisor Maintenance Team decided to delete the derivation entirely"; # Added 2024-10-05
  xen_4_17 = throw "Due to technical challenges involving building older versions of Xen with newer dependencies, the Xen Project Hypervisor Maintenance Team decided to switch to a latest-only support cycle. As Xen 4.17 would have been the 'n-2' version, it was removed"; # Added 2024-10-05
  xen_4_18 = throw "Due to technical challenges involving building older versions of Xen with newer dependencies, the Xen Project Hypervisor Maintenance Team decided to switch to a latest-only support cycle. As Xen 4.18 would have been the 'n-1' version, it was removed"; # Added 2024-10-05
  xen_4_19 = throw "Use 'xen' instead"; # Added 2024-10-05
  xenPackages = throw "The attributes in the xenPackages set have been promoted to the top-level. (xenPackages.xen_4_19 -> xen)";
  xineLib = throw "'xineLib' has been renamed to/replaced by 'xine-lib'"; # Converted to throw 2024-10-17
  xineUI = throw "'xineUI' has been renamed to/replaced by 'xine-ui'"; # Converted to throw 2024-10-17
  xmlada = throw "'xmlada' has been renamed to/replaced by 'gnatPackages.xmlada'"; # Converted to throw 2024-10-21
  xmr-stak = throw "xmr-stak has been removed from nixpkgs because it was broken"; # Added 2024-07-15
  xmake-core-sv = throw "'xmake-core-sv' has been removed, use 'libsv' instead"; # Added 2024-10-10
  xonsh-unwrapped = python3Packages.xonsh; # Added 2024-06-18
  xprite-editor = throw "'xprite-editor' has been removed due to lack of maintenance upstream. Consider using 'pablodraw' or 'aseprite' instead"; # Added 2024-09-14
  xulrunner = throw "'xulrunner' has been renamed to/replaced by 'firefox-unwrapped'"; # Converted to throw 2024-10-21
  xvfb_run = throw "'xvfb_run' has been renamed to/replaced by 'xvfb-run'"; # Converted to throw 2024-10-17
  xwaylandvideobridge = libsForQt5.xwaylandvideobridge; # Added 2024-09-27

  ### Y ###

  yacc = throw "'yacc' has been renamed to/replaced by 'bison'"; # Converted to throw 2024-10-17
  yafaray-core = throw "'yafaray-core' has been renamed to/replaced by 'libyafaray'"; # Converted to throw 2024-10-21
  yi = throw "'yi' has been removed, as it was broken and unmaintained"; # added 2024-05-09
  yrd = throw "'yrd' has been removed, as it was broken and unmaintained"; # added 2024-05-27

  ### Z ###

  zfsStable = throw "'zfsStable' has been renamed to/replaced by 'zfs'"; # Converted to throw 2024-10-21
  zfsUnstable = throw "'zfsUnstable' has been renamed to/replaced by 'zfs_unstable'"; # Converted to throw 2024-10-21
  zinc = throw "'zinc' has been renamed to/replaced by 'zincsearch'"; # Converted to throw 2024-10-21
  zk-shell = throw "zk-shell has been removed as it was broken and unmaintained"; # Added 2024-08-10
  zkg = throw "'zkg' has been replaced by 'zeek'";
  zq = zed.overrideAttrs (old: { meta = old.meta // { mainProgram = "zq"; }; }); # Added 2023-02-06
  zz = throw "'zz' has been removed because it was archived in 2022 and had no maintainer"; # added 2024-05-10

  ### UNSORTED ###


  dina-font-pcf = throw "'dina-font-pcf' has been renamed to/replaced by 'dina-font'"; # Converted to throw 2024-10-17
  dnscrypt-proxy2 = throw "'dnscrypt-proxy2' has been renamed to/replaced by 'dnscrypt-proxy'"; # Converted to throw 2024-10-21

  posix_man_pages = throw "'posix_man_pages' has been renamed to/replaced by 'man-pages-posix'"; # Converted to throw 2024-10-17
  ttyrec = throw "'ttyrec' has been renamed to/replaced by 'ovh-ttyrec'"; # Converted to throw 2024-10-17
  zplugin = throw "'zplugin' has been renamed to/replaced by 'zinit'"; # Converted to throw 2024-10-17
  zyn-fusion = throw "'zyn-fusion' has been renamed to/replaced by 'zynaddsubfx'"; # Converted to throw 2024-10-21

  inherit (stdenv.hostPlatform) system; # Added 2021-10-22
  inherit (stdenv) buildPlatform hostPlatform targetPlatform; # Added 2023-01-09

  freebsdCross = freebsd; # Added 2024-09-06
  netbsdCross = netbsd; # Added 2024-09-06
  openbsdCross = openbsd; # Added 2024-09-06

  # LLVM packages for (integration) testing that should not be used inside Nixpkgs:
  llvmPackages_latest = llvmPackages_19;

  /* If these are in the scope of all-packages.nix, they cause collisions
    between mixed versions of qt. See:
  https://github.com/NixOS/nixpkgs/pull/101369 */

  inherit (plasma5Packages)
    akonadi akregator arianna ark bluedevil bomber bovo breeze-grub breeze-gtk
    breeze-icons breeze-plymouth breeze-qt5 colord-kde discover dolphin dragon elisa falkon
    ffmpegthumbs filelight granatier gwenview k3b kactivitymanagerd kaddressbook
    kalzium kapman kapptemplate kate katomic kblackbox kblocks kbounce
    kcachegrind kcalc kcharselect kcolorchooser kde-cli-tools kde-gtk-config
    kdenlive kdeplasma-addons kdevelop-pg-qt kdevelop-unwrapped kdev-php
    kdev-python kdevelop kdf kdialog kdiamond keditbookmarks kfind
    kgamma5 kget kgpg khelpcenter kig kigo killbots kinfocenter kitinerary
    kleopatra klettres klines kmag kmail kmenuedit kmines kmix kmplot
    knavalbattle knetwalk knights kollision kolourpaint kompare konsole kontact
    konversation korganizer kpkpass krdc kreversi krfb kscreen kscreenlocker
    kshisen ksquares ksshaskpass ksystemlog kteatime ktimer ktorrent ktouch
    kturtle kwallet-pam kwalletmanager kwave kwayland-integration kwin kwrited
    marble merkuro milou minuet okular oxygen oxygen-icons5 picmi
    plasma-browser-integration plasma-desktop plasma-integration plasma-nano
    plasma-nm plasma-pa plasma-mobile plasma-systemmonitor plasma-thunderbolt
    plasma-vault plasma-workspace plasma-workspace-wallpapers polkit-kde-agent
    powerdevil qqc2-breeze-style sddm-kcm skanlite skanpage spectacle
    systemsettings xdg-desktop-portal-kde yakuake zanshin
    ;

  kalendar = merkuro; # Renamed in 23.08
  kfloppy = throw "kfloppy has been removed upstream in KDE Gear 23.08";

  inherit (plasma5Packages.thirdParty)
    krohnkite
    krunner-ssh
    krunner-symbols
    kwin-dynamic-workspaces
    kwin-tiling
    plasma-applet-caffeine-plus
    plasma-applet-virtual-desktop-bar
    ;

  inherit (libsForQt5)
    sddm
    ;

  inherit (pidginPackages)
    pidgin-indicator
    pidgin-latex
    pidgin-msn-pecan
    pidgin-mra
    pidgin-skypeweb
    pidgin-carbons
    pidgin-xmpp-receipts
    pidgin-otr
    pidgin-osd
    pidgin-sipe
    pidgin-window-merge
    purple-discord
    purple-googlechat
    purple-hangouts
    purple-lurch
    purple-matrix
    purple-mm-sms
    purple-plugin-pack
    purple-signald
    purple-slack
    purple-vk-plugin
    purple-xmpp-http-upload
    tdlib-purple
    pidgin-opensteamworks
    purple-facebook
    ;

}
