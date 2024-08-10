angular.module('app')
    .controller('AccountController', ['$scope', '$timeout', 'AccountService', function ($scope, $timeout, AccountService) {
        $scope.currentPage = 0;
        $scope.pageSize = 8;
        $scope.totalPages = 1;
        $scope.accounts = [];
        $scope.paginationButtons = [];
        $scope.account = {};
        $scope.isAddMode = false;
        $scope.showPasswordInputs = false;
        $scope.highlightedAccountId = null;
        $scope.confirmPassword = '';
        $scope.usernameError = '';
        $scope.passwordError = '';
        $scope.confirmPasswordError = '';
        $scope.emailError = '';
        $scope.phoneError = '';
        $scope.fullnameError = '';
        $scope.addressError = '';
        $scope.message = '';
        $scope.isSuccess = false;
        $scope.addAccountSuccess = false;

        function getAccounts (page, size) {
            return AccountService.getAllAccounts(page, size)
                .then(function (data) {
                    $scope.accounts = data.content;
                    $scope.totalPages = data.totalPages;
                    initializePagination();
                })
                .catch(function (error) {
                    console.error('Error fetching accounts', error);
                });
        };

        $scope.editAccount = function (id) {
            AccountService.getAccountById(id)
                .then(function (data) {
                    $scope.account = data;
                    $scope.message = '';
                })
                .catch(function (error) {
                    console.error('Error fetching account', error);
                });
        };

        getAccounts($scope.currentPage, $scope.pageSize);

        $scope.createAccount = function () {
            $scope.checkUsername($scope.account.username);
            $scope.checkPassword($scope.account.password);
            $scope.checkConfirmPassword($scope.confirmPassword);
            $scope.checkEmail($scope.account.email);
            $scope.checkFullName($scope.account.fullName);
            $scope.checkAddress($scope.account.address);
            $scope.checkPhone($scope.account.phone);

            if ($scope.usernameError || $scope.passwordError || $scope.confirmPasswordError || $scope.emailError || $scope.phoneError || $scope.fullnameError || $scope.addressError) {
                handleError('Vui lòng sửa lỗi trước khi thêm tài khoản.');
                return;
            }

            $scope.account.role = "Employee";
            AccountService.createAccount($scope.account)
                .then(function (data) {
                    getAccounts($scope.currentPage, $scope.pageSize)
                        . then(function () {
                            $scope.goToPage($scope.totalPages - 1);
                            $scope.highlightAccountId(data.id);
                            $scope.toggleForm();
                            $scope.editAccount(data.id);
                            $scope.addAccountSuccess = true;
                        });
                })
                .catch(function (error) {
                    handleError('Có lỗi xảy ra khi thêm nhân viên.');
                });
        };

        $scope.resetForm = function () {
            $scope.account = {};
            $scope.usernameError = '';
            $scope.passwordError = '';
            $scope.confirmPassword = '';
            $scope.confirmPasswordError = '';
            $scope.emailError = '';
            $scope.phoneError = '';
            $scope.fullnameError = '';
            $scope.addressError = '';
            $scope.message = '';
            $scope.addAccountSuccess = false;
        };

        function handleError(message) {
            $scope.message = message;
            $scope.isSuccess = false;
        }

        $scope.toggleForm = function () {
            $scope.isAddMode = !$scope.isAddMode;
            $scope.showPasswordInputs = $scope.isAddMode;
            $scope.resetForm();
        };

        $scope.checkUsername = function(username) {
            if (!username) {
                $scope.usernameError = 'Tên đăng nhập không được bỏ trống.';
            } else if (username.length < 6) {
                $scope.usernameError = 'Tên đăng nhập phải lớn hơn 6 kí tự.';
            } else {
                AccountService.checkUsernameExists(username)
                    .then(function(exists) {
                        $scope.usernameError = exists ? 'Tên đăng nhập đã tồn tại.' : '';
                    })
                    .catch(function(error) {
                        console.error('Error checking username', error);
                    });
            }
        };

        $scope.checkPassword = function(password) {
            if (!password) {
                $scope.passwordError = 'Mật khẩu không được bỏ trống.';
            } else if (password.length < 8 || !/\d/.test(password) || !/[a-zA-Z]/.test(password)) {
                $scope.passwordError = 'Mật khẩu phải có ít nhất 8 kí tự, bao gồm chữ và số.';
            } else {
                $scope.passwordError = '';
            }
        };

        $scope.checkEmail = function(email) {
            // Xử lý trường hợp email là undefined hoặc null
            email = email || '';
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;

            if (email.trim() === '') {
                $scope.emailError = 'Email không được bỏ trống.';
            } else if (!emailRegex.test(email)) {
                $scope.emailError = 'Định dạng email không hợp lệ.';
            } else {
                AccountService.checkEmailExists(email)
                    .then(function(exists) {
                        $scope.emailError = exists ? 'Email đã tồn tại.' : '';
                    })
                    .catch(function(error) {
                        console.error('Error checking email', error);
                    });
            }
        };

        $scope.checkPhone = function(phone) {
            if (!phone) {
                $scope.phoneError = 'Số điện thoại không được bỏ trống.';
            } else {
                var phoneRegex = /^(03|05|07|08|09|01[2|6|8|9])+([0-9]{8})$/;
                if (!phoneRegex.test(phone)) {
                    $scope.phoneError = 'Số điện thoại không hợp lệ.';
                } else {
                    AccountService.checkPhoneExists(phone)
                        .then(function(exists) {
                            $scope.phoneError = exists ? 'Số điện thoại đã tồn tại.' : '';
                        })
                        .catch(function(error) {
                            console.error('Error checking phone', error);
                        });
                }
            }
        };

        $scope.checkConfirmPassword = function(confirmPassword) {
            if (!confirmPassword) {
                $scope.confirmPasswordError = 'Nhập lại mật khẩu không được bỏ trống.';
            } else if ($scope.account.password !== confirmPassword) {
                $scope.confirmPasswordError = 'Mật khẩu không khớp.';
            } else {
                $scope.confirmPasswordError = '';
            }
        };

        $scope.checkFullName = function(fullName) {
            if (!fullName) {
                $scope.fullnameError = 'Họ và tên không được bỏ trống.';
            } else {
                $scope.fullnameError = '';
            }
        };

        $scope.checkAddress = function(address) {
            if (!address) {
                $scope.addressError = 'Địa chỉ không được bỏ trống.';
            } else {
                $scope.addressError = '';
            }
        };

        $scope.highlightAccountId = function (accountId) {
            $scope.highlightedAccountId = accountId;
            $timeout(function () {
                $scope.highlightedAccountId = null;
            }, 5000);
        };

        var initializePagination = function () {
            $scope.paginationButtons = [];
            var start = Math.max(0, $scope.currentPage - 1);
            var end = Math.min($scope.totalPages - 1, start + 2);
            for (var i = start; i <= end; i++) {
                $scope.paginationButtons.push(i);
            }
        };

        $scope.goToPage = function (page) {
            if (page >= 0 && page < $scope.totalPages) {
                $scope.currentPage = page;
                getAccounts($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.nextPage = function () {
            if ($scope.currentPage < $scope.totalPages - 1) {
                $scope.currentPage++;
                getAccounts($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage > 1) {
                    initializePagination();
                }
            }
        };

        $scope.previousPage = function () {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                getAccounts($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage < $scope.totalPages - 2) {
                    initializePagination();
                }
            }
        };
    }]);