assert = require('chai').assert
requirejs = require('requirejs')
path = require('path')

suite('coverage', () ->

  requirejs.config({
    baseUrl: path.join(__dirname, 'fixtures')
    paths: {
      'load-if': path.join(__dirname, '../dist/requirejs-load-if')
      'a': 'a'
    },
    waitSeconds: 0
  })

  suite('fixtures', () ->
    suiteSetup(() ->
      return
    )

    test('test module a', (cb) ->
      requirejs(['a'], (a) ->
        assert.equal(a, 'a')
        cb()
      )
      return
    )

    test('test module b', (cb) ->
      requirejs(['b'], (b) ->
        assert.equal(b, 'b')
        cb()
      )
      return
    )

    suiteTeardown(() ->
      requirejs.undef('a')
      requirejs.undef('b')
      return
    )
  )

  suite('no config', (cb) ->
    suiteSetup(() ->
      return
    )

    test('no path', (cb) ->
      requirejs(['load-if!a'], (a) ->
        assert.equal(a, 'a')
        cb()
      )
      return
    )

    test('with path', (cb) ->
      requirejs(['load-if!b'], (b) ->
        assert.isUndefined(b)
        cb()
      )
      return
    )

    suiteTeardown(() ->
      requirejs.undef('a')
      requirejs.undef('b')
      requirejs.undef('load-if!a')
      requirejs.undef('load-if!b')
      delete requirejs.s.contexts._.config.paths.b
      return
    )
  )

  suite('ignore', (cb) ->
    suiteSetup(() ->
      requirejs.s.contexts._.config.config = {
        'load-if': {
          defined: false
          specified: false
          path: false
        }
      }
      return
    )

    test('no path', (cb) ->
      requirejs(['load-if!a'], (a) ->
        assert.isUndefined(a)
        cb()
      )
      return
    )

    test('with path', (cb) ->
      requirejs(['load-if!b'], (b) ->
        assert.isUndefined(b)
        cb()
      )
      return
    )

    suiteTeardown(() ->
      requirejs.undef('a')
      requirejs.undef('b')
      requirejs.undef('load-if!a')
      requirejs.undef('load-if!b')
      delete requirejs.s.contexts._.config.config
      return
    )
  )

  suite('only defined', (cb) ->
    suiteSetup(() ->
      requirejs.s.contexts._.config.config = {
        'load-if': {
          defined: true
          specified: false
          path: false
        }
      }
      return
    )

    test('no path', (cb) ->
      requirejs(['load-if!b'], (b) ->
        assert.isUndefined(b)

        requirejs(['b'], (b) ->
          assert.equal(b, 'b')

          requirejs(['load-if!b'], (b) ->
            assert.equal(b, 'b')

            return cb()
          )
          return
        )
        return
      )
      return
    )

    suiteTeardown(() ->
      requirejs.undef('a')
      requirejs.undef('b')
      requirejs.undef('load-if!a')
      requirejs.undef('load-if!b')
      delete requirejs.s.contexts._.config.config
      return
    )
  )

  ###
  suite('only specified', (cb) ->
    suiteSetup(() ->
      requirejs.s.contexts._.config.config = {
        'load-if': {
          defined: false
          specified: true
          path: false
        }
      }
      return
    )

    test('no path', (cb) ->
      requirejs(['load-if!b', 'b'], (b, b2) ->
        assert.equal(b, 'b')
        assert.equal(b2, 'b')

        cb()
        return
      )
      return
    )

    suiteTeardown(() ->
      requirejs.undef('a')
      requirejs.undef('b')
      requirejs.undef('load-if!a')
      requirejs.undef('load-if!b')
      delete requirejs.s.contexts._.config.config
      return
    )
  )
  ###
)
