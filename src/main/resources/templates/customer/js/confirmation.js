var app = angular.module('confirmationApp', []);

app.controller('confirmationController', ['$scope', '$http', '$location', function ($scope, $http, $location) {
    $scope.produc = [];
    $scope.cart = [];
    $scope.showSuccessAlert = false;
    $scope.userInfo = null;

    // Load giỏ hàng từ local storage khi trang được tải
    var storedCart = localStorage.getItem('cart');
    if (!storedCart) {
        return;
    }
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }

    $scope.calculateTotal = function () {
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

    function getQueryParams() {
        var params = {};
        var parts = $location.absUrl().split('?')[1].split('&');
        for (var i = 0; i < parts.length; i++) {
            var param = parts[i].split('=');
            params[param[0]] = param[1];
        }
        return params;
    }

    $scope.payment = function () {
        let order_totalAmount = 0;
        var orderDetail = [];
        $scope.cart.forEach(product => {
            order_totalAmount += product.price * product.quantity;
            orderDetail.push({
                quantity: product.quantity,
                price: product.price,
                size: product.size,
                productId: product.id
            })
        })

        var order = {
            totalAmount: order_totalAmount,
            status: "ĐÃ THANH TOÁN",
            address: $scope.userInfo.address,
            phone: $scope.userInfo.phone,
            voucherId: 1,
            payment: "VNPAY",
            accountId: $scope.userInfo.id,
            orderDetails: orderDetail
        }

        var orderRequest = {
            orderDTO: order,
        }

        $http.post('http://localhost:8080/api/orders/createOrder', orderRequest)
            .then(function (response) {
                // Handle success
                console.log('Payment successful:', response.data);

            })
            .catch(function (error) {
                // Handle error
                console.error('Payment failed:', error);
            })
            .finally(function () {
                document.getElementById('loading').style.display = 'block';
                localStorage.removeItem('cart')

                var params = getQueryParams();
                var vnp_ResponseCode = params['vnp_ResponseCode'];
                $scope.orderInfo = null;
                $http.get('http://localhost:8080/api/v1/payment/vn-pay-callback?userID=' + $scope.userInfo.id + '&vnp_ResponseCode=' + vnp_ResponseCode)
                    .then(function (response) {
                        $scope.orderInfo = response.data.orderInfo
                    })
                    .catch(function (error) {
                        // Handle error
                        console.error('Payment failed:', error);
                    });
            });
    }

    try {
        var params = getQueryParams();
        if (params) {
            $scope.payment()
        }
    } catch (e) {
        console.log("cod")
        document.getElementById('loading').style.display = 'block';
        // localStorage.removeItem('cart')

        $scope.orderInfo = null;
        $http.get('http://localhost:8080/api/orders/UserOrder?userID=' + $scope.userInfo.id)
            .then(function (response) {
                $scope.orderInfo = response.data
                console.log($scope.orderInfo)
            })
            .catch(function (error) {
                // Handle error
                console.error('Payment failed:', error);
            });
    }

    // if(params) {
    //     $scope.payment()
    // } else {

    // }


    // var params = getQueryParams();
    // var vnp_ResponseCode = params['vnp_ResponseCode'];
    // $scope.orderInfo = null;
    // $http.get('http://localhost:8080/api/v1/payment/vn-pay-callback?userID=' + $scope.userInfo.id + '&vnp_ResponseCode=' + vnp_ResponseCode)
    //     .then(function (response) {
    //         $scope.orderInfo = response.data.orderInfo
    //     })
    //     .catch(function (error) {
    //         // Handle error
    //         console.error('Payment failed:', error);
    //     });

}]);

app.filter('floor', function () {
    return function (input) {
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