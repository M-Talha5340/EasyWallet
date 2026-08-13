import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String? name;    
  final String phone;
  final double walletBalance;
  final Timestamp? createdAt;
  AppUser({    
    required this.name,    
    required this.phone,
    required this.walletBalance,
    required this.createdAt

  });

  AppUser copyWith({    
    String? name,    
    String? phone,
    double? walletBalance,
     Timestamp? createdAt,
  }) {
    return AppUser(      
      name: name ?? this.name,      
      phone: phone ?? this.phone,
      walletBalance: walletBalance??this.walletBalance,
      createdAt: createdAt ?? this.createdAt
    );
  }

  Map<String, dynamic> tomap() {
    return {
      "name": name,            
      "phone":phone,
      "walletBalance":walletBalance,
      "createdAt":createdAt
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map["name"],            
      phone: map["phone"],
      walletBalance: (map["walletBalance"]as num?)?.toDouble() ?? 0.0,
      createdAt: map["createdAt"]
    );
  }
}
