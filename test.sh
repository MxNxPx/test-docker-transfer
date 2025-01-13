        echo "Parsing images-list.json..."
        IMAGE_LIST=$(zarf tools yq -r '.components[].images[]' containers/zarf.yaml)
        MATRIX_JSON="["
        for IMAGE in $IMAGE_LIST; do
          SOURCE_REGISTRY="docker.io"  
          SOURCE_IMAGE="${IMAGE}"
          TARGET_REGISTRY="ttl.sh"  # Predict target registry
          TARGET_IMAGE="$(echo ${IMAGE} | sed "s|${SOURCE_REGISTRY}/|${TARGET_REGISTRY}/|")"
          MATRIX_JSON="$MATRIX_JSON{\"source_image\":\"$SOURCE_IMAGE\",\"target_image\":\"$TARGET_IMAGE\"},"
        done
        MATRIX_JSON="${MATRIX_JSON%,}]" # Remove trailing comma and close array
        echo "Matrix JSON: $MATRIX_JSON"
        #echo "matrix=$MATRIX_JSON" >> $GITHUB_OUTPUT

