#!/bin/sh

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

set -e

sudo apt-get -y install musescore
sudo apt-get -y install python3-pip
sudo apt-get -y install timidity

sudo pip3 install pygame
sudo pip3 install music21

python3 -m music21.configure <<EOF
Yes
1
No
No
No
EOF


patch -N -f ~/.music21rc <<EOF || echo "${RED}WARNING: patching .music21rc failed${NC}"
--- a/.music21rc
+++ b/.music21rc
@@ -14,7 +14,7 @@
   <preference name="manualCoreCorpusPath" />
   <preference name="midiPath" />
   <preference name="musescoreDirectPNGPath" />
-  <preference name="musicxmlPath" />
+  <preference name="musicxmlPath" value="musescore" />
   <preference name="pdfPath" />
   <preference name="showFormat" value="musicxml" />
   <preference name="vectorPath" />
EOF

sudo patch -N -f /etc/pulse/default.pa <<EOF || echo "${RED}WARNING: patching /etc/pulse/default.pa failed${NC}"
--- a/default.pa
+++ b/default.pa
@@ -52,7 +52,7 @@
 
 ### Automatically load driver modules depending on the hardware available
 .ifexists module-udev-detect.so
-load-module module-udev-detect
+load-module module-udev-detect tsched=0
 .else
 ### Use the static hardware detection module (for systems that lack udev support)
 load-module module-detect
EOF

pulseaudio -k

echo "${GREEN}OK${NC}"
