angular.module('app')
    .controller('VoucherController', ['$scope', '$timeout', 'VoucherService', function($scope, $timeout, VoucherService) {
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

        $scope.getVouchers = function(page, size) {
            VoucherService.getAllVouchersPage(page, size)
                .then(function(data) {
                    $scope.vouchers = data.content;
                    $scope.totalPages = data.totalPages;
                    initializePagination();
                })
                .catch(function(error) {
                    console.error('Error fetching vouchers', error);
                });
        };

        $scope.editVoucher = function(id) {
            VoucherService.getVoucherById(id)
                .then(function(data) {
                    $scope.voucher = data;
                    $scope.voucher.validFrom = new Date(data.validFrom); // Chuyển đổi thành đối tượng Date
                    $scope.voucher.validTo = new Date(data.validTo); // Chuyển đổi thành đối tượng Date
                    $scope.isEditMode = true;
                    $scope.message = '';
                })
                .catch(function(error) {
                    console.error('Error fetching voucher', error);
                });
        };

        $scope.createVoucher = function() {
            $scope.voucher.createDate = new Date();
            VoucherService.createVoucher($scope.voucher)
                .then(function(data) {
                    $scope.voucher = data;
                    $scope.getVouchers($scope.currentPage, $scope.pageSize);
                    $scope.highlightVoucher(data.id);
                    $scope.resetForm();
                })
                .catch(function(error) {
                    console.error('Error creating voucher', error);
                });
        };

        $scope.updateVoucher = function() {
            VoucherService.updateVoucher($scope.voucher.id, $scope.voucher)
                .then(function(data) {
                    $scope.voucher = data;
                    $scope.getVouchers($scope.currentPage, $scope.pageSize);
                    $scope.highlightVoucher(data.id);
                    $scope.resetForm();
                })
                .catch(function(error) {
                    console.error('Error updating voucher', error);
                });
        };

        $scope.deleteVoucher = function(id) {
            VoucherService.deleteVoucher(id)
                .then(function(data) {
                    $scope.getVouchers($scope.currentPage, $scope.pageSize);
                    $scope.voucher = {};
                    $scope.isEditMode = false;
                })
                .catch(function(error) {
                    console.error('Error deleting voucher', error);
                });
        };

        $scope.resetForm = function() {
            $scope.voucher = {};
            $scope.isEditMode = false;
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

        $scope.getVouchers($scope.currentPage, $scope.pageSize);

        $scope.highlightVoucher = function(voucherId) {
            $scope.highlightedVoucherId = voucherId;
            $timeout(function() {
                $scope.highlightedVoucherId = null;
            }, 5000);
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
                $scope.getVouchers($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.nextPage = function() {
            if ($scope.currentPage < $scope.totalPages - 1) {
                $scope.currentPage++;
                $scope.getVouchers($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage > 1) {
                    initializePagination();
                }
            }
        };

        $scope.previousPage = function() {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                $scope.getVouchers($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage < $scope.totalPages - 2) {
                    initializePagination();
                }
            }
        };
    }]);
