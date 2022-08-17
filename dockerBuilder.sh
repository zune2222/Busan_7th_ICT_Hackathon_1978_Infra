CONTAINER_LIST="nginx 1987-backend 1987-ai 1987-db"
DB_CONTAINER_NAME=1987-db
SQL_PATH=/etc/mysql/setDB/setDB.sql
DB_ROOT_ID=root
DB_ROOT_PASSWORD=qwer1234

for name in $CONTAINER_LIST
do
  echo "Stop Container '$name' "
  docker stop $name;
  echo "Remove Container '$name' "
  docker rm $name;
  echo "Remove Image '1987-infra_$name' "
  docker rmi 1987-infra_$name;
done

echo "Remove remain Yolov3-spp weights"
rm -R ./yolov3-spp.weights*
echo "DownLoad Yolov3-spp weights"
wget https://pjreddie.com/media/files/yolov3-spp.weights
echo "Move Yolov3-spp weights"
mv ./yolov3-spp.weights ./1987-ai/yolov3-spp.weights

echo "RUN Docker-compose"
docker-compose up -d

echo "Restart DB"
docker restart $DB_CONTAINER_NAME

echo "Set DB"
sleep 10
docker exec $DB_CONTAINER_NAME sh -c "mysql -u$DB_ROOT_ID < $SQL_PATH"

echo "Complete!"