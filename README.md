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
        --set jenkins.controller.jenkinsUrl='<jenkins-url>' \
        --set jenkins.controller.jenkinsUriPrefix='<jenkins-uri-prefix>' \
        --set githubToken='<github-token>' \
        --set host='iskprinter.com'
    ```
    Example values for local deployment:
    * jenkins.controller.jenkinsUrl='http://localhost/jenkins'
    * jenkins.controller.jenkinsUriPrefix='/jenkins'
    * host='localhost'

    Example values for cloud deployment:
    * jenkins.controller.jenkinsUrl='https://iskprinter.com/jenkins'
    * jenkins.controller.jenkinsUriPrefix='/jenkins'
    * host='iskprinter.com'
