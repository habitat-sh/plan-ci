#!/bin/bash

if [ ! -z ${MACHINE_NAME} ] && [ ! -z ${MACHINE_EXPORT_AWS_ACCESS_KEY_ID} ] \
    && [ ! -z ${MACHINE_EXPORT_AWS_SECRET_ACCESS_KEY} ] &&  [ ! -z ${MACHINE_EXPORT_AWS_REGION} ] \
    && [ ! -z ${MACHINE_EXPORT_AWS_BUCKET} ]; then
    echo "Downloading pre existing docker-machine configuration..."
    (
      export AWS_ACCESS_KEY_ID=${MACHINE_EXPORT_AWS_ACCESS_KEY_ID}
      export AWS_SECRET_ACCESS_KEY=${MACHINE_EXPORT_AWS_SECRET_ACCESS_KEY}
      export AWS_DEFAULT_REGION=${MACHINE_EXPORT_AWS_REGION}
      aws --region ${MACHINE_EXPORT_AWS_REGION} s3 cp s3://${MACHINE_EXPORT_AWS_BUCKET}/${MACHINE_NAME}.zip ./
    ) || exit 1

    echo "Importing configuration..."
    machine-import ${MACHINE_NAME}.zip
    # The permission isn't set properly on import
    chmod 0600 /root/.docker/machine/machines/${MACHINE_NAME}/id_rsa

    echo "Machine ${MACHINE_NAME} imported!"

    echo "Deleting all existing containers..."
    eval $(docker-machine env --shell sh ${MACHINE_NAME})
    docker ps -a | grep -v CONTAINER | awk '{print $1}' | xargs docker rm -f

    echo "Pruning unused volumes..."
    docker volume prune -f
fi

if [ -d "./${GROUP_CONTEXT}" ]; then
    build_group=$(ls ${GROUP_CONTEXT})

    if [ -f "${PKG_CONTEXT}-tests/${PKG_CONTEXT}/tests/delmo.yml" ]; then

        if delmo --only-build-task -f "${PKG_CONTEXT}-tests/${PKG_CONTEXT}/tests/delmo.yml" -m "${MACHINE_NAME}"; then
            cat > notify_message/message <<EOF
    :party_habitat: Testing of pkg: *'${PKG_CONTEXT}'* succeeded for build group: *'${build_group}'*
EOF
            exit 0
        else
            cat > notify_message/message <<EOF
    :flames: Testing of pkg: *'${PKG_CONTEXT}'* failed for build group: *'${build_group}'*
EOF
            exit 1
        fi
    else
        warning="WARN: No tests found for ${PKG_CONTEXT}!!"
        echo "${warning}"
        cat > notify_message/message <<EOF
    :warning: Testing of *'${PKG_CONTEXT}'* completed for build_group: *'${build_group}'* but produced a warning

    "${warning}""

EOF
    fi
fi

