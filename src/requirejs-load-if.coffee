define(['module'], (module) ->
  globalConfig = require.s.contexts._.config

  return {
    load: (name, require, onload, config) ->
      defaultCheck = (name, module, require) ->
        if module.config()?.everything
          return true

        defined = module.config()?.defined ? true
        if defined != false and ((defined == true) or (defined.indexOf(name) != -1)) and require.defined(name)
          return true

        specified = module.config()?.specified ? true
        if specified != false and ((specified == true) or (specified.indexOf(name) != -1)) and require.specified(name)
          return true

        path = module.config()?.path ? true
        if path != false and (((path == true) and ({}.hasOwnProperty.call(globalConfig.paths, name))) or (Array.isArray(path) and path.indexOf(name) != -1))
          return true

        return false

      load = if module.config()?.if?
        module.config().if(name, module, require, defaultCheck)
      else
        defaultCheck(name, module, require)

      if not load
        onload()
        require.undef('load-if!' + name)
      else
        require([name], (loadedModule) ->
          onload(loadedModule)
        )

      return
  }
)
