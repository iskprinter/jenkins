# iskprinter/jenkins

CI/CD for all IskPrinter components

## Jenkins setup

1. Create an oauth token on GitHub so that Jenkins can connect to the repo.

1. Install the ingress resource and Jenkins to the cluster via helm.
    ```
    ./deploy.sh \
        --kube-context=<kube-context> \
        --namespace=<namespace> \
        --dockerhub-username=<dockerhub-username> \
        --dockerhub-token=<dockerhub-token> \
        --github-username=<github-username> \
        --github-token=<github-token> \
        --host=<host> \
        --jenkins-uri-prefix=<jenkins-uri-prefix> \
        --admin-password=<admin-password>
    ```
    Example values for local deployment:
    * `--kube-context='docker-desktop'`
    * `--namespace='iskprinter'`
    * `--dockerhub-username='cameronhudson8'`
    * `--dockerhub-token='some-token'`
    * `--github-username='CameronHudson8'`
    * `--github-token='some-token'`
    * `--host='localhost'`
    * `--jenkins-uri-prefix='jenkins'`
    * `--admin-password='some-password'`

    Example values for production deployment:`
    * `--kube-context='gcp-cameronhudson8'`
    * `--namespace='iskprinter'`
    * `--dockerhub-username='cameronhudson8'`
    * `--dockerhub-token='some-token'`
    * `--github-username='CameronHudson8'`
    * `--github-token='some-token'`
    * `--host='iskprinter.com'`
    * `--jenkins-uri-prefix='jenkins'`
    * `--admin-password='some-password'`
