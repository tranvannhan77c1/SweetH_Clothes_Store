var app = angular.module('singleProductApp', []);

app.controller('SingleProductController', ['$scope', '$http', '$location', function ($scope, $http, $location) {
    $scope.cart = [];
    $scope.showSuccessAlert = false;

    $scope.addToCart = function (product) {
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

    $scope.increaseQuantity = function (item) {
        let index = $scope.cart.findIndex(product => product.id === item.id);

        if (index !== -1) {
            $scope.cart[index].quantity++;
            localStorage.setItem('cart', JSON.stringify($scope.cart));
        }
    };

    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }

    // Function to get query parameters
    function getQueryParams() {
        var params = {};
        var parts = $location.absUrl().split('?')[1].split('&');
        for (var i = 0; i < parts.length; i++) {
            var param = parts[i].split('=');
            params[param[0]] = param[1];
        }
        return params;
    }

    // Get product ID from URL
    var params = getQueryParams();
    var productId = params['id'];

    // Fetch product details from the API

    $http.get('http://localhost:8080/api/v1/product/public/' + productId)
        .then(function (response) {
            $scope.product = response.data;
        })
        .catch(function (error) {
            console.error('Error fetching product data:', error);
        });


}]);