#!/bin/bash

set -euo pipefail

for i in "$@"; do
    case $i in
        --admin-password=*)
        ADMIN_PASSWORD="${i#*=}"
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
        --namespace=*)
        NAMESPACE="${i#*=}"
        ;;
        *)
            echo "Error: Unrecognized option '${i}'." >&2
            exit 1
        ;;
    esac
    shift
done

protocol='https'
if [ "$HOST" = 'localhost' ]; then
    protocol='http'
fi

deploy_command='upgrade'
if ! helm status jenkins --kube-context "$KUBE_CONTEXT" -n "$NAMESPACE" &>/dev/null; then
    deploy_command='install'
    helm dependency update ./helm
fi

helm "$deploy_command" jenkins ./helm \
    --kube-context "$KUBE_CONTEXT" \
    -n "$NAMESPACE" \
    --set "githubToken=${GITHUB_TOKEN}" \
    --set "githubUsername=${GITHUB_USERNAME}" \
    --set "host=${HOST}" \
    --set "jenkins.controller.adminPassword=${ADMIN_PASSWORD}" \
    --set "jenkins.controller.jenkinsUriPrefix=/${JENKINS_URI_PREFIX}" \
    --set "jenkins.controller.jenkinsUrl=${protocol}://${HOST}/${JENKINS_URI_PREFIX}"
