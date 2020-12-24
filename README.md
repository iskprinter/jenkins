# jenkins

CI/CD for all IskPrinter components

## Jenkins setup

1. Create an oauth token on GitHub so that Jenkins can connect to the repo.

1. Install the ingress resource and Jenkins to the cluster via helm.
    ```
    helm dependency update ./helm
    helm install jenkins ./helm \
        --kube-context '<context>' \
        -n iskprinter \
        --set githubToken='<github-token>' \
        --set host='<host>' \
        --set jenkins.controller.adminPassword='<admin-password>' \
        --set jenkins.controller.jenkinsUriPrefix='<jenkins-uri-prefix>' \
        --set jenkins.controller.jenkinsUrl='<jenkins-url>'
    ```
    Example values for local deployment:
    * host='localhost'
    * jenkins.controller.jenkinsUriPrefix='/jenkins'
    * jenkins.controller.jenkinsUrl='http://localhost/jenkins'

    Example values for cloud deployment:
    * host='iskprinter.com'
    * jenkins.controller.jenkinsUriPrefix='/jenkins'
    * jenkins.controller.jenkinsUrl='https://iskprinter.com/jenkins'
