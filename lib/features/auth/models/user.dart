class User {
  final int id;
  final String fname;
  final String lname;
  final String email;
  final String? phone;
  final String? avatar;
  final String? dob;
  final String role;
  final String status;
  final String? referralCode;
  final String? referredBy;
  final String? lastLoginAt;
  final int failedLoginAttempts;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isEmailVerified;
  final bool isPhoneVerified;

  const User({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    this.phone,
    this.avatar,
    this.dob,
    required this.role,
    required this.status,
    this.referralCode,
    this.referredBy,
    this.lastLoginAt,
    required this.failedLoginAttempts,
    required this.createdAt,
    required this.updatedAt,
    required this.isEmailVerified,
    required this.isPhoneVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatar: json['avatar'] as String?,
      dob: json['dob'] as String?,
      role: json['role'] as String,
      status: json['status'] as String,
      referralCode: json['referral_code'] as String?,
      referredBy: json['referred_by'] as String?,
      lastLoginAt: json['last_login_at'] as String?,
      failedLoginAttempts: json['failed_login_attempts'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isEmailVerified: json['is_email_verified'] as bool,
      isPhoneVerified: json['is_phone_verified'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'dob': dob,
      'role': role,
      'status': status,
      'referral_code': referralCode,
      'referred_by': referredBy,
      'last_login_at': lastLoginAt,
      'failed_login_attempts': failedLoginAttempts,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_email_verified': isEmailVerified,
      'is_phone_verified': isPhoneVerified,
    };
  }

  // Add other methods (copyWith, operator ==, hashCode, toString) as needed...
}