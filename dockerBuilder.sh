CONTAINER_LIST="nginx 1987-backend 1987-ai 1987-db"

for name in $CONTAINER_LIST
do
  echo "REMOVE '$name' "
  docker stop $name;
  docker rm $name;
  docker rmi 1987-infra_$name;
done

echo "Download Yolov3-spp weights"
rm -R ./yolov3-spp.weights*
wget https://pjreddie.com/media/files/yolov3-spp.weights
mv ./yolov3-spp.weights ./1987-ai/yolov3-spp.weights

echo "RUN Docker-compose"
docker-compose up -d

echo "Complete!"