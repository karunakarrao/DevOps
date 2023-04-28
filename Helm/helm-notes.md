
Helm: 
---------------------------------
The is the package manager for Kubernetes, Helm Charts help you define, install, and upgrade even the most complex Kubernetes application. helm connected using the CLI mode. `helm` is the command to connect with the helm charts. charts are collection of files/objects definitions that have the instruction required for your application to run. When a chart is applied to the cluster a release is created for that. 

A release is single instaltion of an application. with in each release we can have multiple revisions. each revision is like a snapshot of an application. what ever the change made to the charts there will be one more revision created. changes like replicas, upgrades, etc. 

Helm Charts:
----------------------------------
helm charts are the deployment file of a specific application like my-sql,nginx,ingress,mariadb and etc. this charts are available in Artifacthub.io where all the publishers will publish their charts, we can install thouse charts and use for our need for a public reposistory. helm save the data of revisions and release as a metadata, and save it in the k8s cluster in secrets. 

Helm Installtion:
-------------------------------------------------------------------------
Install helm use the below commands provided in the helm portal

        $ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
        $ chmod 700 get_helm.sh
        $ ./get_helm.sh

Helm Componenets:
-------------------------------------------------------------------------
Helm is a package management tool installed as a script, when you pull/install a helm chart it consists of a directory structure as shown in the below. there are few important files like values.yaml, chart.yaml, templates/, charts/ and etc.

        $ helm install my-wordpress bitnami/wordpress --version 16.0.1  --> it will deploy the helm chart on K8s platform
        $ helm pull bitnami/wordpress   --> it will pull a tar file on the local machine
        $ helm pull --untar bitnami/wordpress   --> it will untar the file also as shown below
        
example:
  |-> Hello-world-chart
    |-> templates/  --> templates directory
    |-> values.yaml
    |-> chart.yaml
    |-> License
    |-> ReadMe.md
    |-> Charts/ --> dependency charts.
    
Helm Charts lifecycle: (repos: Appscode, TrueCharts, Bitnami, Communityoperations)
-------------------------------------------------------------------------
For all the helm charts we have a hub know as Artifacthub.io 

after downloading the required helm charts from the repo, we can modify the charts according to the our application need.  always need to do is to change the values of the values.yml. this is called templating. this is the settings file for the charts to deploy.

    $ helm install wordpress  --> Revision:1
    $ helm upgrade wordpress  --> Revision:2
    $ helm rollback wordpress --> Revision: 3
    
    $ helm uninstall wordpress  --> it will uninstall the helm chart

when ever a chart is applied a release is created. 
    
    $ helm list --> to list the releases 
    $ helm history my-wordpress1    --> to see the revisions created for this release
    
example:
    $ helm install my-site1 bitnami/wordpress
    $ helm install my-second-site1 bitnami/wordpress

    $ helm install hello-world

helm charts
-------------
values.yaml --> used for variables reference in the actual k8s objects definition file. value templating
chart.yaml  --> used for chart information and versions and details. 

chart.yaml
-------------------------------------------------------------
```
apiVersion: v2
appVersion: 5.8.1
version: 12.1.27
name: wordpress
description: 
type: application
dependencies:
  - condition: 
```
-----------------------------------------------

A chart directory may have mutiple file in it. as shown below

example:
  |-> Hello-world-chart
    |-> templates/  --> templates directory
    |-> values.yaml
    |-> chart.yaml
    |-> License
    |-> ReadMe.md
    |-> Charts/ --> dependency charts.


All operation are run using helm cli. 

    $ helm --help
    $ helm repo --help
    $ helm repo update --help

    $ helm search wordpress
    $ helm search hub wordpress

    $ helm repo add bitnami https://charts.bitnami.com/bitnami 
    $ helm search repo wordpress 
    $ helm repo list
    $ helm repo update

    $ helm install my-release bitnami/wordpress
    $ helm install --values custom-values.yml my-release bitnami/wordpress --> replace values with customvalues
    $ helm list

    $ kubectl get svc --namespace default -w my-release-wordpress

    $ helm uninstall my-release

if you don't want to directly install the helm charts, we can pull the chart then modify the chart and install the chart. 

    $ helm pull bitnami/wordpress
    $ helm pull --untar bitnami/wordpress
    $ helm install my-release ./wordpress

    $ tar -zxvf wordpress.tar

    $ helm repo list
    $ helm repo remove hashicorp

helm upgrade:
--------------------------------
$ helm upgrade nginx-release bitnami/nginx

$ helm list --> to check the revision details.
$ helm history nginx-release --> to see the history 
$ helm rollback  nginx-release 1 --> to rollback to revision 1

$ helm upgrade dazzling-web bitnami/nginx --version 12 --> to rollback to the previous version
$ helm upgrade dazzling-web --> this will rollback to previous version

creating Helm chart from scrach 
-------------------------------
$ helm create hello-world-chart
$ 

Verify Helm charts:
-------------------------------
$ helm lint ./sample-chart --> to check the syntax errors
$ helm template ./sample-chart --> it will show the local yaml file replaced with actual values 
$ helm template ./sample-chart --debug --> to check the issue in the template
$ helm install hello-world ./sample-chart --dry-run --> this will present the k8s format errors
s



helm chart hooks are used to take the backup of the persistant volumes / db before proceeding for the upgrade activity.



export SERVICE_IP=$(kubectl get svc --namespace default my-release-wordpress --include "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}")
echo "WordPress URL: http://$SERVICE_IP/"
echo "WordPress Admin URL: http://$SERVICE_IP/admin"

echo Username: user
echo Password: $(kubectl get secret --namespace default my-release-wordpress -o jsonpath="{.data.wordpress-password}" | base64 -d)




there we modify the value.yml file which reflects the data. A simple task. The charge is applied to your customer, they release. Why the need for an additional? Why can't you just say? The. My site. I mean, what? And need the release. So why not just use this sort of like helping? Without. Simple reason why it needs more. So we can look. A second. Independent. Even though they're the same releases. Now this can be useful in a lot of scenarios. And another reason for what? Team. They're different. Website. Once they get something working correctly on the development side. The same way. Let those. Because. Very basic. What if we want to deploy? Ready for? Thousands of stocks and readily available in different home repositories. There are different providers who are hosting. Community operators. And you don't have to go to interview. All of these repositories now have. Single location.

### Q. Difference between Helm2 vs Helm3?
Tailer:     In helm2 there is a middle-men component known as "Tailer" which will communicate with K8S cluster. later it was removed in Helm3 due to security reasons and access issues with the K8s cluster. there are limits can be set using RBAC. 

3-way strategic merge patch:    in Helm 2 if a deployed application has been modified manually with out using the helm charts, then that is been not recorded as a version. where as in Helm3 there a check will use that live object commpared with current and old chart. this is how it will come to know the changes. 






