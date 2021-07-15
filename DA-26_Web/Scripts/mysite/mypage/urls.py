from django.urls import path
from . import views

urlpatterns = [
   path('article', views.index, name = "index"),
   path('legislation', views.index_legislation, name = "index_legislation"),
   path('article/', views.getArticle, name = "getArticle"),
   path('legislation/', views.getLegislation, name = "getLegislation"),
   path('searchArticle', views.getSearchingResult, name = "getSearchingResult"),
   path('searchLegislation', views.getSearchingLegislationResult, name = "getSearchingLegislationResult"),
   path('findArticle', views.getFilterResult, name = "getFilterResult"),
   path('findLegislation', views.getFilterLegislationResult, name = "getFilterLegislationResult"),
]
