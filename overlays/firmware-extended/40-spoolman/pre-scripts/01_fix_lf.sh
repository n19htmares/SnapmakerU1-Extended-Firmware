#!/usr/bin/env bash
set -eo pipefail
dos2unix "$ROOTFS_DIR/home/lava/klipper/klippy/extras/filament_protocol.py"
dos2unix "$ROOTFS_DIR/home/lava/moonraker/moonraker/components/spoolman.py"
dos2unix "$ROOTFS_DIR/home/lava/klipper/klippy/extras/print_task_config.py"
F="$ROOTFS_DIR/home/lava/klipper/klippy/extras/print_task_config.py"
grep -q "filament_spool_id" "$F" || sed -i "s/    'filament_sku': \[0\] \* PHYSICAL_EXTRUDER_NUM,/    'filament_sku': [0] * PHYSICAL_EXTRUDER_NUM,\n    'filament_spool_id': [0] * PHYSICAL_EXTRUDER_NUM,/" "$F"
grep -q "\['filament_spool_id'\]\[channel\]" "$F" || sed -i "s/tmp_print_task_config\['filament_sku'\]\[channel\] = info\['SKU'\]/tmp_print_task_config['filament_sku'][channel] = info['SKU']\n            tmp_print_task_config['filament_spool_id'][channel] = info['SPOOL_ID']/" "$F"
grep -q "filament_spool_id = gcmd.get" "$F" || sed -i "s/filament_color_rgba = gcmd.get('FILAMENT_COLOR_RGBA', None)/filament_color_rgba = gcmd.get('FILAMENT_COLOR_RGBA', None)\n        filament_spool_id = gcmd.get('SPOOL_ID', None)/" "$F"
grep -q "\['filament_spool_id'\]\[config_extruder\]" "$F" || sed -i "s/tmp_print_task_config\['filament_sku'\]\[config_extruder\] = 0/tmp_print_task_config['filament_sku'][config_extruder] = 0\n            tmp_print_task_config['filament_spool_id'][config_extruder] = filament_spool_id/" "$F"
echo "print_task_config.py patched"