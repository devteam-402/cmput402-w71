from apiserver.settings.base import *

DEBUG = True
ALLOWED_HOSTS = ['*']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': os.environ['DEV_DB_NAME'],
        'USER': os.environ['DEV_DB_USER'],
        'PASSWORD': os.environ['DEV_DB_PASS'],
        'HOST': os.environ['DEV_DB_SERVICE'],
        'PORT': os.environ['DEV_DB_PORT']
    }
}