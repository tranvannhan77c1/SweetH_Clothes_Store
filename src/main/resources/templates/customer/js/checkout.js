var app = angular.module('checkoutApp', []);

app.controller('CheckoutController', ['$scope', '$http', function($scope, $http) {
    $scope.products = [];
    $scope.cart = [];
    $scope.showSuccessAlert = false;
    $scope.userInfo = null;

    // Load giỏ hàng từ local storage khi trang được tải
    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }

    $scope.calculateTotal = function() {
        return $scope.cart.reduce((total, item) => {
            return total + item.price * item.quantity;
        }, 0);
    };

    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }

    var loginToken = localStorage.getItem('jwtToken');
    $scope.isLogin = loginToken !== null && loginToken.length > 0

    // var accountDetail = localStorage.getItem('accountDetail');
    var storedUserInfo = localStorage.getItem('accountDetail');
    if (storedUserInfo) {
        $scope.userInfo = JSON.parse(storedUserInfo);
    }


    $scope.payment = function() {
        let order_totalAmount = 0;
        var orderDetail = [];
        $scope.cart.forEach(product => {
            order_totalAmount += product.price * product.quantity;
            orderDetail.push({
                quantity: product.quantity,
                price: product.price,
                size: "test",
                productId: product.id
            })
        })

        var order = {
            totalAmount: order_totalAmount,
            status: null,
            address: "test address",
            phone: $scope.userInfo.phone,
            voucherId: null,
            accountId: $scope.userInfo.id
        }

        var orderRequest = {
            order: order,
            orderDetailDTOs: orderDetail

        }

        console.log(orderRequest)



        $http.post('http://localhost:8080/api/v1/customer/orders/createOrder', orderRequest)
            .then(function(response) {
                // Handle success
                console.log('Payment successful:', response.data);

            })
            .catch(function(error) {
                // Handle error
                console.error('Payment failed:', error);
            });
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
// rút gọn tên sản phẩm 
app.filter('truncate', function () {
    return function (input, limit) {
        if (input.length > limit) {
            return input.substring(0, limit) + '...';
        } else {
            return input;
        }
    };
});