// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
    final String? userName;
    final dynamic totalIncome;
    final dynamic incomeGrowth;
    final dynamic totalRentals;
    final dynamic netBalance;
    final dynamic maintenance;
    final dynamic totalUnits;
    final dynamic occupiedUnits;
    final dynamic vacantUnits;
    final dynamic occupancyRate;
    final List<ChartDatum>? chartData;
    final String? lastUpdated;

    DashboardModel({
        this.userName,
        this.totalIncome,
        this.incomeGrowth,
        this.totalRentals,
        this.netBalance,
        this.maintenance,
        this.totalUnits,
        this.occupiedUnits,
        this.vacantUnits,
        this.occupancyRate,
        this.chartData,
        this.lastUpdated,
    });

    factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        userName: json["userName"],
        totalIncome: json["totalIncome"],
        incomeGrowth: json["incomeGrowth"],
        totalRentals: json["totalRentals"],
        netBalance: json["netBalance"],
        maintenance: json["maintenance"],
        totalUnits: json["totalUnits"],
        occupiedUnits: json["occupiedUnits"],
        vacantUnits: json["vacantUnits"],
        occupancyRate: json["occupancyRate"],
        chartData: json["chartData"] == null ? [] : List<ChartDatum>.from(json["chartData"]!.map((x) => ChartDatum.fromJson(x))),
        lastUpdated: json["lastUpdated"],
    );

    Map<String, dynamic> toJson() => {
        "userName": userName,
        "totalIncome": totalIncome,
        "incomeGrowth": incomeGrowth,
        "totalRentals": totalRentals,
        "netBalance": netBalance,
        "maintenance": maintenance,
        "totalUnits": totalUnits,
        "occupiedUnits": occupiedUnits,
        "vacantUnits": vacantUnits,
        "occupancyRate": occupancyRate,
        "chartData": chartData == null ? [] : List<dynamic>.from(chartData!.map((x) => x.toJson())),
        "lastUpdated": lastUpdated,
    };
}

class ChartDatum {
    final String? name;
    final int? value;

    ChartDatum({
        this.name,
        this.value,
    });

    factory ChartDatum.fromJson(Map<String, dynamic> json) => ChartDatum(
        name: json["name"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
    };
}
