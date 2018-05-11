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

echo "${GREEN}OK${NC}"
