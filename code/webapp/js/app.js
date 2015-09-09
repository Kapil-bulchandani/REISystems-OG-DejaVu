var dejaVuApp = angular.module('dejaVuApp', [
    'ngRoute',
    'dejaVuControllers',
    'dejaVuFilters',
    'dejaVuServices'
]);

dejaVuApp.config(['$routeProvider',
    function($routeProvider) {
        $routeProvider.when('/forms', {
                templateUrl: 'js/partials/form-list.html',
                controller: 'FormListController'
            }).when('/forms/:formId', {
                templateUrl: 'js/partials/form-detail.html',
                controller: 'FormDetailController'
            }).otherwise({
                redirectTo: '/forms'
            });
    }
]);
