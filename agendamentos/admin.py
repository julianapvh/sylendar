from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import Agendamento, Equipamento, User
from .forms import UserRegistrationForm, UserCreationFormWithExtraFields


class CustomUserAdmin(UserAdmin):
    add_form = UserCreationFormWithExtraFields
    fieldsets = (
        (None, {"fields": ("username", "password")}),
        (
            "Informações pessoais",
            {"fields": ("first_name", "last_name", "email", "telefone")},
        ),
        (
            "Permissões",
            {
                "fields": (
                    "is_active",
                    "is_staff",
                    "is_superuser",
                    "groups",
                    "user_permissions",
                )
            },
        ),
        ("Datas importantes", {"fields": ("last_login", "date_joined")}),
    )
    add_fieldsets = (
        (
            None,
            {
                "classes": ("wide",),
                "fields": (
                    "username",
                    "password1",
                    "password2",
                    "first_name",
                    "last_name",
                    "email",
                    "telefone",
                    "is_active",
                    "is_staff",
                    "is_superuser",
                ),
            },
        ),
    )


# Registrar os modelos no painel de administração
admin.site.register(Equipamento)
admin.site.register(User, CustomUserAdmin)
