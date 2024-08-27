{ pkgs ? import <nixpkgs> {} }:

let
  flutter = pkgs.flutterPackages.latest;
  node = pkgs.nodejs-18_x;
in
pkgs.mkShell {
  buildInputs = [
    flutter
    node
    pkgs.git
    pkgs.curl
    pkgs.unzip
  ];

  shellHook = ''
    echo "Setting up Flutter and Node.js environment..."
    export PATH="/nix/store/xi88khrz1m9irvw2a9q8acal1hhfx7k1-docker-24.0.9/bin:/nix/store/jw7hxwpr8szr4d74l0x502xpsjs35vyc-docker-compose-2.27.1/bin:/nix/store/2s18k6ara5488ar31rjkpji5r1hcnjyf-replit-moby-24.0.7+replit/bin:/nix/store/0xcqvyiqz6fxwx9y4bk5rqwz6vzyq622-replit-containerd-1.7.5+replit/bin:/nix/store/k5zw9yddxfqbkvk324g4d0clay5wvwas-replit-runc-1.1.9+replit/bin:/nix/store/66jf1ccjdj1p2m5a7krwgrsk88xmqjwd-replit-buildkit-v0.13.0-beta1+replit/bin:/nix/store/f5npcdb42kb8ar40rqb61s7pbph33mxf-npx/bin:/home/runner/aetk/.config/npm/node_global/bin:/home/runner/aetk/node_modules/.bin:/nix/store/6xa1f86vfk2bkyra02gaac366iasrp8v-nodejs-20.12.2-wrapped/bin:/nix/store/1rq42zfbv87531jq5ifpxh6jzjlabi0m-bun-1.1.21/bin:/nix/store/77wblnm5dnmgnan3695j3mk4r7j75s5j-pnpm-8.15.5/bin:/nix/store/d03xglbinz66yml6h55q6an183bxqcma-yarn-1.22.22/bin:/nix/store/gand47797zf39q7kkbym78flj5wfh9wf-prettier-3.2.5/bin:/nix/store/yfkm1jl2frrvgzyxqc53f3szvnk0xgmj-google-cloud-sdk-475.0.0/bin:/nix/store/rdd4pnr4x9rqc9wgbibhngv217w2xvxl-bash-interactive-5.2p26/bin:/nix/store/nbad47q0m0m9c5xid7zh05hiknwircbp-patchelf-0.15.0/bin:/nix/store/9bv7dcvmfcjnmg5mnqwqlq2wxfn8d7yi-gcc-wrapper-13.2.0/bin:/nix/store/14c6s4xzhy14i2b05s00rjns2j93gzz4-gcc-13.2.0/bin:/nix/store/c2i631h8i5vcs1sqifwxfsazhwrg6wr5-glibc-2.39-52-bin/bin:/nix/store/php4qidg2bxzmm79vpri025bqi0fa889-coreutils-9.5/bin:/nix/store/kln7kinji3b7sz8r50h4gn9yy6k1js9a-binutils-wrapper-2.41/bin:/nix/store/bgcaxhhxswzvmxjbbgvvaximm5hwghz1-binutils-2.41/bin:/nix/store/3vbchaj9cfhyld02gcd9j9s8a2fvgh6b-sudo-1.9.15p5/bin:/nix/store/yk06k2xi481mkz7lbnqip2178l547ihl-flutter-wrapped-3.22.0-sdk-links/bin:/nix/store/ix9vzqd3r8y4digxqnm0w6l04qqwhg5g-flutter-wrapped-3.13.8-sdk-links/bin:/nix/store/3krnmzljayw8nskx5wycbd4ibzjfavlp-flutter-wrapped-3.16.7-sdk-links/bin:/nix/store/ha8rh8jg19r8418baa8ps9b9kvd6szcf-attr-2.5.2-bin/bin:/nix/store/cnnmb3axmv43lj22gny3m4hj06i1nc7c-libcap-2.69/bin:/nix/store/pn9glkalcj7i5p549dpsl1c46pkb13xr-pulseaudio-17.0/bin:/nix/store/jjcsr5gs4qanf7ln5c6wgcq4sn75a978-findutils-4.9.0/bin:/nix/store/i34mknsjgrfyy71k2h79gda0bvagzc2j-diffutils-3.10/bin:/nix/store/5zjms21vpxlkbc0qyl5pmj2sidfmzmd7-gnused-4.9/bin:/nix/store/28gpmx3z6ss3znd7fhmrzmvk3x5lnfbk-gnugrep-3.11/bin:/nix/store/8vvkbgmnin1x2jkp7wcb2zg1p0vc4ks9-gawk-5.2.2/bin:/nix/store/rik7p68cq7yzlj5pmfpf4yv6jnrpvlgf-gnutar-1.35/bin:/nix/store/j5chw7v1x3vlmf3wmdpdb5gwh9hl0b80-gzip-1.13/bin:/nix/store/mxcq77rlan82dzpv3cgj0fh6qvv8ncil-bzip2-1.0.8-bin/bin:/nix/store/cdzpn0rdq810aknww3w9fy3wmw9ixr66-gnumake-4.4.1/bin:/nix/store/306znyj77fv49kwnkpxmb0j2znqpa8bj-bash-5.2p26/bin:/nix/store/0lfxbmchigx9vs9qmrlbahcy6nxwfnj1-patch-2.7.6/bin:/nix/store/6i4xxaa812vsbli9jkq4mksdddrk27lw-xz-5.4.6-bin/bin:/nix/store/xx7x1dwybpssfhq8yikvzz38bh3yrq97-file-5.45/bin:/nix/store/cp91q3wnk2p1cy9b8rsrnj4nrzqxp2xm-pid1/bin:/nix/store/76cwfjiic8036fr7alpyhjgjzvfj9bn9-replit-runtime-path/bin:/home/runner/.nix-profile/bin:/home/runner/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/bin"

    if [ ! -d "tiktok_clone" ]; then
      echo "Creating Flutter project..."
      flutter create tiktok_clone
      cd tiktok_clone
      echo "Adding Firebase dependencies..."
      cat <<EOL >> pubspec.yaml
dependencies:
  firebase_core: ^2.3.0
  firebase_auth: ^4.0.0
  cloud_firestore: ^4.0.0
  video_player: ^2.4.2
