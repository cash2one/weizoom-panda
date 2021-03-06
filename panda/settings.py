# -*- coding: utf-8 -*-
# Django settings for web project.

import os
import logging

SERVICE_NAME = "panda"

DEBUG = True

IS_UNDER_CODE_GENERATION = False

MODE = 'develop'

ADMINS = (
    # ('Your Name', 'your_email@example.com'),
)

MANAGERS = ADMINS

PROJECT_HOME = os.path.dirname(os.path.abspath(__file__))
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

DATABASES = {
    'default': {
        # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
        'ENGINE': 'django.db.backends.mysql',
        # Or path to database file if using sqlite3.
        'NAME': 'panda',
        'USER': 'panda',                      # Not used with sqlite3.
        'PASSWORD': 'weizoom',                  # Not used with sqlite3.
        # Set to empty string for localhost. Not used with sqlite3.
        'HOST': '127.0.0.1'
    }
}


# Local time zone for this installation. Choices can be found here:
# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
# although not all choices may be available on all operating systems.s
# In a Windows environment this must be set to your system time zone.
TIME_ZONE = 'Asia/Shanghai'

# Language code for this installation. All choices can be found here:
# http://www.i18nguy.com/unicode/language-identifiers.html
LANGUAGE_CODE = 'zh-cn'

SITE_ID = 1

# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = True

# If you set this to False, Django will not format dates, numbers and
# calendars according to the current locale.
USE_L10N = True

# If you set this to False, Django will not use timezone-aware datetimes.
USE_TZ = False

# Absolute filesystem path to the directory that will hold user-uploaded files.
# Example: "/home/media/media.lawrence.com/media/"
MEDIA_ROOT = ''

# URL that handles the media served from MEDIA_ROOT. Make sure to use a
# trailing slash.
# Examples: "http://media.lawrence.com/media/", "http://example.com/media/"
MEDIA_URL = ''

# Absolute path to the directory static files should be collected to.
# Don't put anything in this directory yourself; store your static files
# in apps' "static/" subdirectories and in STATICFILES_DIRS.
# Example: "/home/media/media.lawrence.com/static/"
STATIC_ROOT = os.path.join(BASE_DIR, 'deploy_static')

# URL prefix for static files.
# Example: "http://media.lawrence.com/static/"
STATIC_URL = '/static/'

DEFAULT_INDEX_TABLESPACE = ''

# Additional locations of static files
STATICFILES_DIRS = (
    # Put strings here, like "/home/html/static" or "C:/www/django/static".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
    './static/',
)

# List of finder classes that know how to find static files in
# various locations.
STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
    #    'django.contrib.staticfiles.finders.DefaultStorageFinder',
)

# Make this unique, and don't share it with anybody.
SECRET_KEY = '2m#oe@^8f96q&amp;ezyppacqbh%&amp;p8c15^6^98!5xl4np_ig7v7%e'

# List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = [
    'django.template.loaders.filesystem.Loader',
    'django.template.loaders.app_directories.Loader',
    #     'django.template.loaders.eggs.Loader',
]

MIDDLEWARE_CLASSES = [
    'core.resource_middleware.RestfulUrlMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    # 'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',

    # profiling的中间件
    #'core.profiling_middleware.ProfileMiddleware',

    'django.contrib.messages.middleware.MessageMiddleware',
    # Uncomment the next line for simple clickjacking protection:
    # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
]


ROOT_URLCONF = 'panda.urls'

# Python dotted path to the WSGI application used by Django's runserver.
WSGI_APPLICATION = 'panda.wsgi.application'

TEMPLATE_CONTEXT_PROCESSORS = [
    'django.contrib.auth.context_processors.auth',
    'django.core.context_processors.request',
    'django.contrib.messages.context_processors.messages',

    'core.context_processors.top_navs',
    'core.context_processors.webpack_bundle_js'
]

TEMPLATE_DIRS = [
    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
    '%s/templates' % PROJECT_HOME,
    './templates',
    '../templates'
]


INSTALLED_APPS = [
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    'resource',
    'account',
    'outline',
    

    'order',
    'product',
    'fans',
    'reconcile',
    'manager',
    'customer',
    'product_catalog',
    'product_limit_zone',
    'self_shop',
    'freight_service',
    'business',
    'station_message',
    'label',
    'postage_config',
    # Uncomment the next line to enable the admin:
    'django.contrib.admin',
    # Uncomment the next line to enable admin documentation:
    # 'django.contrib.admindocs',
    # 'django_behave',
]

# Celery任务
INSTALLED_TASKS = [
    'services.panda_send_sync_product_ding_talk_service.tasks.send_sync_product_ding_talk'
]

# A sample logging configuration. The only tangible logging
# performed by this configuration is to send an email to
# the site admins on every HTTP 500 error when DEBUG=False.
# See http://docs.djangoproject.com/en/dev/topics/logging for
# more details on how to customize your logging configuration.
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'formatters': {
        'simple': {
            'format': '%(levelname)s %(message)s'
        }

    },
    'handlers': {
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        },
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
            'formatter': 'simple',
        }
    },
    'loggers': {
        'django.request': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': True,
        },
        'console': {
            'handlers': ['console'],
            'level': 'DEBUG'
        }
    }
}


MAIL_NOTIFY_USERNAME = u'noreply@notice.weizoom.com'
MAIL_NOTIFY_PASSWORD = u'Weizoom2015'
MAIL_NOTIFY_ACCOUNT_SMTP = u'smtp.dm.aliyun.com'

SESSION_COOKIE_AGE = 5 * 24 * 3600  # one week
AUTH_PROFILE_MODULE = "account.UserProfile"
LOGIN_URL = '/account/login/'

if 'develop' == MODE:
    import logging
    logging.basicConfig(format='%(asctime)s %(levelname)s: %(message)s', level=logging.INFO)
    WEBPACK_BUNDLE_JS = 'http://127.0.0.1:4188/static/bundle.js'
    # WEBPACK_BUNDLE_JS = 'http://127.0.0.1:4180/static/build/bundle.js'
    ZEUS_HOST = 'http://api.zeus.com'
    PANDA_HOST = 'http://dev.panda.com'
    # AXE_HOST = 'http://192.168.0.105:8033' #FOR TEST
    AXE_HOST = 'http://axe.weapp.weizzz.com'
    DEBUG = True
    import MySQLdb

    conn = MySQLdb.connect(host='db.weapp.com', user='weapp', passwd='weizoom')
    conn.select_db('weapp')
    cursor = conn.cursor()
    cursor.execute("""select user_id from account_user_profile where webapp_type = 2""")
    result = cursor.fetchone()

    PRODUCT_POOL_OWNER_ID = result[0]
elif 'test' == MODE:
    WEBPACK_BUNDLE_JS = '/static/bundle.js'
    ALLOWED_HOSTS = ['*', ]
    #TODO 修改测试环境与线上环境zeus域名
    ZEUS_HOST = 'http://api.zeus.com'
    PANDA_HOST = 'http://panda.weapp.weizzz.com'
    AXE_HOST = 'http://axe.weapp.weizzz.com'
    DEBUG = True
    import MySQLdb

    conn = MySQLdb.connect(host='db.weapp.com', user='weapp', passwd='weizoom')
    conn.select_db('weapp')
    cursor = conn.cursor()
    cursor.execute("""select user_id from account_user_profile where webapp_type = 2""")
    result = cursor.fetchone()

    PRODUCT_POOL_OWNER_ID = result[0]
else:
    WEBPACK_BUNDLE_JS = '/static/bundle.js'
    ALLOWED_HOSTS = ['*', ]
    #TODO 修改测试环境与线上环境zeus域名
    ZEUS_HOST = 'http://api.zeus.com'
    PANDA_HOST = 'http://chaozhi.weizoom.com'
    AXE_HOST = 'http://axe.weizoom.com'
    DEBUG = False
    PRODUCT_POOL_OWNER_ID = 1127

UPLOAD_DIR = os.path.join(PROJECT_HOME, '../static', 'upload') #文件上传路径

if 'deploy' == MODE:
    MNS_ACCESS_KEY_ID = 'eJ8LylRwQERRqOot'
    MNS_ACCESS_KEY_SECRET = 'xxPrfGcUlnsL7IPweJRqVekHTCu6Ad'
    MNS_ENDPOINT = 'http://1615750970594173.mns.cn-hangzhou-internal.aliyuncs.com/'

    PRODUCT_TOPIC_NAME = 'customer-add-product'
    PRODUCT_MSG_NAME = 'customer_product_info'
    MNS_SECURITY_TOKEN = ''
elif 'develop' == MODE:
    MNS_ACCESS_KEY_ID = 'LTAI0GgFxEnSn3yP'
    MNS_ACCESS_KEY_SECRET = 'O3OWEDiBhqL4PDd5HCjxQyMM9QLo1G'
    MNS_ENDPOINT = 'http://1615750970594173.mns.cn-beijing.aliyuncs.com/'
    # MNS_ENDPOINT = 'http://1615750970594173.mns.cn-shanghai.aliyuncs.com/'
    MNS_SECURITY_TOKEN = ''
    PRODUCT_TOPIC_NAME = 'test-topic'
    PRODUCT_MSG_NAME = 'test-queue'
elif 'test' == MODE:
    MNS_ACCESS_KEY_ID = 'LTAI0GgFxEnSn3yP'
    MNS_ACCESS_KEY_SECRET = 'O3OWEDiBhqL4PDd5HCjxQyMM9QLo1G'
    MNS_ENDPOINT = 'http://1615750970594173.mns.cn-beijing.aliyuncs.com/'
    # MNS_ENDPOINT = 'http://1615750970594173.mns.cn-shanghai.aliyuncs.com/'
    MNS_SECURITY_TOKEN = ''
    PRODUCT_TOPIC_NAME = 'test-topic'
    PRODUCT_MSG_NAME = 'test-queue'
else:
    MNS_ACCESS_KEY_ID = 'eJ8LylRwQERRqOot'
    MNS_ACCESS_KEY_SECRET = 'xxPrfGcUlnsL7IPweJRqVekHTCu6Ad'
    MNS_ENDPOINT = 'http://1615750970594173.mns.cn-hangzhou.aliyuncs.com/'
    #MNS_ENDPOINT = 'http://1615750970594173.mns.cn-shanghai.aliyuncs.com/'
    MNS_SECURITY_TOKEN = ''
    PRODUCT_TOPIC_NAME = 'customer-add-product'
    PRODUCT_MSG_NAME = 'customer_product_info'

EAGLET_CLIENT_ZEUS_HOST = 'api.zeus.com'
ZEUS_SERVICE_NAME = 'zeus'
SYNC_ACCOUNTS = ['5', '3']

CESHI_USERNAMES = ['yunying','zhifuyy1','docyy1','yunying1','yunyingxuzihao','zhangsanxiang','tianfengmin','guozhenzhen']
