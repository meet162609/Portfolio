from django.urls import path
from . import views

urlpatterns = [
    path('', views.homepage, name='home'),  # ← use 'homepage' not 'home'
]
