


#	For Cloud SQL configuration/management
#	Download the gcloud sql proxy
wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy

#	Make it runnable
chmod +x cloud_sql_proxy

#	Start the proxy
#	Method 1:  Using Cloud SDK authentication
#	./cloud_sql_proxy -instances=<INSTANCE_CONNECTION_NAME>=tcp:5432





#-----------------------------------------------------------------------
#--	BEGIN Change to Para's Dev environment
#-----------------------------------------------------------------------
#	My development environment
# ./cloud_sql_proxy -instances=para-dev:us-central1:crmgwdata=tcp:3306

#	Para's development environment
./cloud_sql_proxy -instances=atomic-venture-175700:us-central1:crmgwdata=tcp:4306
#-----------------------------------------------------------------------
#--	END Change to Para's Dev environment
#-----------------------------------------------------------------------





# 	Get Docker Images
docker pull galacticfog/kong
docker pull thajeztah/pgadmin4





#-----------------------------------------------------------------------
#--	BEGIN Change to Para's Dev environment
#-----------------------------------------------------------------------
# 	Create GC docker images
#	Tag local docker images
# docker tag docker.io/kong us.gcr.io/para-dev/kong:0.11Alpine
docker tag galacticfog/kong us.gcr.io/para-dev/gfkong:0.8
docker tag thajeztah/pgadmin4 us.gcr.io/para-dev/pgadmin:4.0


#	Push to GCloud
# gcloud docker -- push us.gcr.io/para-dev/kong:0.11Alpine
gcloud docker -- push us.gcr.io/para-dev/gfkong:0.8
gcloud docker -- push us.gcr.io/para-dev/pgadmin:4.0
#-----------------------------------------------------------------------
#--	END Change to Para's Dev environment
#-----------------------------------------------------------------------





#	Create GCloud deployment and service yaml and deploy with kubectl
kubectl create -f gfkong_crmgwdata.yaml
kubectl create -f pgadmin.yaml

#	Expose the services (external IP)
kubectl expose service crmgw --port=8000 --target-port=30000 --name=crmgw
kubectl expose service crmgw-admin --port=8001 --target-port=30001 --name=crmgw-admin






