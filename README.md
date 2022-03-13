# PyJava Lambda Runtime

For those who need to have both Python's and Java's binaries available at the same lambda runtime.


## Installation

### Requirements

- [Docker](https://www.docker.com/)
- [AWS CLI](https://aws.amazon.com/cli/)
- [AWS ECR](https://aws.amazon.com/ecr/)  

**Disclaimer**: this is not a tutorial about how to create or configure a lambda at AWS, for now on I'm assuming
you are confortable with the specific lambda's artifacts necessary run a lambda.

Install through the `deploy.sh` script:

```
$ bash < $(curl -L https://raw.githubusercontent.com/EduardoThums/pyjava-lambda-runtime/main/deploy.sh) \
    image-name \
    reporitory-uri/image-name \
    function-name \
    role-arn
```

Assert that it worked:

```
$ bash < $(curl -L https://raw.githubusercontent.com/EduardoThums/pyjava-lambda-runtime/main/assert.sh) \
    function-name
```


## Contributing

Feel free to fork it, and if you think your changes can benefict others too, open a PR.


To test the built image locally, create a docker container and use `curl` to make a POST request:

```
$ docker container run --rm -p 9000:8080 myfuncion:latest
```

```
$ curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'
```
