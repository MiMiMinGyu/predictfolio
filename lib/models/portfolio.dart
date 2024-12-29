// Portfolio 클래스 정의
class Portfolio {
  String title;
  String description;
  final List<StockPurchaseDetail> stockPurchaseDetails;
  final Traits traits;

  Portfolio({
    required this.title,
    required this.description,
    required this.stockPurchaseDetails,
    required this.traits,
  });
}

// StockPurchaseDetail 클래스 정의
class StockPurchaseDetail {
  final String stock;
  final int price;
  final int shares;
  final int totalCost;

  StockPurchaseDetail({
    required this.stock,
    required this.price,
    required this.shares,
    required this.totalCost,
  });
}

class Traits {
  final double profit;
  final double analysis;
  final double safety;
  final double obsession;

  Traits({
    required this.profit,
    required this.analysis,
    required this.safety,
    required this.obsession,
  });
}
