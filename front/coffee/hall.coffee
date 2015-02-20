@.taigaContribPlugins = @.taigaContribPlugins or []

hallInfo = {
    slug: "hall"
    name: "Hall"
    type: "admin"
    module: 'taigaContrib.hall'
}

@.taigaContribPlugins.push(hallInfo)

module = angular.module('taigaContrib.hall', [])

debounce = (wait, func) ->
    return _.debounce(func, wait, {leading: true, trailing: false})

initHallPlugin = ($tgUrls) ->
    $tgUrls.update({
        "hall": "/hall"
    })

class HallAdmin
    @.$inject = [
        "$rootScope",
        "$scope",
        "$tgRepo",
        "$appTitle",
        "$tgConfirm",
        "$tgHttp",
    ]

    constructor: (@rootScope, @scope, @repo, @appTitle, @confirm, @http) ->
        @scope.sectionName = "Hall" #i18n
        @scope.sectionSlug = "hall" #i18n

        @scope.$on "project:loaded", =>
            promise = @repo.queryMany("hall", {project: @scope.projectId})

            promise.then (hallhooks) =>
                @scope.hallhook = {project: @scope.projectId}
                if hallhooks.length > 0
                    @scope.hallhook = hallhooks[0]
                @appTitle.set("Hall - " + @scope.project.name)

            promise.then null, =>
                @confirm.notify("error")

    testHook: () ->
        promise = @http.post(@repo.resolveUrlForModel(@scope.hallhook) + '/test')
        promise.success (_data, _status) =>
            @confirm.notify("success")
        promise.error (data, status) =>
            @confirm.notify("error")

module.controller("ContribHallAdminController", HallAdmin)

HallWebhooksDirective = ($repo, $confirm, $loading) ->
    link = ($scope, $el, $attrs) ->
        form = $el.find("form").checksley({"onlyOneErrorElement": true})
        submit = debounce 2000, (event) =>
            event.preventDefault()

            return if not form.validate()

            $loading.start(submitButton)

            if not $scope.hallhook.id
                promise = $repo.create("hall", $scope.hallhook)
                promise.then (data) ->
                    $scope.hallhook = data
            else if $scope.hallhook.url
                promise = $repo.save($scope.hallhook)
                promise.then (data) ->
                    $scope.hallhook = data
            else
                promise = $repo.remove($scope.hallhook)
                promise.then (data) ->
                    $scope.hallhook = {project: $scope.projectId}

            promise.then ->
                $loading.finish(submitButton)
                $confirm.notify("success")

            promise.then null, (data) ->
                $loading.finish(submitButton)
                form.setErrors(data)
                if data._error_message
                    $confirm.notify("error", data._error_message)

        submitButton = $el.find(".submit-button")

        $el.on "submit", "form", submit
        $el.on "click", ".submit-button", submit

    return {link:link}

module.directive("contribHallWebhooks", ["$tgRepo", "$tgConfirm", "$tgLoading", HallWebhooksDirective])

module.run(["$tgUrls", initHallPlugin])
