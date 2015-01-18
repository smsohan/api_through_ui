set +e
docker stop api_through_ui
docker rm api_through_ui
set -e
docker run -p 80:80 --name api_through_ui -d --link mongodb:mongodb --env SECRET_KEY_BASE=$SECRET_KEY_BASE --env PRODUCTION_HOST="spyrest.com" smsohan/api_through_ui