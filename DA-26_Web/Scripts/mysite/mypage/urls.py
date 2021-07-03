from django.urls import path
from . import views

urlpatterns = [
   path('', views.index),
   path('article/', views.createArticle, name = 'createArticle'),
]
