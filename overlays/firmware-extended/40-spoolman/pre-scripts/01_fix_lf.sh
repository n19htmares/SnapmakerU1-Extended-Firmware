#!/usr/bin/env bash
set -eo pipefail
dos2unix "$ROOTFS_DIR/home/lava/klipper/klippy/extras/filament_protocol.py"
dos2unix "$ROOTFS_DIR/home/lava/moonraker/moonraker/components/spoolman.py"
dos2unix "$ROOTFS_DIR/home/lava/klipper/klippy/extras/print_task_config.py"
/usr/bin/python3 "$(dirname "$0")/02_add_spool_id_to_print_task.py"