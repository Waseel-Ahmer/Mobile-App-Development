// lab3.dart  -  Campus Cafe Order System
// Name: ____________________   Roll no: ____________
const String rollNo = '04072313013'; // e.g. '2100672347'
// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit
const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];
int priceOf(int i) => 100 + 7 * i + 3 * t; // price of menu[i], in rupees
final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;

class Dish {
  late String name;
  late int price;
}

class MenuItem {
  String name;
  int price;
  MenuItem(this.name, this.price) {
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }
  MenuItem.free(this.name) : price = 0;
  MenuItem.fromString(String text)
    : this.name = text.split(":")[0],
      this.price = int.parse(text.split(":")[1]);
  @override
  String toString() => '$name (Rs $price)';
}

class OrderLog {
  static OrderLog? _instance;
  final List<String> entries = [];
  OrderLog._internal(); // private named constructor
  factory OrderLog() {
    return _instance ??= OrderLog._internal();
  } // always the same object
  void add(String msg) => entries.add(msg);
}

class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;
  OrderLine(this.item, this.qty)
    : total = item.price * qty,
      tax = (item.price * qty * taxPercent) ~/ 100,
      assert(qty > 0, 'qty must be positive');
  int get grand => total + tax;
  bool get isBigOrder => grand > bigOrderLimit;
  String get label => '${this.item.name} x${this.qty}';
}

OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}

class StudentCard {
  final String owner;
  int _balance; // private backing field

  StudentCard(this.owner) : _balance = 0;

  int get balance => _balance;

  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }
}

List buildMenu() {
  return [
    for (int k = 0; k <= 3; k++)
      MenuItem.fromString(
        '${menu[(u + 3 * k) % 10]}:${priceOf((u + 3 * k) % 10)}',
      ),
  ];
}

// ===========================================================================
void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

void step1() {
  print('--- Step 1 ---');
  Dish item1 = Dish();
  Dish item2 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);
  item2.name = menu[(u + 1) % 10];
  item2.price = priceOf((u + 1) % 10);
  item2.price = item2.price - u;
  print('${item1.name}  Rs.${item1.price}');
  print('${item2.name}  Rs.${item2.price}');
}

void step2() {
  print('--- Step 2 ---');
  MenuItem a = MenuItem(menu[u], priceOf(u));
  MenuItem b = MenuItem("Test Special", 15 * u);
  print('${a.name}   Rs.${a.price}');
  print('${b.name}   Rs.${b.price}');
}

void step3() {
  print('--- Step 3 ---');
  var freebie = MenuItem.free('Water');
  var i = (u + 2) % 10;
  var parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');
  print('${freebie.name}  Rs.${freebie.price}');
  print('${parsed.name}  Rs.${parsed.price}');
  print('floor=${priceFloor}, free price=${freebie.price} ');
}

void step4() {
  print('--- Step 4 ---');
  var log1 = OrderLog();
  var log2 = OrderLog();
  for (int i = 1; i <= u + 2; i++) {
    var msg = 'order #${100 * t + i}';
    if (i % 2 == 0) {
      log2.add(msg);
    } else {
      log1.add(msg);
    }
  }
  print('same object? ${identical(log1, log2)}');
  print('entries = ${log1.entries.length}');
  print('last = ${log2.entries.length}');
}

void step5() {
  print('--- Step 5 ---');
  var line = mainOrder();
  print('${line.item.name} x ${line.qty}');
  print('total=${line.total} tax=${line.tax}');
  try {
    OrderLine(line.item, 0);
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }
}

void step6() {
  print('--- Step 6 ---');
  var line = mainOrder();
  print('grand=${line.grand}');
  print('big Order? ${line.isBigOrder}');
  print('label=${line.label}');
}

void step7() {
  print('--- Step 7 ---');
  var card = StudentCard('S$seed');
  card.balance = seed * 10 + 50;
  print('topped up -> ${card.balance}');
  card.balance = -seed - 1;
  print('bad value -> ${card.balance}');
  card.balance = balanceCap - u;
  print('reset -> ${card.balance}');
  card.balance = card.balance - mainOrder().grand;
  print('paid order -> ${card.balance}');
}

void step8() {
  print('--- Step 8 ---');
  var products = buildMenu();

  var expensive = products.reduce((curr, next) {
    return (curr.price > next.price) ? curr : next;
  });

  var sum = products.fold(
    0,
    (int total, dynamic item) => total + (item as MenuItem).price,
  );
  print('menu = $products');
  print('priciest = ${expensive.name}');
  print('sum = $sum');
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}
