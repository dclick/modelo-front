'use strict'

angular.module('sescMotoFrete')
  .service '$noty', ()->

    defaults = {
      "text"                    : null
      "layout"                  : "center"
      "theme"                   : "noty_theme_twitter"
      "type"                    : null
      "animateOpen"             : {"height":"toggle"}
      "animateClose"            : {"height":"toggle"}
      "speed"                   : 500
      "timeout"                 : 2000
      "closeButton"             : true
      "closeOnSelfClick"        : false
      "closeOnSelfOver"         : false
      "modal"                   : false
    }

    execute = (text, type, options)->

      return unless noty?

      obj =
        text: text
        type: type

      if options
        _.defaults obj, options


      do $.noty.closeAll

      noty _.extend defaults, obj

    {
      info: (text, options)->
        execute text, 'information', options

      error: (text, options)->
        execute text, 'error', options

      success: (text, options)->
        execute text, 'success', options

    }