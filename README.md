# Homebrew Tap

 [ ![Download](https://api.bintray.com/packages/sanghan/bottles-packages/homebrew-packages/images/download.svg?version=4.2.2) ](https://bintray.com/sanghan/bottles-packages/homebrew-packages/4.2.2/link)

Personal homebrew taps

# Installation

```sh
$ brew tap-pin jjangsangy/packages
$ brew install ffmpeg
```

In order to uninstall run

```sh
$ brew untap-pin jjangsangy/packages
```

# Options

```sh
$ brew options ffmpeg --compact
```

## Included libraries

This formula installs the following libraries by default:

| Dependency   | Description                |
|--------------|----------------------------|
| `libaom`     | AV1 encoder                |
| `fontconfig` | Font access library        |
| `freetype`   | Freetype font engine       |
| `frei0r`     | frei0r filters             |
| `lame`       | LAME MP3 encoder           |
| `libass`     | ASS subtitle support       |
| `libvorbis`  | Vorbis encoder             |
| `libvpx`     | VP8 and VP9 encoder        |
| `opus`       | Opus encoder               |
| `rtmpdump`   | RTMP dumping support       |
| `sdl2`       | Simple DirectMedia Layer   |
| `snappy`     | Snappy compression support |
| `theora`     | Theora encoder             |
| `x264`       | x264 H.264 encoder         |
| `x265`       | x265 HEVC encoder          |
| `xz`         | XZ compression support     |


This formula features the following libraries optionally:

| **Dependency**   | **Description**                                               |
|------------------|---------------------------------------------------------------|
| `chromaprint`    | Chromaprint audio fingerprinting library                      |
| `decklink`       | Enable DeckLink support <sup>[[1]](#1)</sup>           |
| `fdk-aac`        | Fraunhofer FDK AAC library                                    |
| `game-music-emu` | game-music-emu support                                        |
| `libbluray`      | libbluray support                                             |
| `libbs2b`        | libbs2b support                                               |
| `libcaca`        | libcaca support                                               |
| `libgsm`         | libgsm support                                                |
| `libmodplug`     | libmodplug support                                            |
| `librsvg`        | SVG files as inputs via librsvg                               |
| `libsoxr`        | soxr resample library                                         |
| `libssh`         | SFTP protocol via libssh                                      |
| `libvidstab`     | vid.stab support for video stabilization                      |
| `libvmaf`        | VMAF video quality metric                                     |
| `libxml2`        | libxml2 library                                               |
| `opencore-amr`   | Opencore AMR NR/WB audio format                               |
| `openh264`       | OpenH264 library                                              |
| `openjpeg`       | JPEG 2000 image format                                        |
| `openssl`        | SSL support                                                   |
| `rtmpdump`       | rtmpdump support                                              |
| `rubberband`     | rubberband library                                            |
| `speex`          | speex support                                                 |
| `srt`            | SRT library                                                   |
| `tesseract`      | tesseract OCR engine                                          |
| `two-lame`       | two-lame support                                              |
| `wavpack`        | wavpack support                                               |
| `webp`           | libwebp to encode WEBP images                                 |
| `xvid`           | xvid support                                                  |
| `zeromq`         | libzeromq to receive commands sent through a libzeromq client |
| `zimg`           | z.lib zimg library                                            |


# Reference


<span id="1">_[1]_:</span>
The DeckLink SDK has to be installed before running the FFmpeg formula.
One possibility is to use
```sh
$ brew install amiaopensource/amiaos/decklinksdk
```