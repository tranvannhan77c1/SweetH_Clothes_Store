angular.module('app')
    .controller('StatisticsController', ['$scope', 'StatisticsService', function ($scope, StatisticsService) {

        $scope.dailyRevenue = 0;
        $scope.dailyOrdersCount = 0;
        $scope.dailyProductsSoldCount = 0;

        $scope.monthlyRevenue = 0;
        $scope.monthlyOrdersCount = 0;
        $scope.monthlyProductsSoldCount = 0;

        $scope.totalAccounts = 0;
        $scope.totalOrders = 0;
        $scope.totalRevenue = 0;

        function formatDateToISO(date) {
            var d = new Date(date);
            var day = d.getDate();
            var month = d.getMonth() + 1;
            var year = d.getFullYear();

            month = month < 10 ? '0' + month : month;
            day = day < 10 ? '0' + day : day;

            return year + '-' + month + '-' + day;
        }

        function formatMonthToISO(date) {
            var d = new Date(date);
            var month = d.getMonth() + 1;
            var year = d.getFullYear();
            month = month < 10 ? '0' + month : month;
            return year + '-' + month;
        }

        $scope.getDailyStatistics = function(date) {
            var formattedDate = formatDateToISO(date);
            StatisticsService.getDailyRevenue(formattedDate).then(function(data) {
                $scope.dailyRevenue = data;
            });

            StatisticsService.getDailyOrdersCount(formattedDate).then(function(data) {
                $scope.dailyOrdersCount = data;
            });

            StatisticsService.getDailyProductsSoldCount(formattedDate).then(function(data) {
                $scope.dailyProductsSoldCount = data;
            });
        };

        $scope.getMonthlyStatistics = function(month) {
            var formattedMonth = formatMonthToISO(month);
            StatisticsService.getMonthlyRevenue(formattedMonth).then(function(data) {
                $scope.monthlyRevenue = data;
            });

            StatisticsService.getMonthlyOrdersCount(formattedMonth).then(function(data) {
                $scope.monthlyOrdersCount = data;
            });

            StatisticsService.getMonthlyProductsSoldCount(formattedMonth).then(function(data) {
                $scope.monthlyProductsSoldCount = data;
            });
        };

        $scope.getTotalStatistics = function() {
            StatisticsService.getTotalAccounts().then(function(data) {
                $scope.totalAccounts = data;
            });

            StatisticsService.getTotalOrders().then(function(data) {
                $scope.totalOrders = data;
            });

            StatisticsService.getTotalRevenue().then(function(data) {
                $scope.totalRevenue = data;
            });
        };

        // Format dates for API calls
        var today = new Date();
        $scope.dailyDate = formatDateToISO(today);
        $scope.monthlyMonth = formatMonthToISO(today);

        // Load default statistics
        $scope.getDailyStatistics($scope.dailyDate);
        $scope.getMonthlyStatistics($scope.monthlyMonth);

        // Watch for changes in the input fields
        $scope.$watch('monthlyMonth', function(newValue) {
            if (newValue) {
                $scope.getMonthlyStatistics(newValue);
            }
        });

        $scope.$watch('dailyDate', function(newValue) {
            if (newValue) {
                $scope.getDailyStatistics(newValue);
            }
        });

        $scope.dailyDate = new Date();
        $scope.monthlyMonth = new Date();

        $scope.getTotalStatistics();
    }]);

