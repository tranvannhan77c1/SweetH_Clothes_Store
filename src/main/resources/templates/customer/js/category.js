var app = angular.module('categoryApp', []);

app.controller('ProductController', ['$scope', '$http', function($scope, $http) {
    $scope.products = [];
    $scope.cart = [];
    $scope.showSuccessAlert = false;
    $scope.query = '';
    $scope.currentPage = 1;
    $scope.totalPages = 1;
    $scope.pageSize = 8;

    $scope.searching = function() {
        console.log($scope.query)
    }

    // Lấy dữ liệu sản phẩm từ API
    $scope.getProducts = function(page) {
        $http.get(`http://localhost:8080/api/v1/product/landing?page=${page}&limit=${$scope.pageSize}`)
            .then(function(response) {
                $scope.products = response.data.content;
                $scope.totalPages = Math.ceil(response.data.totalElements / $scope.pageSize);
            })
            .catch(function(error) {
                console.error('Error fetching products:', error);
            });
    };

    $scope.getProducts($scope.currentPage);

    // Hàm chuyển trang
    $scope.changePage = function(page) {
        if (page >= 1 && page <= $scope.totalPages) {
            $scope.currentPage = page;
            $scope.getProducts(page);
        }
    };

    // Hàm thêm sản phẩm vào giỏ hàng và lưu vào local storage
    $scope.addToCart = function(product) {
        let existingProductIndex = $scope.cart.findIndex(item => item.id === product.id);

        if (existingProductIndex !== -1) {
            $scope.cart[existingProductIndex].quantity++;
        } else {
            product.quantity = 1;
            $scope.cart.push(product);
        }

        localStorage.setItem('cart', JSON.stringify($scope.cart));
        $('#successModal').modal('show');
    };

    $scope.increaseQuantity = function(item) {
        let index = $scope.cart.findIndex(product => product.id === item.id);

        if (index !== -1) {
            $scope.cart[index].quantity++;
            localStorage.setItem('cart', JSON.stringify($scope.cart));
        }
    };

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

    $scope.clearCart = function() {
        $scope.cart = [];
        localStorage.removeItem('cart');
    };

    $scope.calculateTotal = function() {
        return $scope.cart.reduce((total, item) => {
            return total + item.price * item.quantity;
        }, 0);
    };

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