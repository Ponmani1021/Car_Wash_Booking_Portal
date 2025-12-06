from django.db import models
from django.contrib.auth.models import User


class Announcement(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title


class Profile(models.Model):
    ROLE_CHOICES = [
        ('customer', 'Customer'),
        ('washer', 'Washer'),
        ('admin', 'Admin'),
    ]

    user = models.OneToOneField(User, on_delete=models.CASCADE)
    full_name = models.CharField(max_length=100)
    email = models.EmailField()
    contact_number = models.CharField(max_length=15, blank=True, null=True)
    role = models.CharField(max_length=20, choices=ROLE_CHOICES)

    def __str__(self):
        return f"{self.full_name} ({self.role})"


class WasherProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    full_name = models.CharField(max_length=120, blank=True, null=True)
    contact_number = models.CharField(max_length=15, blank=True, null=True)
    profile_image = models.ImageField(upload_to='washer_profiles/', blank=True, null=True)

    def __str__(self):
        return self.full_name or self.user.username


class WasherCompany(models.Model):
    washer = models.OneToOneField(User, on_delete=models.CASCADE)   # one company per user
    company_name = models.CharField(max_length=200)
    company_address = models.CharField(max_length=300, blank=True, null=True)
    company_timings = models.CharField(max_length=120, blank=True, null=True)
    company_image = models.ImageField(upload_to='company_images/', blank=True, null=True)
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.company_name} ({self.washer.username})"


class BookingCostDetails(models.Model):
    VEHICLE_CHOICES = [
        ('two_wheeler', 'Two Wheeler'),
        ('four_wheeler', 'Four Wheeler'),
        ('bus', 'Bus'),
        ('heavy_vehicle', 'Heavy Vehicle'),
    ]

    washer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='prices')
    vehicle_type = models.CharField(max_length=30, choices=VEHICLE_CHOICES)
    subtype = models.CharField(max_length=120, blank=True, null=True)
    cost = models.DecimalField(max_digits=8, decimal_places=2)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        subtype_text = f" - {self.subtype}" if self.subtype else ""
        return f"{self.get_vehicle_type_display()}{subtype_text} ({self.washer.username})"


class CustomerProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    full_name = models.CharField(max_length=150, blank=True, null=True)
    email = models.EmailField(blank=True, null=True)
    contact_number = models.CharField(max_length=20, blank=True, null=True)
    profile_image = models.ImageField(upload_to='customer_profiles/', blank=True, null=True)

    def __str__(self):
        return self.full_name or self.user.username


class VehicleType(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class VehicleSubType(models.Model):
    vehicle_type = models.ForeignKey(VehicleType, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    cost = models.DecimalField(max_digits=10, decimal_places=2)
    washer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='washer_subtypes')

    def __str__(self):
        return f"{self.vehicle_type.name} - {self.name}"


class Booking(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('accepted', 'Accepted'),
        ('completed', 'Completed'),
        ('cancelled', 'Cancelled'),
        ('rejected', 'Rejected'),
    ]

    customer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='customer_bookings')
    washer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='washer_bookings')
    vehicle_type = models.CharField(max_length=100)
    subtype = models.CharField(max_length=100)
    cost = models.DecimalField(max_digits=10, decimal_places=2)
    pickup_drop = models.BooleanField(default=False)
    date = models.DateField(null=True, blank=True)
    time = models.TimeField(null=True, blank=True)
    address = models.TextField(null=True, blank=True)
    total_cost = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Booking #{self.id} - {self.customer.username} → {self.washer.username}"


class Feedback(models.Model):
    washer = models.ForeignKey(WasherProfile, on_delete=models.CASCADE)
    customer = models.ForeignKey(CustomerProfile, on_delete=models.CASCADE)
    booking = models.ForeignKey(Booking, on_delete=models.CASCADE, null=True, blank=True)
    description = models.TextField()
    stars = models.IntegerField(default=5)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        customer_name = self.customer.full_name or self.customer.user.username
        return f"Feedback from {customer_name} ({self.stars}★)"
