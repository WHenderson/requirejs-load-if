define(['module'], function(module) {
  var globalConfig;
  globalConfig = require.s.contexts._.config;
  return {
    load: function(name, require, onload, config) {
      var defaultCheck, load, ref;
      defaultCheck = function(name, module, require) {
        var defined, path, ref, ref1, ref2, ref3, ref4, ref5, ref6, specified;
        if ((ref = module.config()) != null ? ref.everything : void 0) {
          return true;
        }
        defined = (ref1 = (ref2 = module.config()) != null ? ref2.defined : void 0) != null ? ref1 : true;
        if (defined !== false && ((defined === true) || (defined.indexOf(name) !== -1)) && require.defined(name)) {
          return true;
        }
        specified = (ref3 = (ref4 = module.config()) != null ? ref4.specified : void 0) != null ? ref3 : true;
        if (specified !== false && ((specified === true) || (specified.indexOf(name) !== -1)) && require.specified(name)) {
          return true;
        }
        path = (ref5 = (ref6 = module.config()) != null ? ref6.path : void 0) != null ? ref5 : true;
        if (path !== false && (((path === true) && ({}.hasOwnProperty.call(globalConfig.paths, name))) || (Array.isArray(path) && path.indexOf(name) !== -1))) {
          return true;
        }
        return false;
      };
      load = ((ref = module.config()) != null ? ref["if"] : void 0) != null ? module.config()["if"](name, module, require, defaultCheck) : defaultCheck(name, module, require);
      if (!load) {
        onload();
        require.undef('load-if!' + name);
      } else {
        require([name], function(loadedModule) {
          return onload(loadedModule);
        });
      }
    }
  };
});
