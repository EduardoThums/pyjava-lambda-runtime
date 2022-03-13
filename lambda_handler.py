import os
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def handle(event, lambda_context):
    logger.info('----- Python -----')
    logger.info(os.system('python --version'))

    logger.info('----- Java -----')
    logger.info(os.system('java --version 2>/tmp/out.txt'))
    logger.info(os.system('cat /tmp/out.txt'))
