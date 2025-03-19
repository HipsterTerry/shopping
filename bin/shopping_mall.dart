import 'dart:io';

class Product {
  //솔직히 GPT 짜집기로 만든건데 주석을 달면서 이해 하려고 합니다 ㅜㅜ
  String name; // 스트링 값 이름입니다 상품명 겸 타이틀입니다.
  int price; // 인트 값 가격표입니다.

  Product(this.name, this.price);
}

class ShoppingMall {
  //쇼핑몰 차트를 만드네요
  List<Product> products = [
    //List [타입] 프로덕트로 print 구간
    Product("셔츠", 45000),
    Product("원피스", 30000),
    Product("반팔티", 35000),
    Product("반바지", 38000),
    Product("양말", 5000),
  ];

  Map<String, int> cart = {}; // map으로 스트링 인트 1묶음 만들어서 에러없이
  List<String> cartItems = [];
  int totalPrice = 0;
  //지금부터 이해가 안되기 시작합니다 저기 점선을 어떻게 일자로 만들지....
  void showMenu() {
    print(
      "-------------------------------------------------------------------",
    );
    print("[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니 목록 및 총 가격 보기");
    print("[4] 프로그램 종료 / [6] 장바구니 초기화");
    print(
      "-------------------------------------------------------------------",
    );
  } //1~4 메뉴일때도 점선이 끝까지 안 가더라고요??? 혹시 끝까지 채워야하나 하고 했더니 에러가...

  void showProducts() {
    print(
      "-------------------------------------------------------------------",
    );
    for (var product in products) {
      print("${product.name} / ${product.price}원");
    }
    print(
      "-------------------------------------------------------------------",
    );
  }

  void addToCart() {
    print("상품 이름을 입력해 주세요!");
    String? productName = stdin.readLineSync()?.trim();

    Product? selectedProduct = products.firstWhere(
      (p) => p.name == productName,
      orElse: () => Product("", 0),
    );

    print("상품 개수를 입력해 주세요!");
    String? quantityInput = stdin.readLineSync()?.trim();

    if (selectedProduct.name.isEmpty) {
      print("입력값이 올바르지 않아요!");
      return;
    }

    try {
      int quantity = int.parse(quantityInput!);
      if (quantity <= 0) {
        print("0개보다 많은 개수의 상품만 담을 수 있어요!");
        return;
      }

      cart[productName!] = (cart[productName] ?? 0) + quantity;
      totalPrice += selectedProduct.price * quantity;

      if (!cartItems.contains(productName)) {
        cartItems.add(productName);
      }

      print("장바구니에 상품이 담겼어요!");
    } catch (e) {
      print("입력값이 올바르지 않아요!");
    }
  }

  void showCart() {
    if (cartItems.isEmpty) {
      print("장바구니에 담긴 상품이 없습니다.");
      return;
    }
    print("장바구니에 ${cartItems.join(", ")}가 담겨있네요. 총 [$totalPrice]원 입니다!");
  }

  void clearCart() {
    if (cart.isEmpty) {
      print("이미 장바구니가 비어있습니다.");
      return;
    }

    cart.clear();
    cartItems.clear();
    totalPrice = 0;
    print("장바구니를 초기화합니다.");
  }
}

void main() {
  ShoppingMall shop = ShoppingMall();

  while (true) {
    shop.showMenu();
    String? input = stdin.readLineSync()?.trim();

    if (input == "1") {
      shop.showProducts();
    } else if (input == "2") {
      shop.addToCart();
    } else if (input == "3") {
      shop.showCart();
    } else if (input == "6") {
      shop.clearCart();
    } else if (input == "4") {
      print("이용해 주셔서 감사합니다~ 안녕히 가세요!");
      print(
        "-------------------------------------------------------------------",
      );
      break;
    } else {
      print("올바른 번호를 입력해주세요!");
    }
  }
}// 제가 볼땐 초급이 아닌거 같습니다 고급반 신의영역 하지만 강의는 계속 됩니다~