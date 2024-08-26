var app = angular.module('checkoutApp', []);

app.controller('CheckoutController', ['$scope', '$http', function($scope, $http) {
    $scope.products = [];
    $scope.cart = [];
    $scope.showSuccessAlert = false;
    $scope.userInfo = null;
    $scope.paymentMethod = 'cod';


    // Load giỏ hàng từ local storage khi trang được tải
    var storedCart = localStorage.getItem('cart');
    if (storedCart === null || storedCart === undefined || storedCart === '') {
        $scope.header_areaStyle = {
            display: 'none'
        }

        $scope.checkout_areaStyle = {
            display: 'none'
        }

        $scope.footerStyle = {
            display: 'none'
        }

        $scope.bodyStyle = {
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            height: '100vh',
            margin: '0',
            fontFamily: "'Poppins', sans-serif",
            backgroundColor: '#f4f4f4'
        };

        $scope.invalid_connectionStyle = {
            fontSize: '80px',
            color: '#333'
        };
    } else {
        $scope.cart = JSON.parse(storedCart);
    }
    
    $scope.submitForm = function() {
        var order_User_Info = {
            fullName: $scope.userInfo.fullName,
            phone: $scope.userInfo.phone,
            email: $scope.userInfo.email,
            address: $scope.userInfo.address
        }

        localStorage.setItem('order_User_Info', JSON.stringify(order_User_Info));
        if ($scope.paymentMethod === 'cod') {
            $scope.paymentCod();
        } else {
            $scope.payment();
        }
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

    var loginToken = localStorage.getItem('jwtToken');
    $scope.isLogin = loginToken !== null && loginToken.length > 0

    // var accountDetail = localStorage.getItem('accountDetail');
    var storedUserInfo = localStorage.getItem('accountDetail');
    if (storedUserInfo) {
        $scope.userInfo = JSON.parse(storedUserInfo);
    }

    $scope.paymentCod = function() {
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
            status: "Đang Xử Lý",
            address: $scope.userInfo.address,
            phone: $scope.userInfo.phone,
            voucherId: 1,
            payment: "COD",
            accountId: $scope.userInfo.id,
            orderDetails: orderDetail
        }

        var orderRequest = {
            orderDTO: order
        }

        console.log(orderRequest);
        const token = loginToken.replace(/"/g, '').trim();
        $http.post('http://localhost:8080/api/orders/createOrder', orderRequest, {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + loginToken.replace(/"/g, '').trim()  // Replace with your actual JWT token variable
            }
        })
        .then(function(response) {
            // Handle success
            console.log('Payment successful:', response.data);
            window.location.href = '../pages/confirmation.html';
        })
        .catch(function(error) {
            // Handle error
            console.error('Payment failed:', error);
        });
    }


    $scope.payment = function() {
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

        console.log(orderRequest)



        // $http.post('http://localhost:8080/api/v1/customer/orders/createOrder', orderRequest)
        //     .then(function(response) {
        //         // Handle success
        //         console.log('Payment successful:', response.data);

        //     })
        //     .catch(function(error) {
        //         // Handle error
        //         console.error('Payment failed:', error);
        //     });
        $http.get('http://localhost:8080/api/v1/payment/vn-pay?amount=' + ($scope.calculateTotal() + 50000) + '&bankCode=NCB')
            .then(function(response) {
                // Handle success
                // console.log('Payment successful:', response.data);
                window.location.href = response.data.paymentUrl
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
app.filter('truncate', function() {
    return function(input, limit) {
        if (input.length > limit) {
            return input.substring(0, limit) + '...';
        } else {
            return input;
        }
    };
});