angular.module('app')
    .controller('VoucherController', ['$scope', '$timeout', 'VoucherService', function ($scope, $timeout, VoucherService) {

        $scope.currentPage = 0;
        $scope.pageSize = 8;
        $scope.totalPages = 1;
        $scope.vouchers = [];
        $scope.paginationButtons = [];
        $scope.voucher = {};
        $scope.isEditMode = false;
        $scope.highlightedVoucherId = null;
        $scope.message = '';
        $scope.isSuccess = false;
        $scope.codenofi = '';
        $scope.discountAmountnofi = '';
        $scope.conditionnofi = '';
        $scope.validFromnofi = '';
        $scope.validTonofi = '';
        $scope.isCodeSuccess = false;
        $scope.codeEdit = '';

        function getVouchers(page, size) {
            return VoucherService.getAllVouchersPage(page, size)
                .then(function (data) {
                    $scope.vouchers = data.content;
                    $scope.totalPages = data.totalPages;
                    initializePagination();
                })
                .catch(function (error) {
                    console.error('Error fetching vouchers', error);
                });
        };

        $scope.editVoucher = function (id) {
            $scope.resetForm();
            VoucherService.getVoucherById(id)
                .then(function (data) {
                    $scope.voucher = data;
                    $scope.voucher.validFrom = new Date(data.validFrom);
                    $scope.voucher.validTo = new Date(data.validTo);
                    $scope.voucher.createDate = new Date(data.createDate);
                    $scope.isEditMode = true;
                    $scope.codeEdit = $scope.voucher.code;
                })
                .catch(function (error) {
                    console.error('Error fetching voucher', error);
                });
        };

        $scope.createVoucher = function () {
            $scope.checkCode($scope.voucher.code);
            $scope.checkDiscountAmount($scope.voucher.discountAmount);
            $scope.checkCondition($scope.voucher.condition);
            $scope.checkValidFrom($scope.voucher.validFrom);
            $scope.checkValidTo($scope.voucher.validTo);

            if ($scope.codenofi != 'Mã khuyến mãi hợp lệ.'){
                if ($scope.codenofi || $scope.discountAmountnofi || $scope.conditionnofi || $scope.validFromnofi || $scope.validTonofi) {
                    handleError('Vui lòng sửa lỗi trước khi thêm khuyến mãi!');
                    return;
                }
            }

            VoucherService.createVoucher($scope.voucher)
                .then(function (data) {
                    getVouchers($scope.currentPage, $scope.pageSize)
                        .then(function () {
                            $scope.goToPage($scope.totalPages - 1);
                            $scope.highlightVoucher(data.id);
                            $scope.voucher = data;
                            $scope.isEditMode = true;
                            handleSuccess('Thêm khuyến mãi thành công!');
                        });
                })
                .catch(function (error) {
                    console.error('Error creating voucher', error);
                });

        };

        $scope.updateVoucher = function () {
            $scope.checkCode($scope.voucher.code);
            $scope.checkDiscountAmount($scope.voucher.discountAmount);
            $scope.checkCondition($scope.voucher.condition);
            $scope.checkValidFrom($scope.voucher.validFrom);
            $scope.checkValidTo($scope.voucher.validTo);

            if ($scope.codenofi != 'Mã khuyến mãi hợp lệ.'){
                    if ($scope.codenofi || $scope.discountAmountnofi || $scope.conditionnofi || $scope.validFromnofi || $scope.validTonofi) {
                        if(!$scope.isCodeSuccess){
                            handleError('Vui lòng sửa lỗi trước khi cập nhập khuyến mãi!');
                            return;
                        }
                    }
            }

            VoucherService.updateVoucher($scope.voucher.id, $scope.voucher)
                .then(function (data) {
                    $scope.voucher = data;
                    getVouchers($scope.currentPage, $scope.pageSize);
                    $scope.highlightVoucher(data.id);
                    handleSuccess('Cập nhập khuyến mãi thành công!');
                    $scope.codenofi = '';
                })
                .catch(function (error) {
                    console.error('Error updating voucher', error);
                });

        };

        $scope.deleteVoucher = function (id) {
            VoucherService.deleteVoucher(id)
                .then(function (data) {
                    getVouchers($scope.currentPage, $scope.pageSize);
                    $scope.voucher = {};
                    $scope.isEditMode = false;
                    handleSuccess('Xoá khuyến mãi thành công!');
                })
                .catch(function (error) {
                    handleError('Xoá khuyến mãi không thành công!');
                    console.error('Error deleting voucher', error);
                });
        };

        $scope.checkCode = function (code) {
            if (!code) {
                $scope.codenofi = 'Mã khuyến mãi không được bỏ trống.';
                $scope.isCodeSuccess = false;
                return;
            }

            if ($scope.isEditMode && code === $scope.codeEdit) {
                $scope.codenofi = '';
                $scope.isCodeSuccess = true;
                return;
            }

            code = code.toUpperCase();
            $scope.voucher.code = code;

            if (code.length > 10) {
                $scope.codenofi = 'Mã khuyến mãi không được vượt quá 10 ký tự.';
                $scope.isCodeSuccess = false;
                return;
            }

            if (/[^A-Z0-9]/.test(code)) {
                $scope.codenofi = 'Mã khuyến mãi không được chứa ký tự đặc biệt.';
                $scope.isCodeSuccess = false;
                return;
            }

            VoucherService.checkVoucherCode(code, $scope.isEditMode ? $scope.voucher.id : null)
                .then(function (exists) {
                    if (exists && (!($scope.isEditMode && code === $scope.codeEdit))) {
                        $scope.codenofi = 'Mã khuyến mãi đã tồn tại!';
                        $scope.isCodeSuccess = false;
                    } else {
                        $scope.codenofi = 'Mã khuyến mãi hợp lệ.';
                        $scope.isCodeSuccess = true;
                        $timeout(function () {
                            $scope.codenofi = '';
                        }, 5000);
                    }
                })
                .catch(function (error) {
                    console.error('Error checking voucher code', error);
                    $scope.codenofi = 'Đã xảy ra lỗi khi kiểm tra mã khuyến mãi.';
                    $scope.isCodeSuccess = false;
                });
        };


        $scope.checkDiscountAmount = function (discountAmount) {
            if (!discountAmount) {
                $scope.discountAmountnofi = 'Số tiền khuyến mãi không được bỏ trống.';
            } else if (discountAmount <= 0) {
                $scope.discountAmountnofi = 'Số tiền khuyến mãi không được nhỏ hơn 0.';
            } else if (discountAmount > 99999999.99) {
                $scope.discountAmountnofi = 'Số tiền khuyến mãi không được vượt quá 99.999.999.';
            } else {
                $scope.discountAmountnofi = '';
            }

            if (!$scope.discountAmountnofi && $scope.voucher.condition) {
                $scope.checkCondition($scope.voucher.condition);
            }
        };


        $scope.checkCondition = function (condition) {
            if (!condition) {
                $scope.conditionnofi = 'Điều kiện khuyến mãi không được bỏ trống.';
            } else if (condition <= 0) {
                $scope.conditionnofi = 'Điều kiện khuyến mãi không được nhỏ hơn 0.';
            } else if ($scope.voucher.discountAmount && condition < $scope.voucher.discountAmount) {
                $scope.conditionnofi = 'Điều kiện không được nhỏ hơn số tiền khuyến mãi.';
            } else if (condition > 99999999.99) {
                $scope.conditionnofi = 'Điều kiện khuyến mãi không được vượt quá 99.999.999.';
            } else {
                $scope.conditionnofi = '';
            }
        };


        $scope.checkValidFrom = function (validFrom) {
            let now = new Date();
            now.setHours(0, 0, 0, 0);

            let validFromDate = new Date(validFrom);
            validFromDate.setHours(0, 0, 0, 0);

            if (!validFrom) {
                $scope.validFromnofi = 'Áp Dụng Từ không được bỏ trống.';
            } else if (!$scope.isEditMode && validFromDate < now) {
                $scope.validFromnofi = 'Áp Dụng Từ không được nhỏ hơn ngày hiện tại.';
                $scope.checkValidTo($scope.voucher.validTo);
            } else {
                $scope.validFromnofi = '';
            }

            if (!$scope.validFromnofi && $scope.voucher.validTo) {
                $scope.checkValidTo($scope.voucher.validTo);
            }
        };

        $scope.checkValidTo = function (validTo) {
            let now = new Date();
            now.setHours(0, 0, 0, 0);

            let validToDate = new Date(validTo);
            validToDate.setHours(0, 0, 0, 0);

            if (!validTo) {
                $scope.validTonofi = 'Áp Dụng Đến không được bỏ trống.';
            } else if (!$scope.isEditMode && validToDate < now) {
                $scope.validTonofi = 'Áp Dụng Đến không được nhỏ hơn ngày hiện tại.';
            } else if (validToDate <= new Date($scope.voucher.validFrom)) {
                $scope.validTonofi = 'Áp Dụng Đến phải lớn hơn Áp Dụng Từ.';
            } else {
                $scope.validTonofi = '';
            }
        };


        $scope.resetForm = function () {
            $scope.voucher = {};
            $scope.isEditMode = false;
            $scope.codenofi = '';
            $scope.discountAmountnofi = '';
            $scope.conditionnofi = '';
            $scope.validFromnofi = '';
            $scope.validTonofi = '';
            $scope.message = '';
        };

        function handleSuccess(message) {
            $scope.message = message;
            $scope.isSuccess = true;
        }

        function handleError(message) {
            $scope.message = message;
            $scope.isSuccess = false;
        }

        getVouchers($scope.currentPage, $scope.pageSize);

        $scope.highlightVoucher = function (voucherId) {
            $scope.highlightedVoucherId = voucherId;
            $timeout(function () {
                $scope.highlightedVoucherId = null;
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
                getVouchers($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.nextPage = function () {
            if ($scope.currentPage < $scope.totalPages - 1) {
                $scope.currentPage++;
                getVouchers($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage > 1) {
                    initializePagination();
                }
            }
        };

        $scope.previousPage = function () {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                getVouchers($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage < $scope.totalPages - 2) {
                    initializePagination();
                }
            }
        };
    }]);
