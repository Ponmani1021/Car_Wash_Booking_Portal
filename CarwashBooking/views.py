from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login, logout, update_session_auth_hash
from django.contrib.auth.models import User
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.http import JsonResponse
from .models import (
    Announcement, Profile, WasherCompany, BookingCostDetails,
    WasherProfile, CustomerProfile, VehicleType, VehicleSubType,
    Booking, Feedback
)


# ------------------- HOME -------------------
def homepage(request):
    announcements = Announcement.objects.all().order_by("-created_at")
    feedbacks = Feedback.objects.select_related("washer__user", "customer", "booking").order_by("-stars")[:6]
    return render(request, "home.html", {
        "announcements": announcements,
        "feedbacks": feedbacks,
    })


# ------------------- AUTHENTICATION -------------------

def register_user(request):
    if request.method == 'POST':
        full_name = request.POST.get('full_name', '').strip()
        email = request.POST.get('email', '').strip()
        username = request.POST.get('username', '').strip()
        password = request.POST.get('password', '')
        role = request.POST.get('role', 'customer')
        contact_number = request.POST.get('contact_number', '').strip()

        if not username or not password or not email:
            messages.error(request, "Username, email and password are required.")
            return redirect('/')

        if User.objects.filter(username=username).exists():
            messages.error(request, "Username already exists.")
            return redirect('/')
        if User.objects.filter(email=email).exists():
            messages.error(request, "Email already registered.")
            return redirect('/')

        user = User.objects.create_user(username=username, email=email, password=password)
        user.first_name = full_name
        user.save()

        Profile.objects.create(
            user=user,
            full_name=full_name,
            email=email,
            contact_number=contact_number,
            role=role,
        )

        # Optionally create role-specific profile objects
        if role == 'washer':
            WasherProfile.objects.get_or_create(user=user, defaults={
                'full_name': full_name,
                'contact_number': contact_number
            })
        elif role == 'customer':
            CustomerProfile.objects.get_or_create(user=user, defaults={
                'full_name': full_name,
                'email': email,
                'contact_number': contact_number
            })

        messages.success(request, "Registration successful! Please login.")
        return redirect('/')
    return redirect('/')


def login_user(request):
    if request.method == "POST":
        role = request.POST.get('role')
        username = request.POST.get('username')
        password = request.POST.get('password')

        # Admin fixed login (simple approach)
        if role == 'admin':
            if username == 'admin' and password == 'admin123':
                user, created = User.objects.get_or_create(username='admin')
                if created:
                    user.set_password('admin123')
                    user.save()
                    Profile.objects.create(user=user, full_name='Admin', email='', contact_number='', role='admin')
                login(request, user)
                messages.success(request, "Welcome, Admin!")
                return redirect('/admin_dashboard/')
            else:
                messages.error(request, "Invalid admin credentials.")
                return redirect('/')

        user = authenticate(request, username=username, password=password)
        if user:
            profile = Profile.objects.filter(user=user).first()
            if profile and profile.role == role:
                login(request, user)
                messages.success(request, f"Welcome, {user.first_name or user.username}!")
                if role == 'washer':
                    return redirect('/washer_dashboard/')
                elif role == 'customer':
                    return redirect('/customer_dashboard/')
                else:
                    return redirect('/')
            else:
                messages.error(request, "Selected role does not match this account.")
        else:
            messages.error(request, "Invalid username or password.")
        return redirect('/')
    return redirect('/')


def logout_user(request):
    logout(request)
    messages.info(request, "You have been logged out.")
    return redirect('/')


# ------------------- DASHBOARDS -------------------

@login_required
def admin_dashboard(request):
    total_washers = Profile.objects.filter(role='washer').count()
    total_customers = Profile.objects.filter(role='customer').count()
    return render(request, 'admin_dashboard.html', {
        'total_washers': total_washers,
        'total_customers': total_customers
    })


@login_required
def washer_dashboard(request):
    user = request.user
    user_profile = Profile.objects.filter(user=user).first()

    profile, created = WasherProfile.objects.get_or_create(
        user=user,
        defaults={
            'full_name': (user_profile.full_name if user_profile else user.username),
            'contact_number': (user_profile.contact_number if user_profile else None)
        }
    )

    company = WasherCompany.objects.filter(washer=user).first()
    # BookingCostDetails has created_at now
    prices  = BookingCostDetails.objects.filter(washer=request.user).order_by('-created_at')
    
    context = {
        'profile': profile,
        'company': company,
        'prices': prices,
        
    }
    return render(request, 'washer_dashboard.html', context)


@login_required
def customer_dashboard(request):
    user = request.user
    user_profile = Profile.objects.filter(user=user).first()

    profile, created = CustomerProfile.objects.get_or_create(
        user=user,
        defaults={
            'full_name': (user_profile.full_name if user_profile else user.username),
            'email': (user_profile.email if user_profile else user.email),
            'contact_number': (user_profile.contact_number if user_profile else None)
        }
    )

    washers = WasherCompany.objects.all()
    return render(request, 'customer_dashboard.html', {
        'profile': profile,
        'washers': washers,
    })


# ----------------- WASHER DASHBOARD: COMPANY -----------------

@login_required
def add_company_details(request):
    if request.method == "POST":
        company_name = request.POST.get('company_name')
        company_address = request.POST.get('company_address')
        company_timings = request.POST.get('company_timings')
        description = request.POST.get('description')
        company_image = request.FILES.get('company_image')

        if WasherCompany.objects.filter(washer=request.user).exists():
            messages.warning(request, "You already added your company details.")
            return redirect('washer_dashboard')

        WasherCompany.objects.create(
            washer=request.user,
            company_name=company_name,
            company_address=company_address,
            company_timings=company_timings,
            company_image=company_image,
            description=description
        )
        messages.success(request, "Company details added successfully!")
    return redirect('washer_dashboard')


@login_required
def edit_company_details(request, id):
    company = get_object_or_404(WasherCompany, id=id, washer=request.user)
    if request.method == "POST":
        company.company_name = request.POST.get('company_name')
        company.company_address = request.POST.get('company_address')
        company.company_timings = request.POST.get('company_timings')
        company.description = request.POST.get('description')

        if 'company_image' in request.FILES:
            company.company_image = request.FILES['company_image']

        company.save()
        messages.success(request, "Company details updated successfully!")
    return redirect('washer_dashboard')


@login_required
def delete_company_details(request, id):
    company = get_object_or_404(WasherCompany, id=id, washer=request.user)
    company.delete()
    messages.success(request, "Company details deleted successfully!")
    return redirect('washer_dashboard')


# ----------------- WASHER PROFILE -----------------

@login_required
def edit_profile(request, user_id):
    if request.method != 'POST':
        return redirect('washer_dashboard')

    if request.user.id != user_id:
        messages.error(request, "Unauthorized action.")
        return redirect('washer_dashboard')

    profile = get_object_or_404(WasherProfile, user=request.user)
    user = request.user

    full_name = request.POST.get('full_name')
    username = request.POST.get('username')
    email = request.POST.get('email')
    contact_number = request.POST.get('contact_number')
    password = request.POST.get('password')

    if User.objects.exclude(id=user.id).filter(username=username).exists():
        messages.error(request, "Username already taken.")
        return redirect('washer_dashboard')

    if User.objects.exclude(id=user.id).filter(email=email).exists():
        messages.error(request, "Email already registered.")
        return redirect('washer_dashboard')

    user.username = username or user.username
    user.email = email or user.email
    user.first_name = full_name or user.first_name
    if password:
        user.set_password(password)
    user.save()

    # Update profile model and Profile (Profile stores email too)
    profile.full_name = full_name or profile.full_name
    profile.contact_number = contact_number or profile.contact_number
    profile.save()

    # Keep email in both: update Profile model (if exists)
    profile_meta = Profile.objects.filter(user=user).first()
    if profile_meta:
        profile_meta.email = email or profile_meta.email
        profile_meta.full_name = full_name or profile_meta.full_name
        profile_meta.contact_number = contact_number or profile_meta.contact_number
        profile_meta.save()

    if password:
        update_session_auth_hash(request, user)

    messages.success(request, "Profile updated successfully!")
    return redirect('washer_dashboard')


@login_required
def delete_profile(request, user_id):
    if request.user.id != user_id:
        messages.error(request, "Unauthorized.")
        return redirect('washer_dashboard')
    try:
        user = request.user
        user.delete()
        messages.success(request, "Profile and account deleted.")
        return redirect('/')
    except Exception:
        messages.error(request, "Could not delete account.")
        return redirect('washer_dashboard')


# ---------------- WASHER DASHBOARD BOOKING COST DETAILS ----------------

@login_required
def add_booking_details(request):
    if request.method == 'POST':
        vehicle_type = request.POST.get('vehicle_type')
        subtype = request.POST.get('subtype') or ''
        cost = request.POST.get('cost') or 0

        BookingCostDetails.objects.create(
            washer=request.user,
            vehicle_type=vehicle_type,
            subtype=subtype,
            cost=cost,
        )
        messages.success(request, "Booking price added.")
    return redirect('washer_dashboard')


@login_required
def edit_booking_details(request, id):
    booking = get_object_or_404(BookingCostDetails, id=id, washer=request.user)
    if request.method == 'POST':
        booking.vehicle_type = request.POST.get('vehicle_type')
        booking.subtype = request.POST.get('subtype') or ''
        booking.cost = request.POST.get('cost') or booking.cost
        booking.save()
        messages.success(request, "Booking price updated.")
    return redirect('washer_dashboard')


@login_required
def delete_booking_details(request, id):
    booking = get_object_or_404(BookingCostDetails, id=id, washer=request.user)
    booking.delete()
    messages.success(request, "Price deleted.")
    return redirect('washer_dashboard')


# ---------------- CUSTOMER DASHBOARD ----------------

@login_required
def edit_customer_profile(request, user_id):
    if request.method != 'POST':
        return redirect('customer_dashboard')

    if request.user.id != user_id:
        messages.error(request, "Unauthorized action.")
        return redirect('customer_dashboard')

    profile = get_object_or_404(CustomerProfile, user=request.user)
    user = request.user

    if 'profile_image' in request.FILES:
        profile.profile_image = request.FILES['profile_image']

    full_name = request.POST.get('full_name')
    username = request.POST.get('username')
    email = request.POST.get('email')
    contact_number = request.POST.get('contact_number')
    password = request.POST.get('password')

    if User.objects.exclude(id=user.id).filter(username=username).exists():
        messages.error(request, "Username already taken.")
        return redirect('customer_dashboard')

    if User.objects.exclude(id=user.id).filter(email=email).exists():
        messages.error(request, "Email already registered.")
        return redirect('customer_dashboard')

    user.username = username or user.username
    user.email = email or user.email
    user.first_name = full_name or user.first_name
    if password:
        user.set_password(password)
    user.save()

    profile.full_name = full_name or profile.full_name
    profile.contact_number = contact_number or profile.contact_number
    profile.email = email or profile.email
    profile.save()

    profile_meta = Profile.objects.filter(user=user).first()
    if profile_meta:
        profile_meta.email = email or profile_meta.email
        profile_meta.full_name = full_name or profile_meta.full_name
        profile_meta.contact_number = contact_number or profile_meta.contact_number
        profile_meta.save()

    if password:
        update_session_auth_hash(request, user)

    messages.success(request, "Profile updated successfully!")
    return redirect('customer_dashboard')


@login_required
def update_customer_image(request, user_id):
    if request.method == "POST":
        profile = get_object_or_404(CustomerProfile, user=request.user)
        if 'profile_image' in request.FILES:
            profile.profile_image = request.FILES['profile_image']
            profile.save()
            messages.success(request, "Profile image updated!")
    return redirect('customer_dashboard')


def available_washers(request):
    # Prefetch booking prices through the washer user relation
    washers = WasherProfile.objects.select_related('user').prefetch_related('user__booking_prices')
    return render(request, 'customer/available_washers.html', {'washers': washers})


def washer_public_profile(request, washer_id):
    washer_user = get_object_or_404(User, id=washer_id)
    company = WasherCompany.objects.filter(washer=washer_user).first()
    bookings = BookingCostDetails.objects.filter(washer=washer_user)
    context = {
        'washer': washer_user,
        'company': company,
        'bookings': bookings,
    }
    return render(request, 'washer_public_profile.html', context)


@login_required
def get_subtypes(request):
    washer_id = request.GET.get("washer_id")
    vehicle_type = request.GET.get("vehicle_type")

    subtypes = BookingCostDetails.objects.filter(
        washer_id=washer_id,
        vehicle_type=vehicle_type
    ).values_list("subtype", flat=True).distinct()

    return JsonResponse({"subtypes": [s for s in subtypes if s]})


@login_required
def check_subtype_cost(request):
    washer_id = request.GET.get("washer_id")
    vehicle_type = request.GET.get("vehicle_type")
    subtype = request.GET.get("subtype")

    cost_obj = BookingCostDetails.objects.filter(
        washer_id=washer_id,
        vehicle_type=vehicle_type,
        subtype=subtype
    ).first()

    if not cost_obj:
        return JsonResponse({"success": False, "error": "Subtype price not available."})

    return JsonResponse({"success": True, "cost": float(cost_obj.cost)})


@login_required
def create_booking(request, washer_id):
    if request.method == 'POST':
        washer = get_object_or_404(User, id=washer_id)
        vehicle_type = request.POST.get('vehicle_type')
        subtype = request.POST.get('sub_type') or request.POST.get('subtype')
        pickup_drop = True if request.POST.get('pickup_drop') == "yes" else False
        date = request.POST.get('date') or None
        time = request.POST.get('time') or None
        address = request.POST.get('address')

        cost_details = BookingCostDetails.objects.filter(
            washer=washer,
            vehicle_type=vehicle_type,
            subtype=subtype
        ).first()

        if not cost_details:
            messages.error(request, "Unable to find cost for selected vehicle type.")
            return redirect('washer_public_profile', washer_id=washer.id)

        base_cost = cost_details.cost
        total_cost = base_cost + (100 if pickup_drop else 0)

        Booking.objects.create(
            customer=request.user,
            washer=washer,
            vehicle_type=vehicle_type,
            subtype=subtype,
            cost=base_cost,
            pickup_drop=pickup_drop,
            date=date,
            time=time,
            address=address,
            total_cost=total_cost,
        )

        messages.success(request, "Booking created successfully!")
        return redirect('booking_list')
    return redirect('booking_list')


@login_required
def booking_list(request):
    bookings = Booking.objects.filter(customer=request.user).select_related("washer").order_by('-created_at')
    return render(request, "booking_list.html", {"bookings": bookings})


@login_required
def edit_booking(request, id):
    booking = get_object_or_404(Booking, id=id, customer=request.user)
    if request.method == "POST":
        vehicle_type = request.POST.get('vehicle_type')
        subtype = request.POST.get('sub_type') or request.POST.get('subtype')
        pickup_drop = request.POST.get('pickup_drop') == 'yes'

        if not vehicle_type or not subtype:
            messages.error(request, "Please select both vehicle type and subtype.")
            return redirect('booking_list')

        cost_details = BookingCostDetails.objects.filter(
            washer=booking.washer,
            vehicle_type=vehicle_type,
            subtype=subtype
        ).first()

        if not cost_details:
            messages.error(request, "Selected vehicle type or subtype is not available.")
            return redirect('booking_list')

        base_cost = cost_details.cost
        total_cost = base_cost + (100 if pickup_drop else 0)

        booking.vehicle_type = vehicle_type
        booking.subtype = subtype
        booking.cost = base_cost
        booking.pickup_drop = pickup_drop
        booking.total_cost = total_cost
        booking.date = request.POST.get('date')
        booking.time = request.POST.get('time')
        booking.address = request.POST.get('address')
        booking.save()

        messages.success(request, "Booking updated successfully!")
        return redirect('booking_list')
    return redirect('booking_list')


@login_required
def delete_booking(request, id):
    booking = get_object_or_404(Booking, id=id, customer=request.user)
    booking.status = "cancelled"
    booking.save()
    messages.success(request, "Booking cancelled successfully.")
    return redirect('booking_list')


@login_required
def view_bookings(request):
    bookings = Booking.objects.filter(customer=request.user).order_by('-created_at')
    return render(request, 'bookings.html', {'bookings': bookings})


# ----------------- WASHER VIEWS: manage bookings -----------------

@login_required
def washer_view_bookings(request):
    bookings = Booking.objects.filter(washer=request.user).order_by('-created_at')
    return render(request, 'washer_bookings.html', {'bookings': bookings})


@login_required
def accept_booking(request, id):
    if request.method != 'POST':
        messages.error(request, "Invalid request method.")
        return redirect('washer_view_bookings')

    booking = get_object_or_404(Booking, id=id)

    if booking.washer != request.user:
        messages.error(request, "Unauthorized action.")
        return redirect('washer_view_bookings')

    if booking.status != 'pending':
        messages.info(request, "Booking is not in pending state.")
        return redirect('washer_view_bookings')

    booking.status = 'accepted'
    booking.save()
    messages.success(request, "Booking accepted.")
    return redirect('washer_view_bookings')


# @login_required
# def reject_booking(request, booking_id):
#     booking = get_object_or_404(Booking, id=booking_id)
#     if booking.washer != request.user:
#         messages.error(request, "You are not allowed to reject this booking.")
#         return redirect("washer_view_bookings")
#     booking.status = "rejected"
#     booking.save()
#     messages.success(request, "Booking has been rejected.")
#     return redirect("washer_view_bookings")

@login_required
def reject_booking(request, booking_id):
    booking = get_object_or_404(Booking, id=booking_id)

    if booking.washer != request.user:
        messages.error(request, "You are not allowed to reject this booking.")
        return redirect("washer_view_bookings")

    if request.method == "POST":
        reason = request.POST.get("reason", "").strip()

        booking.status = "rejected"
        booking.rejection_reason = reason
        booking.save()

        messages.success(request, "Booking rejected with reason.")
        return redirect("washer_view_bookings")

    return redirect("washer_view_bookings")



@login_required
def complete_booking(request, id):
    if request.method != 'POST':
        messages.error(request, "Invalid request method.")
        return redirect('washer_view_bookings')

    booking = get_object_or_404(Booking, id=id)

    if booking.washer != request.user:
        messages.error(request, "Unauthorized action.")
        return redirect('washer_view_bookings')

    if booking.status != 'accepted':
        messages.info(request, "Only accepted bookings can be marked completed.")
        return redirect('washer_view_bookings')

    booking.status = 'completed'
    booking.save()
    messages.success(request, "Booking marked as completed.")
    return redirect('washer_view_bookings')


# ----------------- CUSTOMER SIDE: bookings for a customer's profile -----------------

def customer_bookings(request, id):
    profile = get_object_or_404(CustomerProfile, id=id)
    bookings = Booking.objects.filter(customer=profile.user).order_by('-date', '-time')
    return render(request, 'customer/bookings_list.html', {'profile': profile, 'bookings': bookings})


# ----------------- ADMIN: views -----------------

@login_required
def admin_bookings_view(request):
    bookings = Booking.objects.all().order_by('-created_at')
    return render(request, "admin_bookings_view.html", {"bookings": bookings})


@login_required
def admin_customerlist_view(request):
    customers = CustomerProfile.objects.all()
    return render(request, "admin_customerlist_view.html", {"customers": customers})


@login_required
def admin_washerslist_view(request):
    washers = WasherProfile.objects.select_related('user').all()
    for w in washers:
        try:
            w.company = WasherCompany.objects.get(washer=w.user)
        except WasherCompany.DoesNotExist:
            w.company = None
    return render(request, "admin_washerslist_view.html", {"washers": washers})


@login_required
def delete_washer(request, user_id):
    user = get_object_or_404(User, id=user_id)
    profile = Profile.objects.filter(user=request.user).first()
    if not profile or profile.role != "admin":
        messages.error(request, "You are not authorized to delete washers.")
        return redirect("admin_dashboard")
    user.delete()
    messages.success(request, "Washer account deleted successfully.")
    return redirect("admin_washerslist_view")


# ----------------- FEEDBACK -----------------

@login_required
def submit_feedback(request):
    if request.method == "POST":
        customer = get_object_or_404(CustomerProfile, user=request.user)
        washer_id = request.POST.get("washer")
        description = request.POST.get("message", "")
        stars = request.POST.get("rating", 5)
        booking_id = request.POST.get("booking_id", None)

        washer = get_object_or_404(WasherProfile, id=washer_id)

        booking = None
        if booking_id:
            booking = get_object_or_404(Booking, id=booking_id)

        Feedback.objects.create(
            washer=washer,
            customer=customer,
            booking=booking,
            description=description,
            stars=int(stars)
        )

        messages.success(request, "Thank you! Your feedback has been submitted.")
        return redirect("customer_dashboard")
    return redirect("customer_dashboard")


@login_required
def washer_feedbacks(request):
    washer = get_object_or_404(WasherProfile, user=request.user)
    feedbacks = Feedback.objects.filter(washer=washer).select_related("customer", "booking").order_by("-created_at")
    return render(request, "washer_feedbacks.html", {"feedbacks": feedbacks})


@login_required
def admin_all_feedbacks(request):
    profile = Profile.objects.filter(user=request.user).first()
    if not profile or profile.role != "admin":
        return redirect("admin_dashboard")
    feedbacks = Feedback.objects.select_related("washer", "customer").order_by("-created_at")
    return render(request, "admin_all_feedbacks.html", {"feedbacks": feedbacks})
