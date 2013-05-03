---
---

App =
  Github: {}
  Instagram: {}
  Pizza: {}

App.Github.starredRepos = (options = {}) ->

  YUI().use 'jsonp', 'node', 'handlebars', (Y) ->

    options = Y.merge(
      login: 'mojombo'
      template: '{{name}}'
      target_selector: null
      sort_by: 'watchers_count desc'
      on_complete: ->
    , options)

    compare = (a, b) ->
      [key, dir] = options.sort_by.split(' ')
      order = if dir == 'desc' then -1 else 1
      if a[key] < b[key]
        return -1 * order
      if a[key] > b[key]
        return 1 * order
      return 0;

    template = Y.Handlebars.compile options.template

    Y.jsonp "https://api.github.com/users/#{options.login}/starred?per_page=100&callback={callback}", (data) ->

      html = []

      Y.each data.data.sort(compare), (repo) ->
        if repo.owner.login == options.login && repo.fork == false
          html.push(template(repo))

      if options.target_selector
        Y.one(options.target_selector).set('innerHTML', html.join(''))
      else
        console.log html.join('')

      if Y.Lang.isFunction(options.on_complete)
        options.on_complete()

      return

App.Instagram.latestPhotos = (options = {}) ->

  YUI().use 'jsonp', 'node', 'handlebars', (Y) ->

    options = Y.merge(
      user_id: '3'
      template: '<img src="{{images.thumbnail.url}}">'
      target_selector: null
      sort_by: 'likes.count desc'
      count: 10,
      on_complete: ->
    , options)

    compare = (a, b) ->
      [key, dir] = options.sort_by.split(' ')
      order = if dir == 'desc' then -1 else 1
      if a[key] < b[key]
        return -1 * order
      if a[key] > b[key]
        return 1 * order
      return 0;

    template = Y.Handlebars.compile options.template

    Y.jsonp "https://api.instagram.com/v1/users/579661/media/recent/?access_token=579661.0d50162.5588cee1b2ae4fd6995e7fa5e6e966eb&count=#{options.count}&callback={callback}", (response) ->

      html = []

      Y.each response.data.sort(compare), (photo) ->
        html.push(template(photo))

      if options.target_selector
        Y.one(options.target_selector).set('innerHTML', html.join(''))
      else
        console.log html.join('')

      if Y.Lang.isFunction(options.on_complete)
        options.on_complete()

      return

window.App = App
