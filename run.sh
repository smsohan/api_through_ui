set +e
docker stop api_through_ui
docker rm api_through_ui
set -e
docker run -p 80:80 --name api_through_ui -d --link mongodb:mongodb smsohan/api_through_ui