var app = angular.module('indexApp', []);

app.controller('ProductController', ['$scope', '$http', function($scope, $http) {
    $scope.products = [];
    $scope.cart = [];
    $scope.showSuccessMessage = false;
    $scope.selectedProduct = null;

    // Lấy danh sách sản phẩm từ backend
    $http.get('http://localhost:8080/api/v1/product/public/landing?page=1&limit=8')
        .then(function(response) {
            $scope.products = response.data.content;
        })
        .catch(function(error) {
            console.error('Error fetching products:', error);
        });

    // Hàm hiển thị modal thành công
    $scope.showSuccessModal = function(product) {
        $scope.selectedProduct = product;
        $('#successModal').modal('show');
    };

    // Hàm thêm sản phẩm vào giỏ hàng
    $scope.addToCart = function (product) {
        let existingProductIndex = $scope.cart.findIndex(item => item.id === product.id);

        if (existingProductIndex !== -1) {
            $scope.cart[existingProductIndex].quantity++;
        } else {
            product.quantity = 1;
            $scope.cart.push(product);
        }

        localStorage.setItem('cart', JSON.stringify($scope.cart));
        $scope.showSuccessMessage = true; // Show success message

        setTimeout(() => {
            $scope.showSuccessMessage = false; // Hide success message after 3 seconds
            $scope.$apply();
        }, 3000);
    };

    // Load giỏ hàng từ local storage khi trang được tải
    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }

    // Đặt hình ảnh chính của sản phẩm
    $scope.setMainImage = function(image) {
        $scope.selectedProduct.thumbnailImage = image;
    };
}]);
