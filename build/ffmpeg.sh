#!/bin/bash

set -euo pipefail

CONF_FLAGS=(
  --target-os=none              # disable target specific configs
  --arch=x86_32                 # use x86_32 arch
  --enable-cross-compile        # use cross compile configs
  --disable-asm                 # disable asm
  --disable-stripping           # disable stripping as it won't work
  --disable-programs            # disable ffmpeg, ffprobe and ffplay build
  --disable-doc                 # disable doc build
  --disable-debug               # disable debug mode
  --disable-runtime-cpudetect   # disable cpu detection
  --enable-small
  --disable-logging
  #--disable-autodetect         # disable env auto detect
  #--disable-everything         # MAJOR
  
  --disable-protocols          # We need protocols
  
  --disable-muxers
  --disable-demuxers
  
  --disable-encoders
  --disable-decoders

  --disable-x86asm
  --disable-inline-asm
  
  #--disable-avfilter          # We can't disable this
  --disable-filters
  
  # Required Items
  --enable-libvorbis
  --enable-encoder=libvorbis
  --enable-decoder=libvorbis
  --enable-protocol=file
  --enable-protocol=pipe

  --enable-filter=anull
  --enable-filter=aformat
  --enable-filter=aresample
  --enable-filter=volume
  --enable-filter=atrim

  --enable-decoder=pcm_s16le
  --enable-decoder=pcm_f32le
  #--enable-decoder=pcm_u8
  
  --enable-encoder=pcm_s16le  
  
  # --enable-muxer=wav
  --enable-muxer=ogg
  --enable-muxer=segment      # segment
  # --enable-muxer=pcm_s16le
  # --enable-muxer=pcm_f32le
  # --enable-muxer=pcm_u8  

  #################################################
  # --enable-muxer=a64  --enable-muxer=h264 --enable-muxer=pcm_s24be
  # --enable-muxer=ac3  --enable-muxer=hash  --enable-muxer=pcm_s24le
  # --enable-muxer=adts --enable-muxer=hds  --enable-muxer=pcm_s32be
  # --enable-muxer=adx  --enable-muxer=hevc  --enable-muxer=pcm_s32le
  # --enable-muxer=aiff --enable-muxer=hls  --enable-muxer=pcm_s8
  # --enable-muxer=alp  --enable-muxer=ico  --enable-muxer=pcm_u16be
  # --enable-muxer=amr  --enable-muxer=ilbc  --enable-muxer=pcm_u16le
  # --enable-muxer=amv  --enable-muxer=image2  --enable-muxer=pcm_u24be
  # --enable-muxer=apm  --enable-muxer=image2pipe  --enable-muxer=pcm_u24le
  # --enable-muxer=apng --enable-muxer=ipod  --enable-muxer=pcm_u32be
  # --enable-muxer=aptx  --enable-muxer=ircam  --enable-muxer= pcm_u32le
  # --enable-muxer=aptx_hd  --enable-muxer=ismv  --enable-muxer=pcm_u8
  # --enable-muxer=argo_asf  --enable-muxer=ivf  --enable-muxer=pcm_vidc
  # --enable-muxer=argo_cvg  --enable-muxer=jacosub  --enable-muxer=psp
  # --enable-muxer=asf  --enable-muxer=kvag  --enable-muxer=rawvideo
  # --enable-muxer=asf_stream  --enable-muxer=latm  --enable-muxer=rm
  # --enable-muxer=ass  --enable-muxer=lrc  --enable-muxer=roq
  # --enable-muxer=ast  --enable-muxer=m4v  --enable-muxer=rso
  # --enable-muxer=au  --enable-muxer= matroska  --enable-muxer=rtp
  # --enable-muxer=avi  --enable-muxer=matroska_audio  --enable-muxer=rtp_mpegts
  # --enable-muxer=avif  --enable-muxer=md5  --enable-muxer=sbc
  # --enable-muxer=avm2  --enable-muxer=microdvd  --enable-muxer=scc
  # --enable-muxer=avs2  --enable-muxer=mjpeg  --enable-muxer=segafilm
  # --enable-muxer=avs3  --enable-muxer=mkvtimestamp_v2  --enable-muxer=segment
  # --enable-muxer=bit  --enable-muxer=mlp  --enable-muxer=smjpeg
  # --enable-muxer=caf  --enable-muxer=mmf  --enable-muxer=smoothstreaming
  # --enable-muxer=cavsvideo  --enable-muxer=mov  --enable-muxer=sox
  # --enable-muxer=codec2  --enable-muxer=mp2  --enable-muxer=spdif
  # --enable-muxer=codec2raw  --enable-muxer=mp3  --enable-muxer=spx
  # --enable-muxer=crc  --enable-muxer=mpeg1system  --enable-muxer=srt
  # --enable-muxer=data  --enable-muxer=mpeg1vcd  --enable-muxer=stream_segment
  # --enable-muxer=daud  --enable-muxer=mpeg1video  --enable-muxer=streamhash
  # --enable-muxer=dfpwm  --enable-muxer=mpeg2dvd  --enable-muxer=sup
  # --enable-muxer=dirac  --enable-muxer=mpeg2svcd  --enable-muxer=swf
  # --enable-muxer=dnxhd  --enable-muxer=mpeg2video  --enable-muxer=tee
  # --enable-muxer=dts  --enable-muxer=mpeg2vob  --enable-muxer=tg2
  # --enable-muxer=dv  --enable-muxer=mpegts  --enable-muxer=tgp
  # --enable-muxer=eac3  --enable-muxer=mpjpeg  --enable-muxer=truehd
  # --enable-muxer=f4v  --enable-muxer=mxf  --enable-muxer=tta
  # --enable-muxer=ffmetadata  --enable-muxer=mxf_d10  --enable-muxer=ttml
  # --enable-muxer=fifo_test  --enable-muxer=mxf_opatom  --enable-muxer=uncodedframecrc
  # --enable-muxer=filmstrip  --enable-muxer=null  --enable-muxer=vc1
  # --enable-muxer=fits  --enable-muxer=nut  --enable-muxer=vc1t
  # --enable-muxer=flac  --enable-muxer=obu  --enable-muxer=voc
  # --enable-muxer=flv  --enable-muxer=oga  --enable-muxer=w64
  # --enable-muxer=framecrc  --enable-muxer=ogg  --enable-muxer=wav
  # --enable-muxer=framehash  --enable-muxer=ogv  --enable-muxer=webm
  # --enable-muxer=framemd5  --enable-muxer=oma  --enable-muxer=webm_chunk
  # --enable-muxer=g722  --enable-muxer=opus  --enable-muxer=webm_dash_manifest
  # --enable-muxer=g723_1  --enable-muxer=pcm_alaw  --enable-muxer=webp
  # --enable-muxer=g726  --enable-muxer=pcm_f32be  --enable-muxer=webvtt
  # --enable-muxer=g726le  --enable-muxer=pcm_f32le  --enable-muxer=wsaud
  # --enable-muxer=gif  --enable-muxer=pcm_f64be  --enable-muxer=wtv
  # --enable-muxer=gsm  --enable-muxer=pcm_f64le  --enable-muxer=wv
  # --enable-muxer=gxf  --enable-muxer=pcm_mulaw  --enable-muxer=yuv4mpegpipe
  # --enable-muxer=h261  --enable-muxer=pcm_s16be
  # --enable-muxer=h263  --enable-muxer=pcm_s16le
  #################################################
  # --enable-muxer=3g2        #     3GP2 (3GPP2 fil--enable-muxer=format)
  # --enable-muxer=3gp      #     3GP (3GPP file format)
  # --enable-muxer=a64      #     a64 - video for Commodore 64
  # --enable-muxer=ac3      #     raw AC-3
  # --enable-muxer=adts      #    ADTS AAC (Advanced Audio Coding)
  # --enable-muxer=adx      #     CRI ADX
  # --enable-muxer=aiff      #    Audio IFF
  # --enable-muxer=alaw      #    PCM A-law
  # --enable-muxer=alp      #     LEGO Racers ALP
  # --enable-muxer=alsa      #    ALSA audio output
  # --enable-muxer=amr      #     3GPP AMR
  # --enable-muxer=amv      #     AMV
  # --enable-muxer=apm      #     Ubisoft Rayman 2 APM
  # --enable-muxer=apng      #    Animated Portable Network Graphics
  # --enable-muxer=aptx      #    raw aptX (Audio Processing Technology for Bluetooth)
  # --enable-muxer=aptx_hd      # raw aptX HD (Audio Processing Technology for Bluetooth)
  # --enable-muxer=argo_asf      #Argonaut Games ASF
  # --enable-muxer=asf      #     ASF (Advanced / Active Streaming Format)
  # --enable-muxer=asf_stream  #    ASF (Advanced / Active Streaming Format)
  # --enable-muxer=ass      #     SSA (SubStation Alpha) subtitle
  # --enable-muxer=ast      #     AST (Audio Stream)
  # --enable-muxer=au      #      Sun AU
  # --enable-muxer=avi      #     AVI (Audio Video Interleaved)
  # --enable-muxer=avm2      #    SWF (ShockWave Flash) (AVM2)
  # --enable-muxer=avs2      #    raw AVS2-P2/IEEE1857.4 video
  # --enable-muxer=bit      #     G.729 BIT file format
  # --enable-muxer=caca      #    caca (color ASCII art) output device
  # --enable-muxer=caf      #     Apple CAF (Core Audio Format)
  # --enable-muxer=cavsvideo    #   raw Chinese AVS (Audio Video Standard) video
  # --enable-muxer=chromaprint   #  Chromaprint
  # --enable-muxer=codec2      #  codec2 .c2 muxer
  # --enable-muxer=codec2raw      # raw codec2 muxer
  # --enable-muxer=crc      #     CRC testing
  # --enable-muxer=dash      #    DASH Muxer
  # --enable-muxer=data      #    raw data
  # --enable-muxer=daud      #    D-Cinema audio
  # --enable-muxer=dirac      #   raw Dirac
  # --enable-muxer=dnxhd      #   raw DNxHD (SMPT--enable-muxer=VC-3)
  # --enable-muxer=dts      #     raw DTS
  # --enable-muxer=dv      #      DV (Digital Video)
  # --enable-muxer=dvd      #     MPEG-2 PS (DVD VOB)
  # --enable-muxer=eac3      #    raw E-AC-3
  # --enable-muxer=f32be      #   PCM 32-bit floating-point big-endian
  # --enable-muxer=f32le      #   PCM 32-bit floating-point little-endian
  # --enable-muxer=f4v      #     F4V Adobe Flash Video
  # --enable-muxer=f64be      #   PCM 64-bit floating-point big-endian
  # --enable-muxer=f64le      #   PCM 64-bit floating-point little-endian
  # --enable-muxer=fbdev      #   Linux framebuffer
  # --enable-muxer=ffmetadata      #FFmpeg metadata in text
  # --enable-muxer=fifo      #    FIFO queue pseudo-muxer
  # --enable-muxer=fifo_test       #Fifo test muxer
  # --enable-muxer=film_cpk      #Sega FILM / CPK
  # --enable-muxer=filmstrip       #Adobe Filmstrip
  # --enable-muxer=fits      #    Flexible Image Transport System
  # --enable-muxer=flac      #    raw FLAC
  # --enable-muxer=flv      #     FLV (Flash Video)
  # --enable-muxer=framecrc      #framecrc testing
  # --enable-muxer=framehash       #Per-frame hash testing
  # --enable-muxer=framemd5      #Per-frame MD5 testing
  # --enable-muxer=g722      #    raw G.722
  # --enable-muxer=g723_1      #  raw G.723.1
  # --enable-muxer=g726      #    raw big-endian G.726 ("left-justified")
  # --enable-muxer=g726le      #  raw little-endian G.726 ("right-justified")
  # --enable-muxer=gif      #     CompuServe Graphics Interchange Format (GIF)
  # --enable-muxer=gsm      #     raw GSM
  # --enable-muxer=gxf      #     GXF (General eXchange Format)
  # --enable-muxer=h261      #    raw H.261
  # --enable-muxer=h263      #    raw H.263
  # --enable-muxer=h264      #    raw H.264 video
  # --enable-muxer=hash      #    Hash testing
  # --enable-muxer=hds      #     HDS Muxer
  # --enable-muxer=hevc      #    raw HEVC video
  # --enable-muxer=hls      #     Apple HTTP Live Streaming
  # --enable-muxer=ico      #     Microsoft Windows ICO
  # --enable-muxer=ilbc      #    iLBC storage
  # --enable-muxer=image2      #  image2 sequence
  # --enable-muxer=image2pipe      #piped image2 sequence
  # --enable-muxer=ipod      #    iPod H.264 MP4 (MPEG-4 Part 14)
  # --enable-muxer=ircam      #   Berkeley/IRCAM/CARL Sound Format
  # --enable-muxer=ismv      #    ISMV/ISMA (Smooth Streaming)
  # --enable-muxer=ivf      #     On2 IVF
  # --enable-muxer=jacosub      # JACOsub subtitle format
  # --enable-muxer=kvag      #    Simon & Schuster Interactive VAG
  # --enable-muxer=latm      #    LOAS/LATM
  # --enable-muxer=lrc      #     LRC lyrics
  # --enable-muxer=m4v      #     raw MPEG-4 video
  # --enable-muxer=matroska      #Matroska
  # --enable-muxer=md5      #     MD5 testing
  # --enable-muxer=microdvd      #MicroDVD subtitle format
  # --enable-muxer=mjpeg      #   raw MJPEG video
  # --enable-muxer=mkvtimestamp_v2 #extract pts as timecode v2 format, as defined by mkvtoolnix
  # --enable-muxer=mlp      #     raw MLP

  # --enable-muxer=mmf      #     Yamaha SMAF
  # --enable-muxer=mov      #     QuickTime / MOV
  # --enable-muxer=mp2      #     MP2 (MPEG audio layer 2)
  # --enable-muxer=mp3      #     MP3 (MPEG audio layer 3)
  # --enable-muxer=mp4      #     MP4 (MPEG-4 Part 14)
  # --enable-muxer=mpeg      #    MPEG-1 Systems / MPEG program stream
  # --enable-muxer=mpeg1video      #raw MPEG-1 video
  # --enable-muxer=mpeg2video      #raw MPEG-2 video
  # --enable-muxer=mpegts      #  MPEG-TS (MPEG-2 Transport Stream)
  # --enable-muxer=mpjpeg      #  MIM--enable-muxer=multipart JPEG
  # --enable-muxer=mulaw      #   PCM mu-law
  # --enable-muxer=mxf      #     MXF (Material eXchange Format)
  # --enable-muxer=mxf_d10      # MXF (Material eXchange Format) D-10 Mapping
  # --enable-muxer=mxf_opatom      #MXF (Material eXchange Format) Operational Pattern Atom
  # --enable-muxer=null      #    raw null video
  # --enable-muxer=nut      #     NUT
  # --enable-muxer=oga      #     Ogg Audio
  # --enable-muxer=ogg      #     Ogg
  # --enable-muxer=ogv      #     Ogg Video
  # --enable-muxer=oma      #     Sony OpenMG audio
  # --enable-muxer=opengl      #  OpenGL output
  # --enable-muxer=opus      #    Ogg Opus
  # --enable-muxer=oss      #     OSS (Open Sound System) playback
  # --enable-muxer=psp      #     PSP MP4 (MPEG-4 Part 14)
  # --enable-muxer=pulse      #   Pulse audio output
  # --enable-muxer=rawvideo      #raw video
  # --enable-muxer=rm      #      RealMedia
  # --enable-muxer=roq      #     raw id RoQ
  # --enable-muxer=rso      #     Lego Mindstorms RSO
  # --enable-muxer=rtp      #     RTP output
  # --enable-muxer=rtp_mpegts      #RTP/mpegts output format
  # --enable-muxer=rtsp      #    RTSP output
  # --enable-muxer=s16be      #   PCM signed 16-bit big-endian
  # --enable-muxer=s16le      #   PCM signed 16-bit little-endian
  # --enable-muxer=s24be      #   PCM signed 24-bit big-endian
  # --enable-muxer=s24le      #   PCM signed 24-bit little-endian
  # --enable-muxer=s32be      #   PCM signed 32-bit big-endian
  # --enable-muxer=s32le      #   PCM signed 32-bit little-endian
  # --enable-muxer=s8      #      PCM signed 8-bit

  # --enable-muxer=sap      #     SAP output
  # --enable-muxer=sbc      #     raw SBC
  # --enable-muxer=scc      #     Scenarist Closed Captions
  # --enable-muxer=sdl,sdl2      #SDL2 output device

  # --enable-muxer=singlejpeg      #JPEG single image
  # --enable-muxer=smjpeg      #  Loki SDL MJPEG
  # --enable-muxer=smoothstreaming #Smooth Streaming Muxer
  # --enable-muxer=sndio      #   sndio audio playback
  # --enable-muxer=sox      #     SoX native
  # --enable-muxer=spdif      #   IEC 61937 (used on S/PDIF - IEC958)

  # --enable-muxer=spx      #     Ogg Speex
  # --enable-muxer=srt      #     SubRip subtitle
  # --enable-muxer=stream_segment,ssegment #streaming segment muxer
  # --enable-muxer=streamhash      #Per-stream hash testing
  # --enable-muxer=sup      #     raw HDMV Presentation Graphic Stream subtitles
  # --enable-muxer=svcd      #    MPEG-2 PS (SVCD)
  # --enable-muxer=swf      #     SWF (ShockWave Flash)
  # --enable-muxer=tee      #     Multiple muxer tee
  # --enable-muxer=truehd      #  raw TrueHD
  # --enable-muxer=tta      #     TTA (True Audio)
  # --enable-muxer=ttml      #    TTML subtitle

  # --enable-muxer=u16be      #   PCM unsigned 16-bit big-endian
  # --enable-muxer=u16le      #   PCM unsigned 16-bit little-endian
  # --enable-muxer=u24be      #   PCM unsigned 24-bit big-endian
  # --enable-muxer=u24le      #   PCM unsigned 24-bit little-endian
  # --enable-muxer=u32be      #   PCM unsigned 32-bit big-endian
  # --enable-muxer=u32le      #   PCM unsigned 32-bit little-endian
  # --enable-muxer=u8      #      PCM unsigned 8-bit
  # --enable-muxer=uncodedframecrc #uncoded framecrc testing
  # --enable-muxer=vc1      #     raw VC-1 video
  # --enable-muxer=vc1test      # VC-1 test bitstream
  # --enable-muxer=vcd      #     MPEG-1 Systems / MPEG program stream (VCD)
  # --enable-muxer=vidc      #    PCM Archimedes VIDC
  # --enable-muxer=video4linux2,v4l2 #Video4Linux2 output device
  # --enable-muxer=vob      #     MPEG-2 PS (VOB)
  # --enable-muxer=voc      #     Creative Voice
  # --enable-muxer=w64      #     Sony Wave64
  # --enable-muxer=wav      #     WAV / WAV--enable-muxer=(Waveform Audio)
  # --enable-muxer=webm      #    WebM
  # --enable-muxer=webm_chunk      #WebM Chunk Muxer
  # --enable-muxer=webm_dash_manifest #WebM DASH Manifest
  # --enable-muxer=webp      #    WebP
  # --enable-muxer=webvtt      #  WebVTT subtitle
  # --enable-muxer=wtv      #     Windows Television (WTV)
  # --enable-muxer=wv      #      raw WavPack
  # --enable-muxer=xv      #      XV (XVideo) output device
  # --enable-muxer=yuv4mpegpipe    #YUV4MPEG pipe
  ################################################################
  #--enable-demuxer=ogg
  --enable-demuxer=wav
  # --enable-demuxer=pcm_s16le
  # --enable-demuxer=pcm_f32le
  # --enable-demuxer=pcm_u8
  #################################################################
   #--enable-demuxer=3dostr         # 3DO STR
  
  #--enable-demuxer=4xm         #    4X Technologies
  #--enable-demuxer=aa         #     Audible AA format files
  # --enable-demuxer=aac         #    raw ADTS AAC (Advanced Audio Coding)
  # --enable-demuxer=aax         #    CRI AAX
  # --enable-demuxer=ac3         #    raw AC-3
  # --enable-demuxer=ace         #    tri-Ace Audio Container

  # --enable-demuxer=acm         #    Interplay ACM
  # --enable-demuxer=act         #    ACT Voice file format
  # --enable-demuxer=adf         #    Artworx Data Format
  # --enable-demuxer=adp         #    ADP
  # --enable-demuxer=ads         #    Sony PS2 ADS
  # --enable-demuxer=adx         #    CRI ADX
  # --enable-demuxer=aea         #    MD STUDIO audio

  # --enable-demuxer=afc         #    AFC
  # --enable-demuxer=aiff         #   Audio IFF
  # --enable-demuxer=aix         #    CRI AIX
  # --enable-demuxer=alaw         #   PCM A-law
  # --enable-demuxer=alias_pix       #Alias/Wavefront PIX image
  # --enable-demuxer=alp         #    LEGO Racers ALP
  # --enable-demuxer=alsa         #   ALSA audio input
  # --enable-demuxer=amr         #    3GPP AMR
  # --enable-demuxer=amrnb         #  raw AMR-NB
  # --enable-demuxer=amrwb         #  raw AMR-WB
  # --enable-demuxer=anm         #    Deluxe Paint Animation
  # --enable-demuxer=apc         #    CRYO APC
  # --enable-demuxer=ape         #    Monkey's Audio
  # --enable-demuxer=apm         #    Ubisoft Rayman 2 APM
  # --enable-demuxer=apng         #   Animated Portable Network Graphics
  # --enable-demuxer=aptx         #   raw aptX
  # --enable-demuxer=aptx_hd         #raw aptX HD
  # --enable-demuxer=aqtitle         #AQTitle subtitles

  # --enable-demuxer=argo_asf        #Argonaut Games ASF
  # --enable-demuxer=argo_brp        #Argonaut Games BRP
  # --enable-demuxer=asf         #    ASF (Advanced / Active Streaming Format)
  # --enable-demuxer=asf_o         #  ASF (Advanced / Active Streaming Format)
  # --enable-demuxer=ass         #    SSA (SubStation Alpha) subtitle
  # --enable-demuxer=ast         #    AST (Audio Stream)
  # --enable-demuxer=au         #     Sun AU
  # --enable-demuxer=av1         #    AV1 Annex B
  # --enable-demuxer=avi         #    AVI (Audio Video Interleaved)
  # --enable-demuxer=avr         #    AVR (Audio Visual Research)
  # --enable-demuxer=avs         #    Argonaut Games Creature Shock
  # --enable-demuxer=avs2         #   raw AVS2-P2/IEEE1857.4
  # --enable-demuxer=avs3         #   raw AVS3-P2/IEEE1857.10
  # --enable-demuxer=bethsoftvid     #Bethesda Softworks VID
  # --enable-demuxer=bfi         #    Brute Force & Ignorance
  # --enable-demuxer=bfstm         #  BFSTM (Binary Cafe Stream)
  # --enable-demuxer=bin         #    Binary text
  # --enable-demuxer=bink         #   Bink
  # --enable-demuxer=binka         #  Bink Audio
  # --enable-demuxer=bit         #    G.729 BIT file format
  # --enable-demuxer=bmp_pipe        #piped bmp sequence
  # --enable-demuxer=bmv         #    Discworld II BMV
  # --enable-demuxer=boa         #    Black Ops Audio
  # --enable-demuxer=brender_pix     #BRender PIX image
  # --enable-demuxer=brstm         #  BRSTM (Binary Revolution Stream)
  # --enable-demuxer=c93         #    Interplay C93
  # --enable-demuxer=caf         #    Apple CAF (Core Audio Format)
  # --enable-demuxer=cavsvideo       #raw Chinese AVS (Audio Video Standard)
  # --enable-demuxer=cdg         #    CD Graphics
  # --enable-demuxer=cdxl         #   Commodore CDXL video
  # --enable-demuxer=cine         #   Phantom Cine
  # --enable-demuxer=codec2         # codec2 .c2 demuxer
  # --enable-demuxer=codec2raw       #raw codec2 demuxer
  # --enable-demuxer=concat         # Virtual concatenation script
  # --enable-demuxer=cri_pipe        #piped cri sequence
  # --enable-demuxer=dash         #   Dynamic Adaptive Streaming over HTTP
  # --enable-demuxer=data         #   raw data
  # --enable-demuxer=daud         #   D-Cinema audio

  # --enable-demuxer=dcstr         #  Sega DC STR
  # --enable-demuxer=dds_pipe        #piped dds sequence
  # --enable-demuxer=derf         #   Xilam DERF
  # --enable-demuxer=dfa         #    Chronomaster DFA
  # --enable-demuxer=dhav         #   Video DAV
  # --enable-demuxer=dirac         #  raw Dirac
  # --enable-demuxer=dnxhd         #  raw DNxHD (SMPTE VC-3)
  # --enable-demuxer=dpx_pipe        #piped dpx sequence
  # --enable-demuxer=dsf         #    DSD Stream File (DSF)
  # --enable-demuxer=dsicin         # Delphine Software International CIN
  # --enable-demuxer=dss         #    Digital Speech Standard (DSS)
  # --enable-demuxer=dts         #    raw DTS
  # --enable-demuxer=dtshd         #  raw DTS-HD
  # --enable-demuxer=dv         #     DV (Digital Video)
  # --enable-demuxer=dvbsub         # raw dvbsub
  # --enable-demuxer=dvbtxt         # dvbtxt
  # --enable-demuxer=dxa         #    DXA
  # --enable-demuxer=ea         #     Electronic Arts Multimedia
  # --enable-demuxer=ea_cdata        #Electronic Arts cdata
  # --enable-demuxer=eac3         #   raw E-AC-3
  # --enable-demuxer=epaf         #   Ensoniq Paris Audio File
  # --enable-demuxer=exr_pipe        #piped exr sequence
  # --enable-demuxer=f32be         #  PCM 32-bit floating-point big-endian
  # --enable-demuxer=f32le         #  PCM 32-bit floating-point little-endian
  # --enable-demuxer=f64be         #  PCM 64-bit floating-point big-endian
  # --enable-demuxer=f64le         #  PCM 64-bit floating-point little-endian
  # --enable-demuxer=fbdev         #  Linux framebuffer
  # --enable-demuxer=ffmetadata      #FFmpeg metadata in text
  # --enable-demuxer=film_cpk        #Sega FILM / CPK
  # --enable-demuxer=filmstrip       #Adobe Filmstrip
  # --enable-demuxer=fits         #   Flexible Image Transport System
  # --enable-demuxer=flac         #   raw FLAC
  # --enable-demuxer=flic         #   FLI/FLC/FLX animation
  # --enable-demuxer=flv         #    FLV (Flash Video)
  # --enable-demuxer=frm         #    Megalux Frame
  # --enable-demuxer=fsb         #    FMOD Sample Bank
  # --enable-demuxer=fwse         #   Capcom's MT Framework sound
  # --enable-demuxer=g722         #   raw G.722
  # --enable-demuxer=g723_1         # G.723.1
  # --enable-demuxer=g726         #   raw big-endian G.726 ("left aligned")
  # --enable-demuxer=g726le         # raw little-endian G.726 ("right aligned")
  # --enable-demuxer=g729         #   G.729 raw format demuxer
  # --enable-demuxer=gdv         #    Gremlin Digital Video
  # --enable-demuxer=genh         #   GENeric Header
  # --enable-demuxer=gif         #    CompuServe Graphics Interchange Format (GIF)
  # --enable-demuxer=gif_pipe        #piped gif sequence
  # --enable-demuxer=gsm         #    raw GSM
  # --enable-demuxer=gxf         #    GXF (General eXchange Format)
  # --enable-demuxer=h261         #   raw H.261
  # --enable-demuxer=h263         #   raw H.263
  # --enable-demuxer=h264         #   raw H.264 video
  # --enable-demuxer=hca         #    CRI HCA
  # --enable-demuxer=hcom         #   Macintosh HCOM
  # --enable-demuxer=hevc         #   raw HEVC video
  # --enable-demuxer=hls         #    Apple HTTP Live Streaming
  # --enable-demuxer=hnm         #    Cryo HNM v4
  # --enable-demuxer=ico         #    Microsoft Windows ICO
  # --enable-demuxer=idcin         #  id Cinematic
  # --enable-demuxer=idf         #    iCE Draw File
  # --enable-demuxer=iec61883        #libiec61883 (new DV1394) A/V input device
  # --enable-demuxer=iff         #    IFF (Interchange File Format)
  # --enable-demuxer=ifv         #    IFV CCTV DVR
  # --enable-demuxer=ilbc         #   iLBC storage
  # --enable-demuxer=image2         # image2 sequence
  # --enable-demuxer=image2pipe      #piped image2 sequence
  # --enable-demuxer=ingenient       #raw Ingenient MJPEG
  # --enable-demuxer=ipmovie         #Interplay MVE
  # --enable-demuxer=ipu         #    raw IPU Video
  # --enable-demuxer=ircam         #  Berkeley/IRCAM/CARL Sound Format
  # --enable-demuxer=iss         #    Funcom ISS
  # --enable-demuxer=iv8         #    IndigoVision 8000 video
  # --enable-demuxer=ivf         #    On2 IVF
  # --enable-demuxer=ivr         #    IVR (Internet Video Recording)
  # --enable-demuxer=j2k_pipe        #piped j2k sequence
  # --enable-demuxer=jack         #   JACK Audio Connection Kit
  # --enable-demuxer=jacosub         #JACOsub subtitle format
  # --enable-demuxer=jpeg_pipe       #piped jpeg sequence
  # --enable-demuxer=jpegls_pipe     #piped jpegls sequence
  # --enable-demuxer=jv         #     Bitmap Brothers JV
  # --enable-demuxer=kmsgrab         #KMS screen capture
  # --enable-demuxer=kux         #    KUX (YouKu)

  # --enable-demuxer=kvag         #   Simon & Schuster Interactive VAG
  # --enable-demuxer=lavfi         #  Libavfilter virtual input device
  # --enable-demuxer=libcdio
  # --enable-demuxer=libdc1394       #dc1394 v.2 A/V grab
  # --enable-demuxer=libgme         # Game Music Emu demuxer
  # --enable-demuxer=libopenmpt      #Tracker formats (libopenmpt)
  # --enable-demuxer=live_flv        #live RTMP FLV (Flash Video)
  # --enable-demuxer=lmlm4         #  raw lmlm4
  # --enable-demuxer=loas         #   LOAS AudioSyncStream
  # --enable-demuxer=lrc         #    LRC lyrics
  # --enable-demuxer=luodat         # Video CCTV DAT
  # --enable-demuxer=lvf         #    LVF
  # --enable-demuxer=lxf         #    VR native stream (LXF)
  # --enable-demuxer=m4v         #    raw MPEG-4 video
  # --enable-demuxer=matroska,webm   #Matroska / WebM
  # --enable-demuxer=mca         #    MCA Audio Format
  # --enable-demuxer=mcc         #    MacCaption
  # --enable-demuxer=mgsts         #  Metal Gear Solid: The Twin Snakes
  # --enable-demuxer=microdvd        #MicroDVD subtitle format
  # --enable-demuxer=mjpeg         #  raw MJPEG video
  # --enable-demuxer=mjpeg_2000      #raw MJPEG 2000 video
  # --enable-demuxer=mlp         #    raw MLP
  # --enable-demuxer=mlv         #    Magic Lantern Video (MLV)
  # --enable-demuxer=mm         #     American Laser Games MM
  # --enable-demuxer=mmf         #    Yamaha SMAF
  # --enable-demuxer=mods         #   MobiClip MODS
  # --enable-demuxer=moflex         # MobiClip MOFLEX
  # --enable-demuxer=mov,mp4,m4a,3gp,3g2,mj2 #QuickTime / MOV
  # --enable-demuxer=mp3         #    MP2/3 (MPEG audio layer 2/3)
  # --enable-demuxer=mpc         #    Musepack
  # --enable-demuxer=mpc8         #   Musepack SV8
  # --enable-demuxer=mpeg         #   MPEG-PS (MPEG-2 Program Stream)
  # --enable-demuxer=mpegts         # MPEG-TS (MPEG-2 Transport Stream)
  # --enable-demuxer=mpegtsraw       #raw MPEG-TS (MPEG-2 Transport Stream)
  # --enable-demuxer=mpegvideo       #raw MPEG video
  # --enable-demuxer=mpjpeg         # MIME multipart JPEG
  # --enable-demuxer=mpl2         #   MPL2 subtitles
  # --enable-demuxer=mpsub         #  MPlayer subtitles
  # --enable-demuxer=msf         #    Sony PS3 MSF
  # --enable-demuxer=msnwctcp        #MSN TCP Webcam stream
  # --enable-demuxer=msp         #    Microsoft Paint (MSP))
  # --enable-demuxer=mtaf         #   Konami PS2 MTAF
  # --enable-demuxer=mtv         #    MTV
  # --enable-demuxer=mulaw         #  PCM mu-law
  # --enable-demuxer=musx         #   Eurocom MUSX
  # --enable-demuxer=mv         #     Silicon Graphics Movie
  # --enable-demuxer=mvi         #    Motion Pixels MVI
  # --enable-demuxer=mxf         #    MXF (Material eXchange Format)
  # --enable-demuxer=mxg         #    MxPEG clip
  # --enable-demuxer=nc         #     NC camera feed
  # --enable-demuxer=nistsphere      #NIST SPeech HEader REsources
  # --enable-demuxer=nsp         #    Computerized Speech Lab NSP
  # --enable-demuxer=nsv         #    Nullsoft Streaming Video
  # --enable-demuxer=nut         #    NUT
  # --enable-demuxer=nuv         #    NuppelVideo
  # --enable-demuxer=obu         #    AV1 low overhead OBU
  # --enable-demuxer=ogg         #    Ogg
  # --enable-demuxer=oma         #    Sony OpenMG audio
  # --enable-demuxer=openal         # OpenAL audio capture device
  # --enable-demuxer=oss         #    OSS (Open Sound System) capture
  # --enable-demuxer=paf         #    Amazing Studio Packed Animation File
  # --enable-demuxer=pam_pipe        #piped pam sequence
  # --enable-demuxer=pbm_pipe        #piped pbm sequence
  # --enable-demuxer=pcx_pipe        #piped pcx sequence
  # --enable-demuxer=pgm_pipe        #piped pgm sequence
  # --enable-demuxer=pgmyuv_pipe     #piped pgmyuv sequence
  # --enable-demuxer=pgx_pipe        #piped pgx sequence
  # --enable-demuxer=photocd_pipe    #piped photocd sequence
  # --enable-demuxer=pictor_pipe     #piped pictor sequence
  # --enable-demuxer=pjs         #    PJS (Phoenix Japanimation Society) subtitles
  # --enable-demuxer=pmp         #    Playstation Portable PMP
  # --enable-demuxer=png_pipe        #piped png sequence
  # --enable-demuxer=pp_bnk         # Pro Pinball Series Soundbank
  # --enable-demuxer=ppm_pipe        #piped ppm sequence
  # --enable-demuxer=psd_pipe        #piped psd sequence
  # --enable-demuxer=psxstr         # Sony Playstation STR
  # --enable-demuxer=pulse         #  Pulse audio input
  # --enable-demuxer=pva         #    TechnoTrend PVA
  # --enable-demuxer=pvf         #    PVF (Portable Voice Format)
  # --enable-demuxer=qcp         #    QCP
  # --enable-demuxer=qdraw_pipe      #piped qdraw sequence
  # --enable-demuxer=r3d         #    REDCODE R3D
  # --enable-demuxer=rawvideo        #raw video
  # --enable-demuxer=realtext        #RealText subtitle format
  # --enable-demuxer=redspark        #RedSpark
  # --enable-demuxer=rl2         #    RL2
  # --enable-demuxer=rm         #     RealMedia
  # --enable-demuxer=roq         #    id RoQ
  # --enable-demuxer=rpl         #    RPL / ARMovie
  # --enable-demuxer=rsd         #    GameCube RSD
  # --enable-demuxer=rso         #    Lego Mindstorms RSO
  # --enable-demuxer=rtp         #    RTP input
  # --enable-demuxer=rtsp         #   RTSP input
  # --enable-demuxer=s16be         #  PCM signed 16-bit big-endian
  # --enable-demuxer=s16le         #  PCM signed 16-bit little-endian
  # --enable-demuxer=s24be         #  PCM signed 24-bit big-endian
  # --enable-demuxer=s24le         #  PCM signed 24-bit little-endian
  # --enable-demuxer=s32be         #  PCM signed 32-bit big-endian
  # --enable-demuxer=s32le         #  PCM signed 32-bit little-endian
  # --enable-demuxer=s337m         #  SMPTE 337M
  # --enable-demuxer=s8         #     PCM signed 8-bit
  # --enable-demuxer=sami         #   SAMI subtitle format
  # --enable-demuxer=sap         #    SAP input
  # --enable-demuxer=sbc         #    raw SBC (low-complexity subband codec)
  # --enable-demuxer=sbg         #    SBaGen binaural beats script
  # --enable-demuxer=scc         #    Scenarist Closed Captions
  # --enable-demuxer=sdp         #    SDP
  # --enable-demuxer=sdr2         #   SDR2
  # --enable-demuxer=sds         #    MIDI Sample Dump Standard
  # --enable-demuxer=sdx         #    Sample Dump eXchange
  # --enable-demuxer=ser         #    SER (Simple uncompressed video format for astronomical capturing)
  # --enable-demuxer=sga         #    Digital Pictures SGA
  # --enable-demuxer=sgi_pipe        #piped sgi sequence
  # --enable-demuxer=shn         #    raw Shorten
  # --enable-demuxer=siff         #   Beam Software SIFF
  # --enable-demuxer=simbiosis_imx   #Simbiosis Interactive IMX
  # --enable-demuxer=sln         #    Asterisk raw pcm
  # --enable-demuxer=smjpeg         # Loki SDL MJPEG
  # --enable-demuxer=smk         #    Smacker
  # --enable-demuxer=smush         #  LucasArts Smush
  # --enable-demuxer=sndio         #  sndio audio capture
  # --enable-demuxer=sol         #    Sierra SOL
  # --enable-demuxer=sox         #    SoX native
  # --enable-demuxer=spdif         #  IEC 61937 (compressed data in S/PDIF)
  # --enable-demuxer=srt         #    SubRip subtitle
  # --enable-demuxer=stl         #    Spruce subtitle format
  # --enable-demuxer=subviewer       #SubViewer subtitle format
  # --enable-demuxer=subviewer1      #SubViewer v1 subtitle format
  # --enable-demuxer=sunrast_pipe    #piped sunrast sequence
  # --enable-demuxer=sup         #    raw HDMV Presentation Graphic Stream subtitles
  # --enable-demuxer=svag         #   Konami PS2 SVAG
  # --enable-demuxer=svg_pipe        #piped svg sequence
  # --enable-demuxer=svs         #    Square SVS
  # --enable-demuxer=swf         #    SWF (ShockWave Flash)
  # --enable-demuxer=tak         #    raw TAK
  # --enable-demuxer=tedcaptions     #TED Talks captions
  # --enable-demuxer=thp         #    THP
  # --enable-demuxer=tiertexseq      #Tiertex Limited SEQ
  # --enable-demuxer=tiff_pipe       #piped tiff sequence
  # --enable-demuxer=tmv         #    8088flex TMV
  # --enable-demuxer=truehd         # raw TrueHD
  # --enable-demuxer=tta         #    TTA (True Audio)
  # --enable-demuxer=tty         #    Tele-typewriter
  # --enable-demuxer=txd         #    Renderware TeXture Dictionary
  # --enable-demuxer=ty         #     TiVo TY Stream
  # --enable-demuxer=u16be         #  PCM unsigned 16-bit big-endian
  # --enable-demuxer=u16le         #  PCM unsigned 16-bit little-endian
  # --enable-demuxer=u24be         #  PCM unsigned 24-bit big-endian
  # --enable-demuxer=u24le         #  PCM unsigned 24-bit little-endian
  # --enable-demuxer=u32be         #  PCM unsigned 32-bit big-endian
  # --enable-demuxer=u32le         #  PCM unsigned 32-bit little-endian
  # --enable-demuxer=u8         #     PCM unsigned 8-bit
  # --enable-demuxer=v210         #   Uncompressed 4:2:2 10-bit
  # --enable-demuxer=v210x         #  Uncompressed 4:2:2 10-bit
  # --enable-demuxer=vag         #    Sony PS2 VAG
  # --enable-demuxer=vc1         #    raw VC-1
  # --enable-demuxer=vc1test         #VC-1 test bitstream
  # --enable-demuxer=vidc         #   PCM Archimedes VIDC
  # --enable-demuxer=video4linux2,v4l2 #Video4Linux2 device grab
  # --enable-demuxer=vividas         #Vividas VIV
  # --enable-demuxer=vivo         #   Vivo
  # --enable-demuxer=vmd         #    Sierra VMD
  # --enable-demuxer=vobsub         # VobSub subtitle format
  # --enable-demuxer=voc         #    Creative Voice
  # --enable-demuxer=vpk         #    Sony PS2 VPK
  # --enable-demuxer=vplayer         #VPlayer subtitles
  # --enable-demuxer=vqf         #    Nippon Telegraph and Telephone Corporation (NTT) TwinVQ
  # --enable-demuxer=w64         #    Sony Wave64
  # --enable-demuxer=wav         #    WAV / WAVE (Waveform Audio)
  # --enable-demuxer=wc3movie        #Wing Commander III movie
  # --enable-demuxer=webm_dash_manifest #WebM DASH Manifest
  # --enable-demuxer=webp_pipe       #piped webp sequence
  # --enable-demuxer=webvtt         # WebVTT subtitle
  # --enable-demuxer=wsaud         #  Westwood Studios audio
  # --enable-demuxer=wsd         #    Wideband Single-bit Data (WSD)
  # --enable-demuxer=wsvqa         #  Westwood Studios VQA
  # --enable-demuxer=wtv         #    Windows Television (WTV)
  # --enable-demuxer=wv         #     WavPack
  # --enable-demuxer=wve         #    Psion 3 audio
  # --enable-demuxer=x11grab         #X11 screen capture, using XCB
  # --enable-demuxer=xa         #     Maxis XA
  # --enable-demuxer=xbin         #   eXtended BINary text (XBIN)
  # --enable-demuxer=xbm_pipe        #piped xbm sequence
  # --enable-demuxer=xmv         #    Microsoft XMV
  # --enable-demuxer=xpm_pipe        #piped xpm sequence
  # --enable-demuxer=xvag         #   Sony PS3 XVAG
  # --enable-demuxer=xwd_pipe        #piped xwd sequence
  # --enable-demuxer=xwma         #   Microsoft xWMA
  # --enable-demuxer=yop         #    Psygnosis YOP
  # --enable-demuxer=yuv4mpegpipe    #YUV4MPEG pipe
  #################################################################
  --disable-videotoolbox
  --disable-audiotoolbox
  --disable-network
  --disable-zlib
  --disable-bzlib
  --disable-iconv
  --disable-bsfs
  --disable-hwaccels
  --disable-nvenc
  --disable-parsers
  --disable-indevs
  --disable-outdevs

  --disable-swscale             # Disable video scaling library
  --disable-avdevice            # Disable AV device handling
  --disable-postproc            # Disable post-processing
  --disable-network             # Disable networking functionality
  --disable-iconv               # Disable internationalization
 
  --disable-encoder=libx264
  --disable-encoder=libx265
  --disable-encoder=vp8
  --disable-encoder=vp9
  --disable-decoder=h264
  --disable-decoder=hevc
  --disable-decoder=vp8
  --disable-decoder=vp9
  --disable-filter=scale
  --disable-filter=crop
  --disable-filter=overlay
  --disable-muxer=mp4
  --disable-demuxer=mp4
  
  # assign toolchains and extra flags
  --nm=emnm
  --ar=emar
  --ranlib=emranlib
  --cc=emcc
  --cxx=em++
  --objcc=emcc
  --dep-cc=emcc
  --extra-cflags="$CFLAGS"
  --extra-cxxflags="$CXXFLAGS"

  # disable thread when FFMPEG_ST is NOT defined
  ${FFMPEG_ST:+ --disable-pthreads --disable-w32threads --disable-os2threads}
)

emconfigure ./configure "${CONF_FLAGS[@]}" $@
emmake make -j
