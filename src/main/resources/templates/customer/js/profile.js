var app = angular.module('profileApp', []);

app.controller('ProfileController', ['$scope', '$http', function($scope, $http) {
    $scope.cart = [];
    $scope.userInfo = null;
    $scope.selectedOrder = null;
    $scope.passwordData = {
        oldPassword: '',
        newPassword: '',
        confirmNewPassword: ''
    };
    // Load giỏ hàng từ local storage khi trang được tải
    var storedCart = localStorage.getItem('cart');
    if (storedCart) {
        $scope.cart = JSON.parse(storedCart);
    }
    var loginToken = localStorage.getItem('jwtToken');
    $scope.isLogin = loginToken !== null && loginToken.length > 0;

    var storedUserInfo = localStorage.getItem('accountDetail');
    if (storedUserInfo) {
        $scope.userInfo = JSON.parse(storedUserInfo);
    }

    $scope.changePassword = function() {
        const token = loginToken.replace(/"/g, '').trim();

        $http({
                method: 'PUT',
                url: "http://localhost:8080/api/accounts/" + $scope.userInfo.id + "/change-password",
                params: { oldPassword: $scope.passwordData.oldPassword , newPassword: $scope.passwordData.newPassword},
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + token
                }
            })
            .then(function(response) {
                // Success callback
                // localStorage.setItem('accountDetail', JSON.stringify(response.data))
                location.reload();
                console.log("Update successs") // Assign response data
            })
            .catch(function(error) {
                // Error callback
                console.error('Error fetching orders:', error);
                $scope.userOrders = null;
            });
    }

    $scope.updateAccount = function() {
        var user_Info = {
            username: $scope.userInfo.username,
            email: $scope.userInfo.email,
            fullName: $scope.userInfo.fullName,
            phone: $scope.userInfo.phone,
            address: $scope.userInfo.address,
            role: $scope.userInfo.role,
        }
        // Get the token and remove double quotes
        const token = loginToken.replace(/"/g, '').trim();

        $http({
                method: 'PUT',
                url: "http://localhost:8080/api/accounts/" + $scope.userInfo.id,
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer ' + token
                },
                data: user_Info 
            })
            .then(function(response) {
                // Success callback
                localStorage.setItem('accountDetail', JSON.stringify(response.data))
                location.reload();
                console.log("Update successs") // Assign response data
            })
            .catch(function(error) {
                // Error callback
                console.error('Error fetching orders:', error);
                $scope.userOrders = null;
            });
    }

    $scope.userOrders = [];
    $scope.fetchOrder = function() {
        // Get the token and remove double quotes
        const token = loginToken.replace(/"/g, '').trim();

        $http({
                method: 'GET',
                url: "http://localhost:8080/api/orders/userOrder",
                params: { userID: $scope.userInfo.id },
                headers: {
                    'Authorization': 'Bearer ' + token
                }
            })
            .then(function(response) {
                // Success callback
                $scope.userOrders = response.data; // Assign response data
            })
            .catch(function(error) {
                // Error callback
                console.error('Error fetching orders:', error);
                $scope.userOrders = null;
            });
    };

    $scope.fetchOrder();
    $scope.viewOrderDetail = function(order) {
        $scope.selectedOrder = order;
        console.log($scope.selectedOrder)
        $('#orderDetailModal').modal('show');
    };

    $scope.logout = function() {
        localStorage.removeItem('jwtToken');
        localStorage.removeItem('accountDetail');
        $scope.isLogin = false;
        // redirect to login page or reload the page
        window.location.href = '../index.html';
    };

    $scope.checkPasswordMatch = function() {
        // Kiểm tra xem mật khẩu xác nhận có khớp với mật khẩu mới không
        if ($scope.passwordData.confirmNewPassword !== $scope.passwordData.newPassword) {
            $scope.passwordForm.confirmNewPassword.$setValidity('match', false);
        } else {
            $scope.passwordForm.confirmNewPassword.$setValidity('match', true);
        }
    };
}]);

app.filter('customDateFormat', function() {
    return function(input) {
        if (!input) return '';

        // Create a Date object from the input string
        const date = new Date(input);

        // Extract the components of the date
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const month = String(date.getMonth() + 1).padStart(2, '0'); // Months are zero-based
        const year = date.getFullYear();

        // Format the date as 'HH:mm DD/MM/YYYY'
        return `${hours}:${minutes} ${day}/${month}/${year}`;
    };
});