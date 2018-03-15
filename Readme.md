# Prerequisites

You need a K8s Cluster. On SWITCHengines you can set this up with the playbook:
https://github.com/switch-ch/k8s-on-openstack

# The Docker image

In the `image` folder you find all the information to build the docker image
You need to push the image to a docker registry like:
https://gitlab.switch.ch/proto/docker-horizon/container_registry

The process looks like:
```
docker build -t cr.gitlab.switch.ch/proto/docker-horizon:latest .
docker login cr.gitlab.switch.ch
docker push cr.gitlab.switch.ch/proto/docker-horizon
```


# The K8s Deployment

In the folder `k8s` you find all the files to create the pods and services.

It is better to first create a namespace to deploy your application, for example engines-scloud-switch-ch

    kubectl namespace create engines-scloud-switch-ch

Lets make this the default namespace for the commands we are going to give later:

    kubectl config set-context --namespace=engines-scloud-switch-ch `kubectl config current-context`

Review the changes with:

    kubectl config get-contexts

Now you are ready to deploy.
The files are numbered in the order they should be executed.
Edit the variables on top of the file `k8s/00-create-secrets.sh` to create your secrets.
Use the yaml files to create k8s resources.

```
bash 00-create-secrets.sh
kubectl create -f 01-redis-master-service.yaml
kubectl create -f 02-redis-master-deployment.yaml
kubectl create -f 03-horizon-service.yaml
kubectl create -f 04-horizon-deployment.yaml
kubectl create -f 05-horizon-ingress.yaml
```
The order is important because the Horizon deployment uses the `${REDIS_MASTER_SERVICE_HOST}` env variable to connect horizon to redis.


