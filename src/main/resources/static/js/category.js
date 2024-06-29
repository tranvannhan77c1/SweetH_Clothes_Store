var app = angular.module('categoryApp', []);

app.controller('ProductController', ['$scope', '$http', function($scope, $http) {
    $scope.products = [];
    $scope.cart = [];
    $scope.showSuccessAlert = false;

    // Lấy dữ liệu sản phẩm từ API
    $http.get('http://localhost:8080/api/v1/product/landing?page=1&limit=8')
        .then(function(response) {
            $scope.products = response.data.content;
        })
        .catch(function(error) {
            console.error('Error fetching products:', error);
        });

    // Hàm thêm sản phẩm vào giỏ hàng và lưu vào local storage
    $scope.addToCart = function(product) {
        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        let existingProductIndex = $scope.cart.findIndex(item => item.id === product.id);

        if (existingProductIndex !== -1) {
            // Nếu sản phẩm đã có trong giỏ hàng, tăng số lượng lên
            $scope.cart[existingProductIndex].quantity++;
        } else {
            // Nếu sản phẩm chưa có trong giỏ hàng, thêm sản phẩm vào giỏ hàng với số lượng là 1
            product.quantity = 1;
            $scope.cart.push(product);
        }

        // Lưu giỏ hàng mới vào local storage
        localStorage.setItem('cart', JSON.stringify($scope.cart));

        // Hiển thị thông báo thành công
        $('#successModal').modal('show');
    };

    // Hàm tăng số lượng sản phẩm trong giỏ hàng
    $scope.increaseQuantity = function(item) {
        let index = $scope.cart.findIndex(product => product.id === item.id);

        if (index !== -1) {
            $scope.cart[index].quantity++;
            localStorage.setItem('cart', JSON.stringify($scope.cart));
        }
    };

    // Hàm giảm số lượng sản phẩm trong giỏ hàng
    $scope.decreaseQuantity = function(item) {
        let index = $scope.cart.findIndex(product => product.id === item.id);

        if (index !== -1) {
            if ($scope.cart[index].quantity > 1) {
                $scope.cart[index].quantity--;
            } else {
                $scope.cart.splice(index, 1);
            }
            localStorage.setItem('cart', JSON.stringify($scope.cart));
        }
    };

    // Hàm xóa toàn bộ giỏ hàng
    $scope.clearCart = function() {
        $scope.cart = [];
        localStorage.removeItem('cart');
    };

    // Hàm tính tổng giá trị của giỏ hàng
    $scope.calculateTotal = function() {
        return $scope.cart.reduce((total, item) => {
            return total + item.price * item.quantity;
        }, 0);
    };

    // Load giỏ hàng từ local storage khi trang được tải
    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }
}]);

app.filter('floor', function() {
    return function(input) {
        if (isNaN(input)) {
            console.log("string")
            return input;
        } 
        return Math.floor(input * 100) / 100;
    };
});