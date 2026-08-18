#!/bin/bash

# List of sites/services to monitor (edit these to your own)
declare -A TARGETS=(
  ["Portfolio Website"]="https://github.com"
  ["Google"]="https://google.com"
  ["My API"]="https://api.github.com"
)

RESULTS_FILE="status_log.csv"
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")

# Create CSV header if file doesn't exist
if [ ! -f "$RESULTS_FILE" ]; then
  echo "timestamp,service,status,response_time_ms" > "$RESULTS_FILE"
fi

OVERALL_STATUS="UP"

for NAME in "${!TARGETS[@]}"; do
  URL="${TARGETS[$NAME]}"

  START=$(date +%s%3N)
  HTTP_CODE=$(curl -o /dev/null -s -w "%{http_code}" --max-time 10 "$URL")
  END=$(date +%s%3N)
  RESPONSE_TIME=$((END - START))

  if [ "$HTTP_CODE" -ge 200 ] && [ "$HTTP_CODE" -lt 400 ]; then
    STATUS="UP"
  else
    STATUS="DOWN"
    OVERALL_STATUS="DOWN"
  fi

  echo "$TIMESTAMP,$NAME,$STATUS,$RESPONSE_TIME" >> "$RESULTS_FILE"
  echo "$NAME: $STATUS ($RESPONSE_TIME ms)"
done

# Save overall status for badge generation
echo "$OVERALL_STATUS" > current_status.txt
