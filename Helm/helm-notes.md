
Helm:
---------------------------------

helm connected using the CLI mode. 

helm is the command to connect with the helm charts. 

When a chart is applied to the cluster a release is created for that. 

A release is single instaltion of an application. with in each release we can have multiple revisions. each revision is like a snapshot of an application. what ever the change made to the charts there will be one more revision created. changes like replicas, upgrades, etc. 

helm chart in a public reposistory.

helm save the data of revisions and release as a metadata available in the k8s cluster in secrets


Helm Charts:
--------------------------
after downloading the required helm charts from the repository, we can modify the requirements according to the need we have.

this is called templating .

alwasy need to do si to change the values of the values.yml

this is the settings file for the charts to deploy.


when ever a chart is applied a release is created. 

$ helm install [release-name] [chartname]



$ helm install my-site bitnami/wordpress

artifacthub.io --> has all the repo listed here.

$ helm install hello-world

helm charts
-------------
values.yaml
chart.yaml


$ helm --help
$ helm repo --help
$ helm repo update --help

$ helm search wordpress
$ helm search hub wordpress

$ helm repo add bitnami https://charts.bitnami.com/bitnami 
$ helm search repo wordpress 
$ heml repo list

$ helm install my-release bitnami/wordpress
$ helm install --values custom-values.yml my-release bitnami/wordpress
$ helm list

$ kubectl get svc --namespace default -w my-release-wordpress

$ helm uninstall my-release

$ helm pull bitnami/wordpress
$ helm pull --untar bitnami/wordpress
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

