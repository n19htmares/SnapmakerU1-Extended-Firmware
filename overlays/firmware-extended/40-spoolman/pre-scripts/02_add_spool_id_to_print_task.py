#!/usr/bin/env python3
import sys, os

f = os.environ.get('ROOTFS_DIR', '') + '/home/lava/klipper/klippy/extras/print_task_config.py'

with open(f, 'r') as fh:
    c = fh.read()

if "'filament_spool_id'" not in c:
    c = c.replace(
        "    'filament_sku': [0] * PHYSICAL_EXTRUDER_NUM,",
        "    'filament_sku': [0] * PHYSICAL_EXTRUDER_NUM,\n    'filament_spool_id': [0] * PHYSICAL_EXTRUDER_NUM,"
    )

if "['filament_spool_id'][channel]" not in c:
    c = c.replace(
        "self.print_task_config['filament_sku'][channel] = info['SKU']",
        "self.print_task_config['filament_sku'][channel] = info['SKU']\n        self.print_task_config['filament_spool_id'][channel] = info['SPOOL_ID']"
    )

if "filament_spool_id = gcmd.get" not in c:
    c = c.replace(
        "filament_color_rgba = gcmd.get('FILAMENT_COLOR_RGBA', None)",
        "filament_color_rgba = gcmd.get('FILAMENT_COLOR_RGBA', None)\n        filament_spool_id = gcmd.get('SPOOL_ID', None)"
    )

if "['filament_spool_id'][config_extruder]" not in c:
    c = c.replace(
        "self.print_task_config['filament_sku'][config_extruder] = 0",
        "self.print_task_config['filament_sku'][config_extruder] = 0\n            self.print_task_config['filament_spool_id'][config_extruder] = filament_spool_id"
    )

with open(f, 'w') as fh:
    fh.write(c)

print("print_task_config.py patched successfully")