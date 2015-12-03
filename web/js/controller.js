'use strict';

var controllers = angular.module('controllers', []);

controllers.controller('MainController', ['$scope', '$location', '$window',
    function ($scope, $location, $window) {
        $scope.loggedIn = function () {
            return Boolean($window.sessionStorage.access_token);
        };

        $scope.logout = function () {
            delete $window.sessionStorage.access_token;
            delete $window.sessionStorage.search_history;
            $scope.search.city = '';
            $location.path('/login').replace();
        };

        $scope.search = {city: ''};
    }
]);

controllers.controller('DashboardController', ['$scope', '$http', '$window', '$location',
    function ($scope, $http, $window, $location) {
        $http.get('api/dashboard').success(function (data) {
            $scope.dashboard = data;
        });

        //Data
        $scope.tweets = [];
        $scope.cities = [];
        var mapOptions = {
            zoom: 6,
            center: new google.maps.LatLng(40.0000, -98.0000),
            mapTypeId: google.maps.MapTypeId.TERRAIN,
            mapTypeControl: true,
            mapTypeControlOptions: {
                style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR,
                position: google.maps.ControlPosition.TOP_CENTER
            },
            zoomControl: true,
            zoomControlOptions: {
                position: google.maps.ControlPosition.LEFT_TOP
            },
            scaleControl: true,
            streetViewControl: true,
            streetViewControlOptions: {
                position: google.maps.ControlPosition.LEFT_TOP
            }
        };

        $scope.map = new google.maps.Map(document.getElementById('map'), mapOptions);
        google.maps.event.addDomListener(window, "resize", function () {
            var center = $scope.map.getCenter();
            google.maps.event.trigger($scope.map, "resize");
            $scope.map.setCenter(center);
        });

        var geocoder = new google.maps.Geocoder();

        $scope.onSearch = function () {
            geocodeAddress(geocoder, $scope.map);
        };

        if ($scope.search.city) {
            geocodeAddress(geocoder, $scope.map);
        }

        function geocodeAddress(geocoder, resultsMap) {

            geocoder.geocode({'address': $scope.search.city}, function (results, status) {
                if (status === google.maps.GeocoderStatus.OK) {
                    clearOverlays();//clear all markers before add new one
                    resultsMap.setCenter(results[0].geometry.location);
                    $scope.coordinate = {latitude: results[0].geometry.location.lat(), longitude: results[0].geometry.location.lng(), city: $scope.search.city};

                    if (!$window.sessionStorage.search_history) {
                        $scope.cities.push($scope.search.city);
                        $window.sessionStorage.search_history = JSON.stringify({cities: $scope.cities});
                    } else {
                        $scope.history = JSON.parse($window.sessionStorage.search_history);
                        if ($scope.history.cities.indexOf($scope.search.city) === -1) {
                            $scope.history.cities.push($scope.city);
                        }
                        $window.sessionStorage.search_history = JSON.stringify({cities: $scope.history.cities});
                    }

                    $http.post('api/tweets', $scope.coordinate).success(
                            function (data) {
                                if (data.success) {
                                    $scope.tweets = data.result;
                                    for (var i = 0; i < $scope.tweets.length; i++) {
                                        createMarker($scope.tweets[i]);
                                    }
                                } else {
                                    alert('Can not search tweets at the moment');
                                }
                            }).error(
                            function (data) {
                                alert('Can not search tweets at the moment');
                            }
                    );
                } else {
                    alert('Geocode was not successful for the following reason: ' + status);
                }
            });
        }

        $scope.markers = [];

        var infoWindow = new google.maps.InfoWindow();

        var createMarker = function (info) {
            var marker = new google.maps.Marker({
                map: $scope.map,
                position: new google.maps.LatLng(info.lat, info.long),
                created_at: info.created_at,
                shape: {coords: [17, 17, 18], type: 'circle'},
                icon: {
                    url: info.avatar
                },
                optimized: false
            });
            marker.content = '<div class="infoWindowContent">' + info.desc + '</div>';
            google.maps.event.addListener(marker, 'click', function () {
                infoWindow.setContent(marker.content + '<p>' + marker.created_at + '</p>');
                infoWindow.open($scope.map, marker);
            });
            $scope.markers.push(marker);
        };

        var clearOverlays = function () {
            for (var i = 0; i < $scope.markers.length; i++) {
                $scope.markers[i].setMap(null);
            }
        };

        $scope.onHistory = function () {
            $location.path('/history').replace();
        };
    }
]);

controllers.controller('LoginController', ['$scope', '$http', '$window', '$location',
    function ($scope, $http, $window, $location) {
        $scope.login = function () {
            $scope.submitted = true;
            $scope.error = {};
            $http.post('api/login', $scope.userModel).success(
                    function (data) {
                        //can use cookie to store
                        $window.sessionStorage.access_token = data.access_token;
                        $location.path('/dashboard').replace();
                    }).error(
                    function (data) {
                        angular.forEach(data, function (error) {
                            $scope.error[error.field] = error.message;
                        });
                    }
            );
        };
    }
]);

controllers.controller('HistoryController', ['$scope', '$http', '$window', '$location',
    function ($scope, $http, $window, $location) {
        $scope.cities = [];
        if ($window.sessionStorage.search_history) {
            $scope.history = JSON.parse($window.sessionStorage.search_history);
            $scope.cities = $scope.history.cities;
        }

        $scope.onDashBoard = function (city) {
            $scope.search.city = city;
            $location.path('/dashboard').replace();
        };
    }
]);