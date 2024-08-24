from django.apps import AppConfig

class CustomAccountsConfig(AppConfig):
    name = 'custom_accounts'

    def ready(self):
        import custom_accounts.signals  # Register the signals
