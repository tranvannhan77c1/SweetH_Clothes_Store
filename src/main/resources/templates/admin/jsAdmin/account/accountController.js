angular.module('app')
    .controller('AccountController', ['$scope', 'AccountService', function($scope, AccountService) {

        $scope.currentPage = 0; // Trang hiện tại
        $scope.pageSize = 8; // Kích thước mỗi trang
        $scope.totalPages = 1; // Tổng số trang
        $scope.accounts = []; // Mảng lưu trữ đơn hàng
        $scope.paginationButtons = []; // Mảng lưu trữ các nút phân trang hiển thị
        $scope.account = {}; // Đối tượng account để lưu trữ dữ liệu form
        $scope.isEditMode = false; // Biến để xác định trạng thái làm mới hay không


        $scope.getAccounts = function(page, size) {
            AccountService.getAllAccounts(page, size)
                .then(function(data) {
                    $scope.accounts = data.content;
                    // console.log(data.content);
                    $scope.totalPages = data.totalPages;
                    initializePagination();
                })
                .catch(function(error) {
                    console.error('Error fetching accounts', error);
                });
        };

        $scope.viewAccountDetails = function(id) {
            AccountService.getAccountById(id)
                .then(function(data) {
                    $scope.account = data;
                    console.log(data.content);
                })
                .catch(function(error) {
                    console.error('Error fetching account', error);
                });
        };

        $scope.getAccounts($scope.currentPage, $scope.pageSize);

        // Hàm làm mới form
        $scope.resetForm = function() {
            $scope.account = {}; // Đặt lại giá trị của đối tượng account
            $scope.isEditMode = true; // Cho phép nhập liệu
            $scope.showPasswordInputs = true;
            $scope.confirmPassword = '';
        };

        $scope.addEmployee = function() {
            // Kiểm tra mật khẩu và nhập lại mật khẩu có khớp nhau không
            if ($scope.account.password !== $scope.confirmPassword) {
                alert('Mật khẩu và nhập lại mật khẩu không khớp.');
                return;
            }
            // Thiết lập role mặc định là "Employee"
            $scope.account.role = "Employee";

            // Gọi service để thực hiện thêm nhân viên và xử lý response
            AccountService.addEmployee($scope.account)
                .then(function(response) {
                    // Xử lý khi thêm thành công
                    console.log('Thêm nhân viên thành công:', response);
                    alert('Thêm nhân viên thành công.');
                    // Sau khi thêm thành công, có thể reset form
                    $scope.resetForm();
                })
                .catch(function(error) {
                    // Xử lý khi thêm thất bại
                    console.error('Lỗi khi thêm nhân viên:', error);
                    alert('Lỗi khi thêm nhân viên.');
                });
        };


        var initializePagination = function() {
            $scope.paginationButtons = [];
            var start = Math.max(0, $scope.currentPage - 1);
            var end = Math.min($scope.totalPages - 1, start + 2);
            for (var i = start; i <= end; i++) {
                $scope.paginationButtons.push(i);
            }
        };

        $scope.goToPage = function(page) {
            if (page >= 0 && page < $scope.totalPages) {
                $scope.currentPage = page;
                $scope.getAccounts($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.nextPage = function() {
            if ($scope.currentPage < $scope.totalPages - 1) {
                $scope.currentPage++;
                $scope.getAccounts($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage > 1) {
                    initializePagination();
                }
            }
        };

        $scope.previousPage = function() {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                $scope.getAccounts($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage < $scope.totalPages - 2) {
                    initializePagination();
                }
            }
        };
    }]);
