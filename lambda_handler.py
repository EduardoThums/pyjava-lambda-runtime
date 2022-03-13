import subprocess
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def handle(event, lambda_context):
    logger.info('----- Python -----')
    logger.info(run_command('python --version'))

    logger.info('----- Java -----')
    logger.info(run_command('java --version 2>1'))


def run_command(command):
    output = subprocess.check_output(
        command,
        stderr=subprocess.STDOUT,
        shell=True
    )

    return bytes(output).decode("unicode_escape")
