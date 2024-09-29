#!/bin/bash
cd /config && curl -s "https://get.sdkman.io" | bash
. /config/.sdkman/bin/sdkman-init.sh &&  sdk install java 21.0.3-tem
. /config/.sdkman/bin/sdkman-init.sh &&  sdk install maven
. /config/.sdkman/bin/sdkman-init.sh &&  sdk install gradle
