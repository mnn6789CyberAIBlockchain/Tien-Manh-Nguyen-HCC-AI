import os
import csv
from datetime import datetime

LOG_FILE = "logs/security_log.csv"

def initialize_log():
    if not os.path.exists(LOG_FILE):
        with open(LOG_FILE, mode="w", newline="", encoding="utf-8") as file:
            writer = csv.writer(file)
            writer.writerow([
                "timestamp",
                "user_query",
                "intent",
                "status",
                "reason",
                "response_preview"
            ])

def log_event(user_query, intent, status, reason, response_preview):
    initialize_log()

    with open(LOG_FILE, mode="a", newline="", encoding="utf-8") as file:
        writer = csv.writer(file)
        writer.writerow([
            datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            user_query,
            intent,
            status,
            reason,
            response_preview[:150]
        ])