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

        const validateEmail = (email) => {
            return String(email)
                .toLowerCase()
                .match(
                    /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
                );
        };

        $scope.addEmployee = function() {
            // Kiểm tra mật khẩu và nhập lại mật khẩu có khớp nhau không

            // if (!$scope.account.username ||
            //     !$scope.account.password ||
            //     !$scope.account.email ||
            //     !$scope.account.fullname ||
            //     !$scope.account.phone ||
            //     !$scope.account.address == "") {
            //     alert("Vui lòng nhập đầy đủ thông tin")
            //     return
            // }
            if(!$scope.account.fullname){
                let mess = document.getElementById("fullname_error");
                mess.classList.add("active");
                mess.textContent = "Tên không được để trống"
                return
            }

            if(!$scope.account.password){
                let mess = document.getElementById("password_error");
                mess.classList.add("active");
                mess.textContent = "Mật khẩu không được để trống"
                return
            }

            if(!$scope.account.address){
                let mess = document.getElementById("address_error");
                mess.classList.add("active");
                mess.textContent = "Địa chỉ không được để trống"
                return
            }

            if(!$scope.account.email || !validateEmail($scope.account.email)){
                //alert("Email không đúng định dạng")
                let mess = document.getElementById("email_error");
                mess.classList.add("active");
                mess.textContent = "Email không đúng định dạng"
                return
            }

            if (!$scope.account.username || $scope.account.username.length <= 5){
                //alert('Tài khoản phải có ít nhất 6 kí tự');
                let mess = document.getElementById("username_error");
                mess.classList.add("active");
                mess.textContent = "Tài khoản phải có ít nhất 6 kí tự"
                return

            }


            if($scope.account.password !== $scope.confirmPassword) {
                //alert('Mật khẩu và nhập lại mật khẩu không khớp.');
                let mess = document.getElementById("confirm_password_error");
                mess.classList.add("active");
                mess.textContent = "Mật khẩu và nhập lại mật khẩu không khớp."
                return;
            }

            var regex = /^0\d{9,10}$/;
            if(!regex.test($scope.account.phone)){
                //alert("Số điện thoại không hợp lệ")
                let mess = document.getElementById("phone_error");
                mess.classList.add("active");
                mess.textContent = "Số điện thoại không hợp lệ"
                return
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
