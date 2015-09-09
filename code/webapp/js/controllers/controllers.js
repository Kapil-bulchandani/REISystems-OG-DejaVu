var dejaVuControllers = angular.module('dejaVuControllers', []);

dejaVuControllers.controller('FormListController', ['$scope', 'DejaVuForm',
    function($scope, DejaVuForm) {
        //$scope.forms = DejaVuForm.query();
        //  TODO: Testing and development purposes. Remove once database is populated
        $scope.forms = [{formId: "1", form: "i-130", applicant: {"name": "Viktor Pylypenko"}}, {formId: "2", form: "i-140", applicant: {"name": "John Doe"}}, {formId: "3", form: "i-131", applicant: {"name": "Bruce Wayne"}}];
    }
]);

dejaVuControllers.controller('FormDetailController', ['$scope', '$routeParams', 'DejaVuForm',
    function($scope, $routeParams, DejaVuForm) {
        //$scope.currentForm = DejaVuForm.get({formId: $routeParams.formId});
        //  TODO: Testing and development purposes. Remove once database is populated
        $scope.currentForm = {formId: "1", form: "i-130", applicant: {"name": "Viktor Pylypenko"}};
    }
]);

dejaVuControllers.controller('FormTemplateController', ['$scope',
    function($scope) {
        $scope.templates = {
            'i-130': 'js/partials/forms/i-130.html',
            'i-131': 'js/partials/forms/i-131.html',
            'i-140': 'js/partials/forms/i-140.html'
        };
        $scope.template = $scope.templates[$scope.currentForm.form];
    }
]);