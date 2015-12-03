'use strict';

var app = angular.module('app', [
    'ngRoute', //$routeProvider
    'mgcrea.ngStrap', //bs-navbar, data-match-route directives
    'ui.bootstrap',
    'controllers'       //Our module frontend/web/js/controllers.js
]);

app.config(['$routeProvider', '$httpProvider',
    function ($routeProvider, $httpProvider) {
        $routeProvider.
                when('/', {
                    templateUrl: 'partials/index.html'
                }).
                when('/login', {
                    templateUrl: 'partials/login.html',
                    controller: 'LoginController'
                }).
                when('/dashboard', {
                    templateUrl: 'partials/dashboard.html',
                    controller: 'DashboardController'
                }).
                when('/history', {
                    templateUrl: 'partials/history.html',
                    controller: 'HistoryController'
                }).
                otherwise({
                    templateUrl: 'partials/404.html'
                });
        $httpProvider.interceptors.push('authInterceptor');
    }
]);

app.factory('authInterceptor', function ($q, $window, $location) {
    return {
        request: function (config) {
            if ($window.sessionStorage.access_token) {
                //HttpBearerAuth
                config.headers.Authorization = 'Bearer ' + $window.sessionStorage.access_token;
            }
            return config;
        },
        responseError: function (rejection) {
            if (rejection.status === 401) {
                $location.path('/login').replace();
            }
            return $q.reject(rejection);
        }
    };
});