from global_settings import INSTALLED_APPS

INSTALLED_APPS += (
    'djredcap',
)

MODELTREES = {
    'default': {
        'model': 'Record',
    }
}

SECRET_KEY = 'abc123'
