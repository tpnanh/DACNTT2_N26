from django.urls import path
from . import views

urlpatterns = [
   path('', views.index),
   path('article/', views.getArticle, name = 'getArticle'),
   path('legislation/', views.getLegislation, name = 'getLegislation'),
]
