angular.module('app')
    .service('StatisticsService', ['$http', function($http) {
        var baseUrl = 'http://localhost:8080/api/statistics';

        var loginToken = localStorage.getItem('jwtToken');

        var config = {
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + loginToken.replace(/"/g, '').trim()
            }
        };

        function formatDateToISO(date) {
            var d = new Date(date);
            var day = d.getUTCDate();
            var month = d.getUTCMonth() + 1;
            var year = d.getUTCFullYear();
            month = month < 10 ? '0' + month : month;
            day = day < 10 ? '0' + day : day;
            return year + '-' + month + '-' + day;
        }

        function formatMonthToISO(date) {
            var d = new Date(date);
            var month = d.getUTCMonth() + 1;
            var year = d.getUTCFullYear();
            month = month < 10 ? '0' + month : month;
            return year + '-' + month;
        }

        function handleResponse(response) {
            return response.data !== null ? response.data : 0;
        }

        function handleError(error) {
            console.error('Error fetching data', error);
            return 0;
        }

        this.getDailyRevenue = function(date) {
            var formattedDate = formatDateToISO(date);
            return $http.get(baseUrl + '/daily-revenue/' + formattedDate, config)
                .then(handleResponse)
                .catch(handleError);
        };

        this.getDailyOrdersCount = function(date) {
            var formattedDate = formatDateToISO(date);
            return $http.get(baseUrl + '/daily-orders-count/' + formattedDate, config)
                .then(handleResponse)
                .catch(handleError);
        };

        this.getDailyProductsSoldCount = function(date) {
            var formattedDate = formatDateToISO(date);
            return $http.get(baseUrl + '/daily-products-sold-count/' + formattedDate, config)
                .then(handleResponse)
                .catch(handleError);
        };

        this.getMonthlyRevenue = function(month) {
            var formattedMonth = formatMonthToISO(month);
            return $http.get(baseUrl + '/monthly-revenue/' + formattedMonth, config)
                .then(handleResponse)
                .catch(handleError);
        };

        this.getMonthlyOrdersCount = function(month) {
            var formattedMonth = formatMonthToISO(month);
            return $http.get(baseUrl + '/monthly-orders-count/' + formattedMonth, config)
                .then(handleResponse)
                .catch(handleError);
        };

        this.getMonthlyProductsSoldCount = function(month) {
            var formattedMonth = formatMonthToISO(month);
            return $http.get(baseUrl + '/monthly-products-sold-count/' + formattedMonth, config)
                .then(handleResponse)
                .catch(handleError);
        };

        this.getTotalAccounts = function() {
            return $http.get(baseUrl + '/total-accounts', config)
                .then(handleResponse)
                .catch(handleError);
        };

        this.getTotalOrders = function() {
            return $http.get(baseUrl + '/total-orders', config)
                .then(handleResponse)
                .catch(handleError);
        };

        this.getTotalRevenue = function() {
            return $http.get(baseUrl + '/total-revenue', config)
                .then(handleResponse)
                .catch(handleError);
        };
    }]);
