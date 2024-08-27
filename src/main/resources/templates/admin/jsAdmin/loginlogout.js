angular.module('app').controller('loginlogoutController', ['$scope', '$http', function ($scope, $http) {
    $scope.username = '';
    $scope.password = '';
    $scope.errorMessage = '';
    $scope.menuItems = [
        { link: 'quanlydanhmuc.html', label: { 'ADMIN': 'Quản Lý Danh Mục', 'STAFF': 'Xem DS Danh Mục' } },
        { link: 'quanlychungloai.html', label: { 'ADMIN': 'Quản Lý Chủng Loại', 'STAFF': 'Xem DS Chủng Loại' } },
        { link: 'quanlysanpham.html', label: { 'ADMIN': 'Quản Lý Sản Phẩm', 'STAFF': 'Xem DS Sản Phẩm' } },
        { link: 'quanlytaikhoan.html', label: { 'ADMIN': 'Quản Lý Tài Khoản', 'STAFF': 'Xem DS Tài Khoản' } },
        { link: 'quanlydonhang.html', label: { 'ADMIN': 'Quản Lý Đơn Hàng', 'STAFF': 'Quản Lý Đơn Hàng' } },
        { link: 'quanlykhuyenmai.html', label: { 'ADMIN': 'Quản Lý Khuyến Mãi', 'STAFF': 'Xem DS Khuyến Mãi' } },
        { link: 'quanlydanhgia.html', label: { 'ADMIN': 'Quản Lý Đánh Giá', 'STAFF': 'Xem DS Đánh Giá' } },
    ];

    $scope.accountInfo = null;
    var storedAccountInfo = localStorage.getItem('accountDetail');
    if (storedAccountInfo) {
        $scope.accountInfo = JSON.parse(storedAccountInfo);
    }

    $scope.login = function () {
        var loginData = {
            username: $scope.username,
            password: $scope.password
        };

        $http.post('http://localhost:8080/api/v1/auth/login', loginData)
            .then(function (response) {
                // Handle success
                console.log('Login successful:', response.data);

                // Store the JWT token
                var token = response.data.accessToken;
                localStorage.setItem('jwtToken', JSON.stringify(token));
                var accountDetail = response.data.account;
                localStorage.setItem('accountDetail', JSON.stringify(accountDetail));
                if (accountDetail.role == "CUSTOMER"){
                    $scope.errorMessage = 'Bạn không có quyền truy cập.';
                }else {
                    window.location.href = '../index.html';
                }
            })
            .catch(function (error) {
                // Handle error
                console.error('Login failed:', error);
                $scope.errorMessage = 'Tài khoản hoặc mật khẩu không đúng.';
            });
    };

    $scope.logout = function() {
        localStorage.removeItem('jwtToken');
        localStorage.removeItem('accountDetail');
        $scope.isLogin = false;
        // redirect to login page or reload the page
        window.location.href = '../pages/login.html';
    };
}]);
