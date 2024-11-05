class LoginComplementRequest{
  final String platform;
  final String ipAddress;
  final String device;

  LoginComplementRequest({
    required this.platform,
    required this.ipAddress,
    required this.device
  });

  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'ipAddress': ipAddress,
      'device': device,
    };
  }
}