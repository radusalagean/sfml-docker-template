#!/bin/bash

set -e

PROJECT_ROOT_DIR=$(dirname "${BASH_SOURCE[0]}")/../..
cd $PROJECT_ROOT_DIR

g++ --std=c++17 -g \
    -I/SFML/include \
    src/main.cpp src/platform/unix/linux/LinuxImpl.cpp \
    -L/SFML/build/lib \
    -lsfml-graphics-d -lsfml-window-d -lsfml-system-d -lsfml-audio-d \
    -Wl,-rpath,'$ORIGIN/../lib' \
    -o build/linux-x86_64-debug/bin/sfml-test

cd build/linux-x86_64-debug/bin

cat <<EOF > run.sh
#!/bin/bash

set -e

export LD_LIBRARY_PATH=../lib && ./sfml-test
EOF

chmod +x run.sh
