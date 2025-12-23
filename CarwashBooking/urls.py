from django.urls import path
from . import views

urlpatterns = [
    # Authentications
    path('', views.homepage, name='home'),
    path('register/', views.register_user, name='register_user'),
    path('login/', views.login_user, name='login_user'),
    path('logout/', views.logout_user, name='logout_user'),

    # Dashboards
    path('admin_dashboard/', views.admin_dashboard, name='admin_dashboard'),
    path('washer_dashboard/', views.washer_dashboard, name='washer_dashboard'),
    path('customer_dashboard/', views.customer_dashboard, name='customer_dashboard'),

    # Washer profile
    path('edit_profile/<int:user_id>/', views.edit_profile, name='edit_profile'),
    path('delete_profile/<int:user_id>/', views.delete_profile, name='delete_profile'),

    # Washer Company details
    path('add_company_details/', views.add_company_details, name='add_company_details'),
    path('edit_company_details/<int:id>/', views.edit_company_details, name='edit_company_details'),
    path('delete_company_details/<int:id>/', views.delete_company_details, name='delete_company_details'),
    path('washer_feedbacks/', views.washer_feedbacks, name='washer_feedbacks'),


    # Booking cost details
    path('add_booking_details/', views.add_booking_details, name='add_booking_details'),
    path('edit-booking-details/<int:id>/', views.edit_booking_details, name='edit_booking_details'),
    path('delete_booking_details/<int:id>/', views.delete_booking_details, name='delete_booking_details'),

    # Customer profile
    path('edit_customer_profile/<int:user_id>/', views.edit_customer_profile, name='edit_customer_profile'),
    path('update_customer_image/<int:user_id>/', views.update_customer_image, name='update_customer_image'),
    # Displaying washer profile
    path('washer/<int:washer_id>/', views.washer_public_profile, name='washer_public_profile'),
        
    # carwash booking
    path('get_subtypes/<int:type_id>/', views.get_subtypes, name='get_subtypes'),
    path('create_booking/<int:washer_id>/', views.create_booking, name='create_booking'),
    path('bookings/', views.booking_list, name='booking_list'),
    path('edit_booking/<int:id>/', views.edit_booking, name='edit_booking'),
    path('delete_booking/<int:id>/', views.delete_booking, name='delete_booking'),
    path('check_subtype_cost/', views.check_subtype_cost, name='check_subtype_cost'),

    # to display bookings for washer
    path('washer/bookings/', views.washer_view_bookings, name='washer_view_bookings'),
    path('washer/bookings/accept/<int:id>/', views.accept_booking, name='accept_booking'),
    path('washer/bookings/complete/<int:id>/', views.complete_booking, name='complete_booking'),


    path('customer/<int:id>/bookings/', views.customer_bookings, name='customer_bookings'),
    path('portal-admin/dashboard/', views.admin_dashboard, name="admin_dashboard"),
    path('portal-admin/bookings/', views.admin_bookings_view, name="admin_bookings_view"),
    path('portal-admin/customers/', views.admin_customerlist_view, name="admin_customerlist_view"),
    path('portal-admin/washers/', views.admin_washerslist_view, name="admin_washerslist_view"),
    path("delete_washer/<int:user_id>/", views.delete_washer, name="delete_washer"),


    # Feeback
    path("submit_feedback/", views.submit_feedback, name="submit_feedback"),
    path("washer/feedbacks/", views.washer_feedbacks, name="washer_feedbacks"),
    path("dashboard/feedbacks/", views.admin_all_feedbacks, name="admin_all_feedbacks"),
    path("reject-booking/<int:booking_id>/", views.reject_booking, name="reject_booking"),



]
