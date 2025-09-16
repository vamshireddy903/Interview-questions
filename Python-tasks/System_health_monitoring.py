#!/usr/bin/env python3

import psutil
import logging

# ------------------------
# Thresholds
# ------------------------
CPU_THRESHOLD = 80
MEMORY_THRESHOLD = 80
DISK_USAGE = 80
PROCESS_THRESHOLD = 300

# ------------------------
# Logging info
# ------------------------
logging.basicConfig(
    filename="health_check.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)


def log_alert(message):
    """Log alerts to console and file"""
    print(message)
    logging.warning(message)


def check_system_health():
    """Check CPU, memory, disk, and processes"""

    cpu_usage = psutil.cpu_percent(interval=10)
    if cpu_usage > CPU_THRESHOLD:
        log_alert(f"High CPU usage detected: {cpu_usage}%")

    memory = psutil.virtual_memory()
    if memory.percent > MEMORY_THRESHOLD:
        log_alert(f"High Memory usage detected: {memory.percent}%")

    disk = psutil.disk_usage('/')
    if disk.percent > DISK_USAGE:
        log_alert(f"Low Disk space: {disk.percent}%")

    process_count = len(psutil.pids())
    if process_count > PROCESS_THRESHOLD:
        log_alert(f"High number of processes running: {process_count}")


if __name__ == "__main__":
    print("🔍 Running System Health Check...")
    check_system_health()
    print("✅ Health Check Finished.")
