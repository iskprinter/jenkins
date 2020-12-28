#!/bin/bash

set -euo pipefail

NAMESPACE='iskprinter'
RELEASE_NAME='jenkins'

other_args=()

for i in "$@"; do
    case $i in
        --admin-password=*)
        ADMIN_PASSWORD="${i#*=}"
        ;;
        --eve-app-client-id=*)
        EVE_APP_CLIENT_ID="${i#*=}"
        ;;
        --eve-app-client-secret=*)
        EVE_APP_CLIENT_SECRET="${i#*=}"
        ;;
        --dockerhub-token=*)
        DOCKERHUB_TOKEN="${i#*=}"
        ;;
        --dockerhub-username=*)
        DOCKERHUB_USERNAME="${i#*=}"
        ;;
        --kube-context=*)
        KUBE_CONTEXT="${i#*=}"
        ;;
        --github-token=*)
        GITHUB_TOKEN="${i#*=}"
        ;;
        --github-username=*)
        GITHUB_USERNAME="${i#*=}"
        ;;
        --host=*)
        HOST="${i#*=}"
        ;;
        --jenkins-uri-prefix=*)
        JENKINS_URI_PREFIX="${i#*=}"
        ;;
        --mongo-initdb-root-password=*)
        MONGO_INITDB_ROOT_PASSWORD="${i#*=}"
        ;;
        *)
        other_args+=("$i")
        ;;
    esac
    shift
done

protocol='https'
if [ "$HOST" = 'localhost' ]; then
    protocol='http'
fi

deploy_command='upgrade'
if ! helm status "$RELEASE_NAME" --kube-context "$KUBE_CONTEXT" -n "$NAMESPACE" &>/dev/null; then
    deploy_command='install'
    helm dependency update ./helm
fi

helm "$deploy_command" "$RELEASE_NAME" ./helm \
    --kube-context "$KUBE_CONTEXT" \
    -n "$NAMESPACE" \
    --set "dockerhubToken=${DOCKERHUB_TOKEN}" \
    --set "dockerhubUsername=${DOCKERHUB_USERNAME}" \
    --set "eveAppClientId=${EVE_APP_CLIENT_ID}" \
    --set "eveAppClientSecret=${EVE_APP_CLIENT_SECRET}" \
    --set "githubToken=${GITHUB_TOKEN}" \
    --set "githubUsername=${GITHUB_USERNAME}" \
    --set "host=${HOST}" \
    --set "jenkins.controller.adminPassword=${ADMIN_PASSWORD}" \
    --set "jenkins.controller.jenkinsUriPrefix=/${JENKINS_URI_PREFIX}" \
    --set "jenkins.controller.jenkinsUrl=${protocol}://${HOST}/${JENKINS_URI_PREFIX}" \
    --set "mongoInitdbRootPassword=${MONGO_INITDB_ROOT_PASSWORD}" \
    $(if [ ${#other_args[@]} -gt 0 ]; then echo "${other_args[@]}"; fi)
