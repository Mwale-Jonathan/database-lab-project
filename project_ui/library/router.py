class Router:
    def db_for_read(self, model, **hints):
        if model._meta.app_label == "library":
            return "library"
        return "default"

    def db_for_write(self, model, **hints):
        if model._meta.app_label == "library":
            return "library"
        return "default"
