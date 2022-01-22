curl --location --request POST 'http://localhost:8090/api/submarine/move' \
	--header 'Content-Type: application/json' \
	--data-raw '{"x":5, "y":5 }'

echo

curl --location --request POST 'http://localhost:8090/api/artifact/update' \
	--header 'Content-Type: application/json' \
	--data-raw '{"x":3, "y":0 }'

echo

curl --location --request POST 'http://localhost:8090/api/submarine/move' \
	--header 'Content-Type: application/json' \
	--data-raw '{"x":5, "y":5 }'

echo

curl --location --request POST 'http://localhost:8090/api/fish/add' \
	--header 'Content-Type: application/json' \
	--data-raw '{"x":7, "y":10 }'

echo

curl --location --request POST 'http://localhost:8090/api/fish/add' \
	--header 'Content-Type: application/json' \
	--data-raw '{"x":9, "y":12 }'

echo

curl --location --request POST 'http://localhost:8090/api/fish/add' \
	--header 'Content-Type: application/json' \
	--data-raw '{"x":12, "y":5 }'

echo

curl --location --request POST 'http://localhost:8090/api/fish/add' \
	--header 'Content-Type: application/json' \
	--data-raw '{"x":7, "y":6 }'

echo

curl --location --request POST 'http://localhost:8090/api/fish/add' \
	--header 'Content-Type: application/json' \
	--data-raw '{"x":17, "y":10 }'

echo

