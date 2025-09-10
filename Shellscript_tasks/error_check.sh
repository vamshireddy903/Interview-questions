LOGFILE="/var/log/syslog"

echo "========= Log Report from $LOGFILE ========="

# ERROR
Matched_error=$(grep -in "error" "$LOGFILE")
Count_error=$(echo "$Matched_error" | wc -l)
echo -e "\n---- ERROR Logs ----"
echo "$Matched_error"
echo "Total ERROR entries: $Count_error"
sleep 3

# WARNING
Matched_warning=$(grep -in "warning" "$LOGFILE")
Count_warning=$(echo "$Matched_warning" | wc -l)
echo -e "\n---- WARNING Logs ----"
echo "$Matched_warning"
echo "Total WARNING entries: $Count_warning"
sleep 3

# CRITICAL
Matched_critical=$(grep -in "critical" "$LOGFILE")
Count_critical=$(echo "$Matched_critical" | wc -l)
echo -e "\n---- CRITICAL Logs ----"
echo "$Matched_critical"
echo "Total CRITICAL entries: $Count_critical"

echo -e "\n========= End of Report ========="
