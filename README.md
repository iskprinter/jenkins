# iskprinter/jenkins

CI/CD for all IskPrinter components

## Jenkins setup

1. Create an oauth token on GitHub so that Jenkins can connect to the repo.

1. Install the ingress resource and Jenkins to the cluster via helm.
    ```
    ./deploy.sh \
        --kube-context=<kube-context> \
        --admin-password=<admin-password> \
        --dockerhub-token=<dockerhub-token> \
        --dockerhub-username=<dockerhub-username> \
        --eve-app-client-id=<eve-app-client-id> \
        --eve-app-client-secret=<eve-app-client-secret> \
        --github-token=<github-token> \
        --github-username=<github-username> \
        --host=<host> \
        --jenkins-uri-prefix=<jenkins-uri-prefix> \
        --mongo-initdb-root-password=<mongo-initdb-root-password>
    ```
    Example values for local deployment:
    * `--kube-context='docker-desktop'`
    * `--admin-password='some-password'`
    * `--eve-app-client-id='some-id'`
    * `--eve-app-client-secret='some-secret'`
    * `--dockerhub-token='some-token'`
    * `--dockerhub-username='cameronhudson8'`
    * `--github-token='some-token'`
    * `--github-username='CameronHudson8'`
    * `--host='localhost'`
    * `--jenkins-uri-prefix='jenkins'`
    * `--mongo-initdb-root-password='some-password'`

    Example values for production deployment:`
    * `--kube-context='gcp-cameronhudson8'`
    * `--admin-password='some-password'`
    * `--eve-app-client-id='some-id'`
    * `--eve-app-client-secret='some-secret'`
    * `--dockerhub-token='some-token'`
    * `--dockerhub-username='cameronhudson8'`
    * `--github-token='some-token'`
    * `--github-username='CameronHudson8'`
    * `--host='iskprinter.com'`
    * `--jenkins-uri-prefix='jenkins'`
    * `--mongo-initdb-root-password='some-password'`
