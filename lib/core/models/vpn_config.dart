import 'package:one_vpn/core/models/model.dart';

class VpnConfig extends Model {
  VpnConfig({
    required this.id,
    required this.name,
    required this.flag,
    required this.country,
    required this.slug,
    this.status = 0,
    this.hasTcp = false,
    this.hasUdp = false,
    required this.serverIp,
    this.username,
    this.password,
    this.port,
    this.protocol,
    this.config,
  });

  final String id;
  final String name;
  final String flag;
  final String country;
  final String slug;
  final int status;
  final bool hasTcp;
  final bool hasUdp;
  final String serverIp;
  final String? username;
  final String? password;
  final String? port;
  final String? protocol;
  final String? config;

  factory VpnConfig.fromJson(Map<String, dynamic> json) => VpnConfig(
        id: json["id"].toString(),
        name: json["name"],
        flag: json["flag"],
        country: json["country"],
        slug: json["slug"],
        status: json["status"],
        hasTcp: json["has_tcp"] ?? false,
        hasUdp: json["has_udp"] ?? false,
        serverIp: json["server_ip"],
        username: json["username"],
        password: json["password"],
        port: json["port"],
        protocol: json["protocol"],
        config: json["config"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "flag": flag,
        "country": country,
        "slug": slug,
        "status": status,
        "has_tcp": hasTcp,
        "has_udp": hasUdp,
        "server_ip": serverIp,
        "username": username,
        "password": password,
        "port": port,
        "protocol": protocol,
        "config": config,
      };
}
