from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import Agendamento, Equipamento, User
from .forms import UserRegistrationForm, UserCreationFormWithExtraFields
from django.conf import settings
from django.contrib import admin, messages
from django.contrib.admin.options import IS_POPUP_VAR
from django.contrib.admin.utils import unquote
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.forms import (
    AdminPasswordChangeForm,
    UserChangeForm,
    UserCreationForm,
)
from django.contrib.auth.models import Group, User
from django.core.exceptions import PermissionDenied
from django.db import router, transaction
from django.http import Http404, HttpResponseRedirect
from django.template.response import TemplateResponse
from django.urls import path, reverse
from django.utils.decorators import method_decorator
from django.utils.html import escape
from django.utils.translation import gettext
from django.utils.translation import gettext_lazy as _
from django.views.decorators.csrf import csrf_protect
from django.views.decorators.debug import sensitive_post_parameters

csrf_protect_m = method_decorator(csrf_protect)
sensitive_post_parameters_m = method_decorator(sensitive_post_parameters())


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
