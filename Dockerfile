FROM public.ecr.aws/lambda/python:3.9

RUN yum install -y java-11-amazon-corretto-headless \
    && yum clean all \
    && rm -rf /var/cache/yum

COPY lambda_handler.py $LAMBDA_TASK_ROOT/

CMD [ "lambda_handler.handle" ]
