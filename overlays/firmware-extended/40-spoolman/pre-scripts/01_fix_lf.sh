#!/usr/bin/env bash
set -eo pipefail
dos2unix "$ROOTFS_DIR/home/lava/klipper/klippy/extras/filament_protocol.py"
dos2unix "$ROOTFS_DIR/home/lava/moonraker/moonraker/components/spoolman.py"
dos2unix "$ROOTFS_DIR/home/lava/klipper/klippy/extras/print_task_config.py"