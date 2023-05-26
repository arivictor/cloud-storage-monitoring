IFS=' ' read -ra ITEMS <<< "$_BUCKET_PATHS"

for ITEM in "$${ITEMS[@]}"; do

    subfolders=$(gsutil ls -d gs://$$ITEM/*/ | grep "/$")
    while IFS= read -r subfolder; do
    
        object_count=$(gsutil ls -r $$subfolder** | wc -l)
        echo "Path: $${subfolder}, Object Count: $${object_count}"

        if [[ "$$object_count" -gt "$_ALERT_THRESHOLD" ]]; then
            gcloud logging write --payload-type=json --severity="$_CLOUD_LOGGING_SEVERITY" "$_SERVICE_NAME"  "{\"message\": \"object_count_gt_threshold\", \"build_id\":\"$BUILD_ID\", \"threshold\": $_ALERT_THRESHOLD, \"subfolder_path\": \"$$subfolder\", \"object_count\": $$object_count}"
        fi

    done <<< "$$subfolders"
done