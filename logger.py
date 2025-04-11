import logging

for handler in logging.root.handlers:
    logging.root.removeHandler(handler)

logging.basicConfig(
    filename='gitstats.log',
    filemode='a',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

logger = logging.getLogger('gitstats')
