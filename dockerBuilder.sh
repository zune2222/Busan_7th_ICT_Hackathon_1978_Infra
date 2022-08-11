CONTAINER_LIST=("nginx","1987_backend","1987_ai","1987_db")
DB_CONTAINER_NAME=1987_db
SQL_PATH=/etc/mysql/setDB/setDB.sql
DB_ROOT_ID=root
DB_ROOT_PASSWORD=qwer1234

for name in "${CONTAINER_LIST[*]}"
do
  echo "REMOVE '$name' "
  docker stop $name;
  docker rm $name;
  docker rmi $name;
done

echo "RUN Docker-compose"
docker-compose up -d

echo "Set DB"
docker exec $DB_CONTAINER_NAME sh -c "mysql -u$DB_ROOT_ID -p$DB_ROOT_PASSWORD < $SQL_PATH"

echo "Complete!"