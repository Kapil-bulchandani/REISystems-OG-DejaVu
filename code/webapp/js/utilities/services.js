var dejaVuServices = angular.module('dejaVuServices', ['ngResource']);

dejaVuServices.factory('DejaVuForm', ['$resource',
    function($resource){
        return $resource('', {}, {
            query: {method:'GET', params:{formId:'forms'}, isArray:true},
            get: {method:'GET', params:{formId:'forms'}, isArray:true}
        });
    }
]);
