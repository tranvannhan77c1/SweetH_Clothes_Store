angular.module('app')
    .controller('OrderController', ['$scope', 'OrderService', function($scope, OrderService) {

        $scope.currentPage = 0;
        $scope.pageSize = 8;
        $scope.totalPages = 1;
        $scope.orders = [];
        $scope.paginationButtons = [];
        $scope.orderDetails = [];

        $scope.getOrdersPage = function(page, size) {
            OrderService.getOrdersPage(page, size)
                .then(function(data) {
                    $scope.orders = data.content;
                    $scope.totalPages = data.totalPages;
                    initializePagination();
                })
                .catch(function(error) {
                    console.error('Error fetching orders', error);
                });
        };

        $scope.getOrdersPage($scope.currentPage, $scope.pageSize);

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
                $scope.getOrdersPage($scope.currentPage, $scope.pageSize);
            }
        };

        $scope.nextPage = function() {
            if ($scope.currentPage < $scope.totalPages - 1) {
                $scope.currentPage++;
                $scope.getOrdersPage($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage > 1) {
                    initializePagination();
                }
            }
        };

        $scope.previousPage = function() {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
                $scope.getOrdersPage($scope.currentPage, $scope.pageSize);
                if ($scope.currentPage < $scope.totalPages - 2) {
                    initializePagination();
                }
            }
        };

        $scope.getOrderDetails = function(orderId) {
            OrderService.getOrderDetails(orderId)
                .then(function(orderDetails) {
                    $scope.orderDetails = orderDetails;
                    $('#orderDetailModal').modal('show');
                })
                .catch(function(error) {
                    console.error('Error fetching order details', error);
                });
        };

    }]);
