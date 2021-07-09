from django.urls import path
from . import views

urlpatterns = [
   path('article', views.index),
   path('legislation', views.index_legislation),
   path('article/', views.getArticle, name = "getArticle"),
   path('legislation/', views.getLegislation, name = "getLegislation"),
   path('', views.getSearchingResult, name = "getSearchingResult"),
]
